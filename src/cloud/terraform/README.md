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

:::tip
Wil je een individuele resource laten verwijderen en terug laten aanmaken? Je kan met `terraform taint` een resource tainten. Dit zorgt ervoor dat Terraform deze resource verwijdert opnieuw aanmaakt bij de volgende apply.
:::

#### Null-Resource

### Modules

## Plan Apply Destroy Repeat

## Change

in-place vs recreate

## Deploy

## Destroy

:::note Hint
We hebben nu heel wat code! Dit is een goed moment om een Git commit te maken.
:::

## State

### Remote State

### Locking

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

## Mag het wat meer zijn?

De [Hashicorp Learn](https://learn.hashicorp.com/terraform) site heeft vele praktische voorbeelden en tutorials voor verschillende providers.

