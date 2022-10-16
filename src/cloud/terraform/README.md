# Terraform

![Terraform Logo](./logo.png)

Terraform beschijft zichzelf als "Provision, change, and version resources on any environment". Terraform is een tool die we gaan gebruiken voor het aanmaken van resources in de cloud als Infrastucture as Code. We kunnen met deze files resources aanmaken in 1 of meerdere cloud providers te gelijk. Dit gaat onderliggend de juiste APIs aanspreken. Tegelijk gaat Terraform de status van deze resources bijhouden net als hun dependancy onderliggend om doormiddel van een graph systeem te bepalen welke acties er moeten worden uitgevoerd om de gewenste situatie te bereiken.

Wij gaan vooral een flow zien van code schrijven, plannen, applyen en controleren.

![Terraform Flow](./flow.png)

In de flow staan twee commando's centraal:

-   `plan` is de fase waarin Terraform bekijkt welke aanpassingen nodig zijn en geeft ons een lijst
    -   dit lijkt onbelangrijk maar we moeten dit steeds goed nakijken dat we niet door een fout resources in productie verwijderen
-   `apply` is de fase waarin Terraform de aanpassingen uitvoert en de resources aanmaakt of aanpast

## Registry

Terraform werkt niet alleen. Sinds recent versies heeft Terraform een "Registry" waarin je modules kan vinden die je kan gebruiken. Je kan deze vinden op [registry.terraform.io](https://registry.terraform.io/).

We vinden hier `providers` dit zijn integraties met platformen als AWS, GCP, Azure, OCI, etc. We zien hier ook vaak meer providers voor software als Docker, Kubernetes of Cloudflare.
Aan de andere kant vinden we ook `modules` voor veel gebruikte compomenten in deze providers. Denk hierbij aan een Kubernetes cluster, of een kant en klare VM setup inclusief netwerk. Een module gaat dus meerdere componenten integreren. Maar daarover verder meer!

## Installatie

We hebben Terraform nodig op onze laptop, we zetten dit weer op als gewoonlijk. We voegen een APT repo toe:

```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt-get install terraform
```

Als we nu `terraform version` uitvoeren zien we dat we de laatste versie hebben!

## Build

Tijd voor een Terraform project op te zetten! We maken hiervoor best een nieuwe map (in een Git Repo, hint hint) aan. We gaan hierin werken om code te schrijven en te testen.

Terraform bestanden hebben de extensie `.tf` en we maken een bestand aan met de naam `main.tf`. In dit bestand gaan we de eerste code schrijven.

We gaan in deze files [HCL](https://github.com/hashicorp/hcl#information-model-and-syntax) of de Hashicorp Configuration Language schrijven, dit is een afgeleide van JSON. Het heeft een unieke structuur van resource defenitiies en sub-configuraties. We komen nog heel wat voorbeelden tegen.

Voorbeeld van HCL:

```hcl
type "resource name" "name" {
  key = "value"

  object = {
    key = "value"
  }

  list = [
    "value",
    "value",
  ]

  sub_block {
    key = "value"
  }
}
```

### `terraform {} block`

Het eerste wat we gaan doen is een `terraform {}` block toevoegen. Dit is een block die we gebruiken om Terraform te configureren. We gaan een aantal dingen hier vermelden, onderandere welke providers en hub versie we gebruiken maar bijvoorbeeld ook welke minimale versie van Terraform nodig is. Later gaan we hier ook aangeven waar onze huidige state file te plaatsen.

```hcl
terraform {
  required_version = ">= 1.0.0"
}
```

Dit block is altijd verplicht om te hebben per Terraform Project.

### Providers

We gaan ook altijd een `provider` nodig hebben. Een provider gaat onze link tussen een onderliggende API zoals die van een cloud provider en tussen onze Terraform instantie zijn. We vinden deze op de Terraform registry. We hebben hieronder voorbeelden voor AWS an OCI:

We halen in `required_providers` de versie op die we willen gebruiken. Terraform gaat deze automatisch voor ons downloaden van de registry.
Hierna stellen we deze in via het `provider` block.

:::: code-group
::: code-group-item AWS

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}


provider "aws" {
  region = "us-east-1" # regio voor AWS Academy
}
```

We zien hier dat we de AWS provider onze regio configuratie hebben gegeven die nodig is voor het aanmaken van resources.
Je hebt ook credentials nodig. Deze gaat Terraform halen vanuit je `~/.aws/credentials` bestand. Je kan deze ook manueel meegeven maar dit is niet altijd even handig.

:::
::: code-group-item Oracle

```hcl
terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "4.96.0"
    }
  }
}

