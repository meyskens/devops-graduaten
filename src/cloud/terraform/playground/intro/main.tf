

terraform {
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

provider "oci" {
  # Configuration options
  region              = "eu-amsterdam-1"
  auth                = "SecurityToken" # oci session authenticate
  config_file_profile = "DEFAULT"
}


provider "aws" {
  region = "us-east-1"
}

data "oci_identity_availability_domains" "availability_domains" {
  compartment_id = "ocid1.tenancy.oc1..aaaaaaaaaqbulgzz6rdchxxuvevhrzbjsnivznt4tdsgdwtvoylfhfslntfq"
}

resource "oci_core_vcn" "vcn" {
  #Required
  compartment_id = "ocid1.tenancy.oc1..aaaaaaaaaqbulgzz6rdchxxuvevhrzbjsnivznt4tdsgdwtvoylfhfslntfq"
  cidr_block     = "10.0.0.0/16"
}

resource "oci_core_subnet" "subnet" {
  #Required
  compartment_id      = "ocid1.tenancy.oc1..aaaaaaaaaqbulgzz6rdchxxuvevhrzbjsnivznt4tdsgdwtvoylfhfslntfq"
  availability_domain = data.oci_identity_availability_domains.availability_domains.availability_domains.0.name
  cidr_block          = "10.0.1.0/24"
  vcn_id              = oci_core_vcn.vcn.id
}

data "oci_core_images" "ubuntu" {
  compartment_id           = "ocid1.tenancy.oc1..aaaaaaaaaqbulgzz6rdchxxuvevhrzbjsnivznt4tdsgdwtvoylfhfslntfq"
  operating_system         = "Canonical Ubuntu"
  operating_system_version = "22.04"
  shape                    = "VM.Standard.E2.2"
}

resource "oci_core_instance" "app-instance" {
  for_each            = toset(["wp", "db"])
  availability_domain = data.oci_identity_availability_domains.availability_domains.availability_domains.0.name
  compartment_id      = "ocid1.tenancy.oc1..aaaaaaaaaqbulgzz6rdchxxuvevhrzbjsnivznt4tdsgdwtvoylfhfslntfq"
  display_name        = "test-tf-${each.key}"
  shape               = "VM.Standard.E2.2"

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.ubuntu.images.0.id
  }

  create_vnic_details {
    assign_public_ip = true
    subnet_id        = oci_core_subnet.subnet.id
  }
}
