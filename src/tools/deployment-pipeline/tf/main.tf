terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

variable "runner_token" {
  type        = string
  description = "The token for the GitHub Actions runner to use"
  default     = ""
}

variable "repo_url" {
  type        = string
  description = "The URL of the GitHub repo to use"
  default     = "https://github.com/xxx/xxx"
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
    },
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 27960
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 27960
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

resource "aws_instance" "quake" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.large"

  key_name = aws_key_pair.deployer.key_name

  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.main.id]

  user_data_replace_on_change = true

  user_data = <<-EOF
    #!/bin/bash
    # Install Docker
    wget -O docker.sh https://get.docker.com/
    bash docker.sh
    usermod -aG docker ubuntu
    # Install GH Actions Runner
    sudo -u ubuntu mkdir /home/ubuntu/actions-runner
    cd /home/ubuntu/actions-runner
    sudo -u ubuntu curl -o actions-runner-linux-x64-2.298.2.tar.gz -L https://github.com/actions/runner/releases/download/v2.298.2/actions-runner-linux-x64-2.298.2.tar.gz
    sudo -u ubuntu tar xzf ./actions-runner-linux-x64-2.298.2.tar.gz
    rm ./actions-runner-linux-x64-2.298.2.tar.gz
    sudo -u ubuntu ./config.sh --url ${var.repo_url} --token ${var.runner_token} --name "Github EC2 Runner3" --labels deploy --unattended
    ./svc.sh install
    ./svc.sh start
    EOF
}