provider "oci" {
  # Configuration options
  region              = "eu-amsterdam-1"
  auth                = "SecurityToken" # oci session authenticate
  config_file_profile = "DEFAULT"
}
```

We zien hier dat we onze regio hebben meegegeven als ook welke auth methode te gebruiken, Oracle heeft er verschillende. Wij opteren voor de `SecurityToken` methode. Deze gaat een token genereren en gebruiken om te authenticeren via het `oci session authenticate` commando (zie hoodfstuk gebruik).
:::
::::

### Variablen

Net als in elke programmeertaal gaan we variablen tegenkomen. We kunnen deze gebruiken om dynamische waarden mee te geven aan onze configuratie of veelgebruikte elementen als een regio of een account ID te centraliseren.

```hcl
variable "aws_region" {
  type        = string
  description = "The AWS region to deploy to"
  default     = "us-east-1"
}

variable "tenancy_ocid" {
  type        = string
  description = "The tenancy OCID for Oracle Cloud"
  default     = "ocid1.tenancy.oc1..aaaaaaaaxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}
```

We zien dat variablen gedefinieerd worden met een `variable "name"` block. Dit block bevat:

-   `type` - De type van de variabele, dit kan een string, number, bool, list of map zijn.
-   `description` - Een beschrijving van de variabele voor de gebruiker.
-   `default` - Een default waarde voor de variabele.

We kunnen deze variablen gebruiken in onze configuratie door ze te gebruiken met `var.name` of `${var.name}` in een string.

```hcl
provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "example" {
  name = "example-${var.aws_region}"
}
```

We kunnen met `default` de waarde meegeven maar we kunnen deze ook aanpassen via de command line, environment variables of een `.tfvars` bestand.

```bash
terraform plan -out plan.out  -var="aws_region=eu-west-1"
```

of in `staging.tfvars`:

```ini
aws_region = "eu-west-1"
```

en dan:

```bash
terraform plan -out plan.out -var-file="staging.tfvars"
```

(standaard wordt `terraform.tfvars` ingelezen als het bestaat)

of via een environment variable:

```bash
export TF_VAR_aws_region="eu-west-1"
terraform plan -out plan.out
```

:::tip
We hebben ook [local variables](https://www.terraform.io/language/values/locals) die we intern gebruiken voor snel een waarde mee te geven die de gebruiker niet hoeft aan te passen.

Wanneer we met modules werken of output willen geven gaan we ook [output variablen](https://www.terraform.io/language/values/outputs) tegenkomen.
:::

### Data Sources

We gaan ook data nodig hebben die van onze provider gaat komen. Dit zijn vaak reeds bestaande resources, of interne IDs maar ook vaak informatie die we nodig hebben om een resource aan te maken die variabel is, denk bijvoorbeeld aan welke OS image we willen gebruiken.

Data sources mogen dus nooit objecten aanmaken maar roepen wel de API op voor gegevens op te halen.

We herkennen deze door het `data "type" "name"` block:

```hcl
data "oci_core_images" "ubuntu" {
  compartment_id           = var.tenancy_ocid
  operating_system         = "Canonical Ubuntu"
  operating_system_version = "22.04"
  shape                    = "VM.Standard.E2.2"
}
```

In dit voorbeeld zoeken we de image voor Ubuntu 22.04 die werkt voor een VM.Standard.E2.2 VM. We vinden de output en nodige input op de [provider documentatie voor oci_core_images](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/core_images). We lezen hier dat we een list van images terugkrijgen en dat we de `id` van de eerste image kunnen gebruiken om een VM aan te maken.

```hcl
resource "oci_core_instance" "server" {
  [...]

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.ubuntu.images.0.id # element 0 van de lijst van images met property ID
  }
}
```

We kunnen deze net als variablen gaan aanhalen met `data.type.name.property` of `${data.type.name.property}` in een string.

### Resources

De bovste elementen hebben we nodig voor het opzetten van onze infrastructuur.
De eigenlijke infrastructuur elementen gaan we in resources gaan definieren. Deze resources kunnen we aanmaken, updaten of verwijderen (de developers die dit lezen roepen nu enorm hard [CRUD](https://www.codecademy.com/article/what-is-crud)).

We herkennen deze door het `resource "type" "name"` block:

```hcl
resource "oci_core_instance" "app-instance" {
  count               = 2
  availability_domain = data.oci_identity_availability_domains.availability_domains.availability_domains.0.name
  compartment_id      = "ocid1.tenancy.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  display_name        = "test-tf-${count.index}"
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
```

Net als diensten in een cloud provider hebben we enorm veel resources beschikbaar, we vinden al deze in de provider documentatie. Bijvoorbeld voor [OCI](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources) of [AWS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources).

### Loops met `count` en `for_each`

Resources hebben ook altijd een `count` parameter, hiermee kunnen we een resource verschillende keren gaan aanmaken. We kunnen dit gebruiken om bijvoorbeeld een aantal servers aan te maken die gelijk zijn voor loadbalancing.
In een count loop heb je meestal ook een index parameter `count.index` die je kan gebruiken voor een unieke eigenschap

Recente versies van Terraform hebben ook [`for_each`](https://www.terraform.io/language/meta-arguments/for_each) hiermee kan je een resource aanmaken voor elk element in een lijst. Je kan het met de parameter `each` opvragen.

```hcl
resource "oci_core_instance" "app-instance" {
  for_each            = toset(["wp", "db"]) # for_each is een set (key/value) type, met toset() kunnen we een lijst omzetten naar een set

  display_name        = "test-tf-${each.key}"
  shape               = "VM.Standard.E2.2"

  [...]
}
```

#### Arguments and Attributes

In resourced gaan we 2 types data vinden:

-   arguments: dit zijn de properties die we moeten meegeven om een resource aan te maken
-   attributes: dit zijn de properties die we krijgen van onze provider NA het aanmaak van een resource, denk bijvoorveeld aan een IP adres of een ID

Beide types vinden we gedocumenteerd in de Terraform Provider documentatie.

We kunnen beide types gaan oproepen in andere resources voor informatie te krijgen over een resource:

```hcl
resource "oci_core_subnet" "subnet" {
  [...]
  cidr_block          = "10.0.1.0/24"
  vcn_id              = oci_core_vcn.vcn.id
}

resource "oci_core_instance" "server" {
  [...]
  create_vnic_details {
    assign_public_ip = true
    subnet_id        = oci_core_subnet.subnet.id
  }
}
```

Tegenovergesteld aan `data` of `var` hebben we geen prefix nodig, we gebruiken gewoon `resourcetype.name.property`.
`.id` in dit voorbeeld is een attribute en zal dus pas worden ingevuld na het aanmaken van de resource, dit gaat dus bepalen dat onze server pas wordt aangemaakt nadat de subnet is aangemaakt!

#### Provisioners

Bij het aanmaken van resources kunnen we ook een actie laten uitvoeren ofwel lokaal ofwel via SSH. Dit noemen we een [provisioner](https://www.terraform.io/language/resources/provisioners/syntax).

We hebben twee belangrijke types: `local-exec` en `remote-exec`. De local versie gaat commando's op onze eigen laptop gaan uitvoeren, dit kan handig zijn voor een lokaal script of file te updaten.

Met een `remtoe-exec` gaan we een commando op de server zelf gaan uitvoeren, dit kan handig zijn om een package te installeren of een configuratie file te updaten of het starten van een automatisatie process.

Provisioners worden **enkel** uitgevoerd bij het aanmaken van een resource, niet bij het updaten of verwijderen. Het is dus een hulpmidel maar geen vervanging van tools als Ansible.

```hcl
resource "oci_core_instance" "server" {
  [...]

  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> inventory"
  }

  provisioner "remote-exec" {

    connection {
      host = self.public_ip
      type = "ssh"
      user = "ubuntu"
    }

    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx"
    ]
  }
}
```

:::tip
Provisioners zijn een last resort, en worden best gebruikt waar geen alternatieven mogelijk zijn. Ze blijven wel belangrijk in het ecosysteem. Voor simpele acties raden we aan om VM images te gebruiken of [cloud-init](https://learn.hashicorp.com/tutorials/terraform/cloud-init?in=terraform/provision) in de metadata van een VM te zetten.
Voor complexere acties is Ansible aan te raden.
:::

##### Null-Resource

Moet je een provisioner uitvoeren op een resource die je niet kan aanmaken via Terraform? Dan kan je een [null_resource](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) aanmaken en deze als trigger gebruiken voor je provisioner.

```hcl
resource "null_resource" "provisioner" {
  triggers = {
    id = oci_core_instance.server.id # trigger on making or changes of a server
  }

  provisioner "remote-exec" {
    connection {
      host = "db.example.com"
      type = "ssh"
      user = "ubuntu"
    }

    inline = [
      "sudo ufw allow 3306 from ${oci_core_instance.server.public_ip}",
    ]
  }
}
```

### Modules

In Terraform heb je ook libraries, een collectie van veel samen gebruikte resources. Deze noemen we modules. Modules zijn een goede manier om code te hergebruiken en te structureren. Je kan deze [zelf maken ](https://www.terraform.io/language/modules/develop) of bestaande gebruiken van de [Terraform Registry](https://registry.terraform.io/browse/modules).

We werken iedentiek hetzelfde als met resources alleen gebruiken we het `module` keyword, alsook moeten we een source meegeven.

```hcl
module "lambda_function_container_image" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "my-lambda-existing-package-local"
  description   = "My awesome lambda function"

  create_package = false

  image_uri    = "132367819851.dkr.ecr.eu-west-1.amazonaws.com/complete-cow:1.0"
  package_type = "Image"
}
```

Dit voorbeeld zet AWS Lambda op, een serverless compute service die code kan uitvoeren on demand.

## Plan Apply Destroy Repeat

Nu we weten hoe we Terraform files kunnen maken moeten we weten hoe we ze gaan uitvoeren.

Voor we aan de slag gaan zetten we een lege map op met daarin een `main.tf` file.

:::: code-group
::: code-group-item AWS

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    },
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 80
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 80
    }
  ]
}


data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  key_name = aws_key_pair.deployer.key_name

  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.main.id]
}

```

