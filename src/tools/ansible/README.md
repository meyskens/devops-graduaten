# Ansible

![Ansible Logo](./Ansible_logo.svg)

[Ansible](https://www.ansible.com/) is een open-source software provisioning, configuratie management, en applicatie-deployment tool die infrastructuur als code mogelijk maakt.
Het draait op alle Linux systemen (als ook Unix systemen) en Microsoft Windows, en kan deze ook configureren.
Het bevat een eigen declaratieve taal om systeemconfiguratie te beschrijven. Ansible is geschreven in 2013 door Michael DeHaan en in 2015 overgenomen door Red Hat die nu commerciele ondersteuning bied.
Voor ons is Ansible een handige tool omdat het agentless is. Het maakt tijdelijk op afstand verbinding via SSH of Windows Remote Management (waardoor PowerShell op afstand kan worden uitgevoerd) om zijn taken uit te voeren, tegenover sommige alternatieven als Chef of Puppet is voor Ansible op de server geen installatie nodig! Dit laat ons toe sneller servers op te zetten.

> In dit deel focussen we op het gebruik op Linux (meer bepaald Ubuntu). Windows installatie van Ansible is moeilijker.

Ansible gaat ons toelaten om in YAML formaat Linux en Windows servers te configureren. We kunnen bestanden aanmaken, configuratie aanpassen en software installeren. In vergelijking met een script is een paar verschillen:

Ansible laat ons toe meerdere servers tegelijk te configureren en beheren doormiddel van inventories.

Ansible checkt na het verbinden met je server wat al gebeurd is en zorgt dat je server bij elke Ansible-run op to date is met wat in je Ansible configuratie staat. Je kan dus gerust je installatie laten staan Ansible checkt dit steeds voor het uitvoeren. Dit laat je toe snel servers toe te voegen.

## Installatie

Ansible moeten we enkel installeren op de client. Hiervoor raad ik aan een Ubuntu Desktop te installeren.

Installeer Ansible via APT:

```bash
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

## Concepten

![architecture](./architecture.png)

Deze concepten komen voor in Ansible. Hiermee bouw je een Ansible setup op:

### Control node

Elke machine waarop Ansible is geïnstalleerd. Je kab Ansible-opdrachten en -playbooks uitvoeren door het `ansible` of `ansible-playbook` commando uit te voeren.
Vaak is dit onze laptop, maar het kan ook een andere server zijn waar heel je team aan kan.

### Managed nodes

Dit zijn de servers die je beheert met Ansible.
Managed nodes worden ook wel eens "hosts" genoemd. Ansible wordt niet geïnstalleerd op managed nodes.

### Inventory

Een lijst vanmanaged nodes. Een inventoryfile wordt ook wel eens een "hostfile" genoemd.
Je inventory kan informatie specificeren zoals IP adressen voor elke managed node. Een inventory kan ook beheemanaged rde nodes organiseren, groepen aanmaken en nesten voor eenvoudiger schalen.

### Modules

De eenheden van code die Ansible uitvoert. Elke module heeft een specifiek gebruik, van het beheren van gebruikers op een specifiek type database tot het beheren van VLAN-interfaces op een specifiek type netwerkapparaat. Je kan een enkele module aanroepen met een taak, of meerdere verschillende modules aanroepen in een playbook. Vele van deze modules worden meegeleverd of zijn te vinden op het internet. Deze modules besperen ons tijd door al expertise te gebruiken van mede-Ansible-gebruikers.

### Task

De eenheden van actie in Ansible. Je kan een enkele taak eenmalig uitvoeren met een ad-hoc commando.

### Playbooks

Geordende lijsten van tasks, opgeslagen zodat je die taken herhaaldelijk in die volgorde kunt uitvoeren. Playbooks kunnen zowel variabelen als taken bevatten.
Playbooks worden geschreven in YAML.

## Getting started

We hebben al Ansible geinstalleerd op onze Ubuntu desktop. We gaan enkele acties uitvoeren als demo van Ansible.
Om tijd te besparen in de les gaan we deze uitvoeren op dezelfde machine als waar we Ansible opdraaien.

We zorgen ervoor dat we naar onze eigen VM kunnen SSHen:

```bash
sudo apt-get update
sudo apt-get install -y openssh-server
ssh-keygen # en volg de stappen
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys # voeg je eigen publieke sleutel toe aan je eigen authorized keys
ssh localhost
```

Zie je een shell? Dan zijn we klaar om Ansible te gebruiken.

### Project opzetten

We maken een map aan waar we ons Ansible project in kunnen zetten. We openen de map hierna in een editor als Visual Studio Code.

Alseerst maken we een file met naam `hosts` (verander de username wel)

```
[servers]
127.0.0.1 ansible_user=maartje
```

Nu maken we een file met naam `ansible.cfg`

```
[defaults]
inventory = hosts
host_key_checking = False
```

Je kan nu zien of Ansible de hosts herkent:

```bash
$ ansible all --list-hosts
  hosts (1):
    127.0.0.1
```

We pingen (SSH test in dit geval) nu de servers:

```
$ ansible all -m ping
```

Nu maken we een file met naam `main.yml`

```
- hosts: servers # installer dit op all hosts onder "servers:
    tasks:
        - name: Create a directory if it does not exist
            file:
            path: /etc/http_files
            state: directory
        - name: Install Apache
            apt:
                name: apache2
                state: present
                update_cache: yes
                upgrade: yes
            become: yes
```

We voeren nu de file uit:

```
$ ansible-playbook main.yml
```
