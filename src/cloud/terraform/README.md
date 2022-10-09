# Terraform

![Terraform Logo](./logo.png)

Terraform beschijft zichzelf als "Provision, change, and version resources on any environment". Terraform

![Terraform Flow](./flow.png)

## Registry

## Installatie

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

## Build

### `terraform {} block`

### Providers

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
```

Je hebt ook credentials nodig. Deze gaat Terraform halen vanuit je `~/.aws/credentials` bestand.

:::
::::

### Vars

### Resources

:::tip
Wil je een individuele resource laten verwijderen en terug laten aanmaken? Je kan met `terraform taint` een resource tainten. Dit zorgt ervoor dat Terraform deze resource verwijdert opnieuw aanmaakt bij de volgende apply.
:::

#### Null-Resource

### Loops

### Modules

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