:::
::: code-group-item OCI

```hcl
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

variable "tenancy_ocid" {
  type        = string
  description = "The tenancy OCID"
  default     = "ocid1.tenancy.oc1..aaaaaaaaxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
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
```

:::
::::

Nu we een terraform file hebben kunnen we deze gaan uitvoeren.

**Stap 1: **

```bash
terraform init
```

Dit commando zorgt ervoor dat Terraform de benodigde providers gaat downloaden en de benodigde plugins gaat installeren.

**Stap 2: **

```bash
terraform plan -out=plan.out
```

Dit gaat een plan maken van de resources die we willen aanmaken/verwijderen/wijzigen. Het plan wordt opgeslagen in een file genaamd `plan.out`.

```
$ terraform plan -out plan.out
data.oci_core_images.ubuntu: Reading...
data.oci_identity_availability_domains.availability_domains: Reading...
data.oci_identity_availability_domains.availability_domains: Read complete after 0s [id=IdentityAvailabilityDomainsDataSource-2885296548]
data.oci_core_images.ubuntu: Read complete after 0s [id=CoreImagesDataSource-463958282]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # oci_core_instance.web will be created
  + resource "oci_core_instance" "web" {
      + availability_domain                 = "MqjG:eu-amsterdam-1-AD-1"
      + display_name                        = "web"
      + private_ip                          = (known after apply)
      + public_ip                           = (known after apply)
      + region                              = (known after apply)
      + shape                               = "VM.Standard.A1.Flex"
      [...]
     }

Plan: 3 to add, 0 to change, 0 to destroy.
```

