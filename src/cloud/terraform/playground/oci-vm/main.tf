terraform {
  backend "s3" {
    endpoint = "https://axy28nsrqpfo.compat.objectstorage.eu-amsterdam-1.oraclecloud.com"
    region   = "eu-amsterdam-1" # Region of Object Store Bucket
    bucket   = "terraform"
    key      = "oci-vm/terraform.tfstate"


    access_key = "8b6813e47b7c3daec0f21bd907e30d211ed43fb9"
    secret_key = ""

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "4.96.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "4.34.0"
    }
  }

  required_version = ">= 1.0.0"
}

variable "tenancy_ocid" {
  type        = string
  description = "The tenancy OCID"
  default     = "ocid1.tenancy.oc1..aaaaaaaaaqbulgzz6rdchxxuvevhrzbjsnivznt4tdsgdwtvoylfhfslntfq"
}

variable "vm_shape" {
  type        = string
  description = "The shape of the VM"
  default     = "VM.Standard.A1.Flex"
}

provider "oci" {
  # Configuration options
  region              = "eu-amsterdam-1"
  auth                = "SecurityToken" # oci session authenticate
  config_file_profile = "DEFAULT"
}


data "oci_identity_availability_domains" "availability_domains" {
  compartment_id = var.tenancy_ocid
}

resource "oci_core_vcn" "vcn" {
  #Required
  compartment_id = var.tenancy_ocid
  cidr_block     = "10.0.0.0/16"
}


# allow port 80 
resource "oci_core_security_list" "web" {
  #Required
  compartment_id = var.tenancy_ocid
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "web"
  ingress_security_rules {
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = "6" # TCP
    tcp_options {
      max = 80
      min = 80
    }
  }

  ingress_security_rules {
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = "6" # TCP
    tcp_options {
      max = 22
      min = 22
    }
  }
}

resource "oci_core_internet_gateway" "internet_gateway" {
  compartment_id = var.tenancy_ocid
  vcn_id         = oci_core_vcn.vcn.id
}

resource "oci_core_route_table" "internet" {
  compartment_id = var.tenancy_ocid
  vcn_id         = oci_core_vcn.vcn.id

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.internet_gateway.id
  }
}


resource "oci_core_subnet" "subnet" {
  #Required
  compartment_id      = var.tenancy_ocid
  availability_domain = data.oci_identity_availability_domains.availability_domains.availability_domains.0.name
  cidr_block          = "10.0.1.0/24"
  vcn_id              = oci_core_vcn.vcn.id
  route_table_id      = oci_core_route_table.internet.id
  security_list_ids = [
    oci_core_security_list.web.id
  ]
}

data "oci_core_images" "ubuntu" {
  compartment_id           = var.tenancy_ocid
  operating_system         = "Canonical Ubuntu"
  operating_system_version = "22.04"
  shape                    = var.vm_shape
}

resource "oci_core_instance" "web" {
  availability_domain = data.oci_identity_availability_domains.availability_domains.availability_domains.0.name
  compartment_id      = var.tenancy_ocid
  display_name        = "web"
  shape               = var.vm_shape

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.ubuntu.images.0.id
  }

  create_vnic_details {
    assign_public_ip = true
    subnet_id        = oci_core_subnet.subnet.id
  }

  shape_config {
    memory_in_gbs = 2
    ocpus         = 1
  }

  # Add SSH key
  extended_metadata = {
    ssh_authorized_keys = file("~/.ssh/id_rsa.pub")
  }
}
