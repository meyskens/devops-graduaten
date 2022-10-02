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

### Vars

### Resources

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

## Mag het wat meer zijn?

De [Hashicorp Learn](https://learn.hashicorp.com/terraform) site heeft vele praktische voorbeelden en tutorials voor verschillende providers.