Je krijgt een lijst van alle wijzegingen alsook een samenvatting, belangrijk is dat je dit gaat nalezen!

**Stap 3: **

Met de apply stap gaan we nu de resources echt aanmaken!

```bash
terraform apply plan.out
```

We gaan live de status kunnen volgen, sommige resources als VMs kunnen eventjes duren maar Terraform zal hierop wachten.

```
oci_core_instance.web: Creating...
oci_core_instance.web: Still creating... [10s elapsed]
oci_core_instance.web: Still creating... [20s elapsed]
oci_core_instance.web: Still creating... [30s elapsed]
```

Als alles klaar is zijn de resources aangemaakt!

### Change

We kunnen nu wijzegingen gaan maken aan de resources die we hebben aangemaakt. Als we nu een Terraform plan en appl gaan doen gaat Terraform kijken wat te wijzigen waar nodig. Er kunnen 2 scenario's zijn:

-   `in-place` wijzigingen, dit zijn wijzigingen die je kan doen zonder dat de resource vernieuwd wordt. Denk hierbij aan het wijzigen van een tag of het toevoegen van een extra disk.
-   `recreate` wijzigingen, dit zijn wijzigingen die je kan doen maar waarbij de resource opnieuw aangemaakt moet worden, meestal is dit omdat de cloud provider niet ondersteund dat je die eigenschap kan wijzigen.

Pas nu de firewall aan om ook poort 443 open te zetten. Je zal merken dat Terraform dit nu in-place gaat updaten.

:::tip
Wil je een individuele resource laten verwijderen en terug laten aanmaken? Je kan met `terraform taint` een resource tainten. Dit zorgt ervoor dat Terraform deze resource verwijdert opnieuw aanmaakt bij de volgende apply.
:::

### Destroy

We kunnen even vlot al onze cloud resources verwijderen als we ze hebben aangemaakt, dit is enorm handig voor krediet te besparen in onze lessen als we de resources niet meer gebruiken.

```bash
terraform destroy
```

Met een simpele `yes` zijn al onze resources weer weg!

## State

Achterliggend gaat Terraform een database bijhouden van welke resources gemaakt zijn met alle gegevens hierover als IPs, IDs en eigenschappen. Deze database wordt de state genoemd. Deze state wordt opgeslagen in een file genaamd `terraform.tfstate` in de directory waar je Terraform uitvoert. Deze file is niet bedoeld om te bewerken, Terraform zal deze file updaten als je wijzigingen maakt. Achterliggend wordt hier een Graph database gebruikt om alle resources aan elkaar te linken, zo zal je een waaschuwing zien als je een verwijderdt die nodig is voor een andere component te doen werken.

### Remote State

Als je in een team werkt ga je dus niet met een lokale file kunnen werken aangezien deze essentieel is om te weten wat er al is gemaakt en waar alles staat.
Daarom gaan we hier werken met een remote state. Deze kan je opslaan in de cloud, we gebruiken hiervoor Object Storage!

::::code-group
:::code-group-item AWS

```hcl
terraform {
  backend "s3" {
    bucket = "terraform-state-<yourname>"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
```

:::
:::code-group-item OCI

```hcl
terraform {
  backend "s3" {
    endpoint   = "https://<bucket namespace>.compat.objectstorage.eu-amsterdam-1.oraclecloud.com"
    region     = "eu-amsterdam-1" # Region of Object Store Bucket
    bucket     = "terraform"
    key        = "<project name>/terraform.tfstate"

    access_key = "<they key ID>"
    secret_key = "<the secret key>"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }
}
```

We maken een [Bucket](https://cloud.oracle.com/object-storage/buckets?region=eu-amsterdam-1) aan met de naam `terraform`.
Nu moeten we een statische login maken onder Identity -> Users -> User Details -> Customer Secret Keys. Kopieer de secret key meteen dat is onze `secret_key`. In de lijst staat nu een key ID dat is onze `access_key`.

:::
::::

### Locking

Nu we een remote state hebben gaat Terraform hier bij het aanmaken ook een lock file in zetten. Dit gaat verhinderen dat twee gebruikers tegelijk een apply kunnen uitvoeren op hetzelfde project en dezelfde cloud resources!

## Terraform + Ansible (aka "The TerrIble stack")

We kennen nu Terraform al, we hebben in vorige delen naar Ansible gekeken. Laten we ze nu eens combineren.
We maken een Terraform file waar we een Amazon EC2 VM aanmaken:

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    },
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 80
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 80
    }
  ]
}


data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  key_name = aws_key_pair.deployer.key_name

  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.main.id]

  provisioner "remote-exec" {
    inline = ["sudo apt update", "DEBIAN_FRONTEND=noninteractive sudo apt install python3 -y", "echo Done!"]

    connection {
      host        = self.public_ip
      type        = "ssh"
      user        = "ubuntu"
    }
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i '${self.public_ip},' nginx-install.yaml"
  }
}
```

Wat is hier nieuw? We roepen 2 provisioners op: de `remote-exec` provisioner SSHed naar de VM en zorgt ervoor dat Python3 geïnstalleerd is.
De `local-exec` provisioner (dus code die op onze laptop gaat draaien) gaat een Ansible playbook draaien met de VM als target.

In de file `nginx-install.yaml` staat het volgende:

```yaml
- hosts: all # installer dit op all hosts onder "servers:
  tasks:
      - name: Install Nginx
        become: yes
        apt:
            name: nginx
            state: present
            update_cache: yes
      - name: Edit index.html
        become: yes
        copy:
            content: "Hello from Terraform and Ansible"
            dest: /var/www/html/index.html
```

Na een `terraform apply` kan je zien dat na het opstarten van de VM Ansible draait en Nginx installeert. Bezoek het IP-adres van de VM in je browser en je ziet de tekst "Hello from Terraform and Ansible".

We kunnen nu dus servers gaan aanmaken met Terraform en de software installeren met Ansible. Dit is een heel krachtige combinatie die onze hele workflow kan automatiseren!

:::note Hint
We hebben nu heel wat code! Dit is een goed moment om een Git commit te maken.
:::

## Voorbeelden?

-   [https://github.com/oracle/terraform-provider-oci/tree/master/examples](https://github.com/oracle/terraform-provider-oci/tree/master/examples)
-   [https://github.com/ContainerSolutions/terraform-examples/tree/main/aws](https://github.com/ContainerSolutions/terraform-examples/tree/main/aws)

## Mag het wat meer zijn?

De [Hashicorp Learn](https://learn.hashicorp.com/terraform) site heeft vele praktische voorbeelden en tutorials voor verschillende providers.

