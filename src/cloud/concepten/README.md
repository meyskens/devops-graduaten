# Cloud Concepten

Wat is cloud computing? We horen er veel over, maar het antwoord is niet simpel te vormen. Allereerst moeten we de verschillende niveaus van cloud zoals beschreven in [Environments](../../concepts/environments/) in het achterhoofd houden.

Dan komen we zeer simpel uit dat een cloud provider een bedrijf is dat SaaS, PaaS or IaaS aanbied. Wat deze diensten inhouden gaan we in dieper op in in dit hoofdstuk. We leggen enkele grote cloud providers naast elkaar en bekijken dan de structuur die ze bijna allemaal delen. Pas als we wegwijs zijn in alle termen kunnen we in de praktijk aan de slag gaan.

## Providers

Een cloud provider is simpel gezegt een bedrijf dat voor jou(w bedrijf) dingen gaat hosten. Technisch gezien is zelfs een webhosting provider als [SIN](https://sinners.be) dus een cloud provider. Nu echter in de praktijk spreken we vaker eat een cloud provider meerdere diensten aanbied. In deze cursus gaan we ons vooral focussen op het domein van PaaS en IaaS, SaaS is een ander verhaal en valt niet geheel binnen het verhaal van deze cursus.

Elke cloud provider vult meestal een aantal taken in, vaak met een eigen toets. Zo heeft bijvoorveeld de "Login beheer" dienst van Microsoft Azure een diepere integratie met Windows Active Directory maar heeft Google dan weer een betere vertaal API service gebouwd uit hun ervaring met Google Translate.

Cloud providers diffentieren zichzelf vaak op de markt door diensten die ze kunnen aanbieden met kennis uit andere delen van het bedrijf. Hierdoor maken bedrijven vaak een keuze op welke cloud provider ze gaan gebruiken. Een tweede factor moeten we ook eerlijk over zijn: de prijs. Een gigabyte aan opslag bij AWS kost $0.023/GB/maand, bij Google $0.023, bij Oracle $0.0255 en bij Azure maar $0.021. Iemand met veel opslag noden zal dus eerder voor Azure gaan dan voor AWS. Maar de medaille heeft een keerzijde: willen we een VM huren met 4 CPU cores betalen we $0.166 per uur bij Azure en maar $0.1344 per uur bij AWS!
Je hebt het al door we hebben een rekenmachine nodig... die hebben we ook maar daarover verderop meer in de cursus.
Cloud providers onderhandelen ook met grote klanten voor goedkopere prijzen te bieden als dat bedrijf al hun diensten bij hun host en al meteen voor een jaar wilt betalen. Daarom merk je vaak dat grote bedrijven vaak een voorkeur hebben voor een bepaalde cloud provider (en die cloud provider [ook graag promoot dat ze een grote klant hebben die hun koos boven anderen](https://customers.microsoft.com/en-us/story/800565-national-railway-company-of-belgium-sncb-travel-transportation-azure))

Enkele grote cloud providers zijn:

-   [AWS](https://aws.amazon.com/)
-   [Azure](https://azure.microsoft.com/)
-   [Google Cloud](https://cloud.google.com/)
-   [Oracle Cloud](https://www.oracle.com/cloud/)
-   [IBM Cloud](https://www.ibm.com/cloud/)
-   [OpenStack](https://www.openstack.org/)

![marketshare](./marketshare.png)

(Salesforce staat vermeld als SaaS CRM software maar is ook eigenaar van de populaire PaaS dienst [Heroku](https://www.heroku.com/))

Alibaba en Tencent cloud behandelen we in minder detail, deze kennen voornaamste een Chinese markt (waar vaak Amerikaanse bedrijven moeilijk liggen door de wetgeving).

### Amazon Web Services

<!-- de Automatic Warning System of AWS is een brits trein beveilingingsysteem dat met magnetische signalisatie... oh wacht andere AWS-->

![AWS Logo](./aws.png)

Amazon Web Services of kortweg AWS is een onderdeel van de e-commerce gigant Amazon. Het kent zijn roets in het aanbieden van webshops maar maakte al snel een revolutie door te wijzigen naar aanbieden van data opslag (Amazon S3) en VMs die je per gebruik betaalde. Met zelfs Microsoft als klant kunnen we zeggen dat AWS een grote invloed had op het cloud landschap.

Met deze start en ondertussen al meer dan 200 verschillende cloud diensten gaande van de bekende S3 tot online code editors als Cloud9 kent AWS een van de grootste catalogi van diensten. AWS is ook een van de meest gebruikte cloud providers in de wereld met een marktaandeel van 32% in 2021.

### Microsoft Azure

![Azure Logo](./azure.png)

Azure kende voornamelijk de laatste jaren een grote opkomst en is momenteel een van de grooste diensten die Microsoft aanbied. Azure, namelijk toen nog Windows Azure, bestond echter sinds 2010 als "Windows in the cloud" wat enorm verwarrend was... wat ze bedoelde was wat we vandaag kennen als onze cloud provider.

Met een rename naar Microsoft Azure gaat Azure de wereld in als een belangrijke afdeling van Microsoft. Vandaag zijn ze de grootste AWS concurrent met een marktaandeel van 20% in 2021. Ze bieden rond de [600 diensten](https://azure.microsoft.com/en-us/products/) aan! Met een recente focus op Hybrid Cloud voor bedrijven van hun eigen Windows Server naar Azure te brengen. Kijk bijvoorbeeld naar Azure AD die perfect samenwerkt met Windows Active Directory binnen je bedrijf.

### Google Cloud Platform

![GCP Logo](./gcp.png)

Als we spreken over "Web Scale" dan kunnen we Google niet wegdenken. Ook zij hebben het AWS "truckje" en hun bestaande kennis gebruikt voor het aanbieden van cloud diensten, gebouwd op de bestaande infrastructuur (kennis en datacenters) van Google Search, Youtube, Bloggger, Maps en meer. In 2008 kwam Google met App Engine een PaaS platform voor het hosten van Python code.

Later breide dit uit naar een 100-tal diensten onder de naam "Google Cloud Platform". Google bereikt met hun kennis over het schalen van systemen een marktaandeel van 9% in 2021. Maar kent een goede reputatie voor hun AI en ML diensten, waarvoor vaak voor Google wordt gekozen. Ook zijn ze record houder van [het migraten van de groottste DDoS attack](https://cloud.google.com/blog/products/identity-security/how-google-cloud-blocked-largest-layer-7-ddos-attack-at-46-million-rps) ooit (cursus geschreven 2022-09-15 je gaat zien dat Cloudflare deze titel weer gaat overnemen binnen de maand... Famous last words...).

### Oracle Cloud Infrastructure

![OCI Logo](./oci.jpg)

Oracle is een vrij nieuwe speler op de cloud markt, in 2016 gestart als "Oracle Bare Metal Cloud Services" maar ondertussen bekend als Oracle Cloud Infrastructure of kortweg OCI. Hier bied oracle enkele IaaS en PaaS diensten aan in 37 datacenters in de wereld.

Hoewel OCI een vrij kleine speler is investeerd Oracle (traditioneel een databank bedrijf) veel in de Cloud afdeling, zo kochten ze Netsuite (het oudste "cloud" bedrijf) op. Ze konden ook Zoom overtuigen hun diensten te gebruiken alsook TikTok (buiten china, [na een hele politieke affaire](https://www.theverge.com/2022/6/19/23174775/tiktok-oracle-team-up-concerns-data-privacy-remain)).

### OpenStack (Open Source)

![OpenStack Logo](./openstack.png)

OpenStack begon in 2010 als een project van NASA en de grote server hosting gigant Rackspace. Ondertussen maken 500 bedrijven deels uit van de Open Infrastructure Foundation een non-profit vergelijkbaar met de Linux Foundation. OpenStack is een open source cloud platform met een collectie van 38 diensten die je kan hosten. Je zult dit dus vaak zien terugkomen in geavanceerde on-prem servers of onderzoeksinstellingen.

OpenStack kan vrij "eenvoudig" opgezet worden met behulp van verschillende deployment methodes, zo bijvoorbeeld Ansible. Zo draait er binnen SIN een proof of concept OpenStack omgeving voor deze lessen.

Kleinere cloud providers als [OVH](https://us.ovhcloud.com/public-cloud/compute/) bieden ook OpenStack aan als public cloud!

::: note
De fanatieke tech historicus in mij duid graag op een heraling van de jaren 80/90 met Unix. Waar Unix de oorsprong kent als een side-project binnen Bell (van de telefoon) wat uitbreide naar meerdere tech giganten die een eigen Unix maakten: HP/UX (Hewlett-Packard), SunOS (Sun Microsystems), AIX (IBM), A/UX (Apple) Windows Services for UNIX (SFU) (Microsoft), ... Met daarnaast Linux als een open source Unix variant.
:::

### Andere

Valt het op dat bovenaan geen enkel bedrijf met een Europeese roets staat? Vrijwel alle grote spelers op de markt zijn Amerikaans, tot fustratie van de Europeese Unie... Er zijn daarom enkele initiatieven om Europeese spelers beter op te kaart te zetten als [eucloud.tech](https://www.eucloud.tech/).
Een mooie vergelijking is gemaakt door [iagovar](https://iagovar.com/mapas/european-web-hosting-alternatives/) waar uit blijkt dat vele van deze spelers het gigantische aanbod van AWS niet kunnen evenaren jammergenoeg.

Er zijn vele kleinere spelers die zich focussen op IaaS, en in mindere vorm PaaS (databases, kubernetes etc) zoals [Scaleway](https://www.scaleway.com/en/), [DigitalOcean](https://www.digitalocean.com/), [Linode](https://www.linode.com/), [Vultr](https://www.vultr.com/), [Hetzner](https://www.hetzner.com/), [UpCloud](https://upcloud.com/), [Exoscale](https://www.exoscale.com/), [CloudSigma](https://www.cloudsigma.com/), [CloudAtCost](https://www.cloudatcost.com/), [Cloudways](https://www.cloudways.com/) en vele anderen. Vele zijn ook prijsbrekers en bieden een goedkoper alternatief voor de grote spelers.

## Cloud vs On Premise (aka server in de kast)

Waarom zou je hosten in de cloud?

-   Je kan je server op elk moment opschalen of verkleinen, enkel betalen voor wat je gebruikt
-   Je hebt minder onderhoudswerk
-   Total Cost of Ownership (TCO) is lager (mooie voor eens in een meeting te zeggen: TCO)
-   Je kan op verschillende locaties hosten en redundante diensten aanbieden
-   Vele diensten zijn geautomatiseerd

Nu heb ik je een hele cloud pitch gegeven wil ik je toch even tegenhouden. Cloud is niet altijd goedkoper of beter. Voor vele is het een goede oplossing maar bijvoorbeeld voor research toepassingen met GPU is het vaak goedkoper eigen hardware te kopen. Of use cases waar latency heel belangrijk is of je niet afhankelijk wil zijn van een externe provider of een verbinding. Overheden en bedrijven met zeer gevoelige data zullen ook niet snel overstappen naar de cloud, alhouwel grote providers als AWS eigen cloud datacenters hebben enkel voor hun data.

## Regions & Availability Zones

Als je inlogt op een cloud provider krijg je al meteen 1 vraag over regions en availability zones. Ze lijken misschien hetzelfde maar zijn dat niet.
Een region is een groep van datacenters die geografisch dicht bij elkaar liggen. Een region kan bestaan uit 1 of meerdere datacenters. Een region is een logische groep van datacenters die eenzelfde netwerk hebben. Een region kan dus bestaan uit 1 datacenter maar ook uit 100 datacenters die met elkaar verbonden zijn.

Een availability zone is een datacenter binnen een region. Dit geeft een meer fysieke weergave weer. Wil je beschermd zijn tegen bijvoorbeeld een stroompanne? Dan kan je je servers verspreiden over verschillende availability zones binnen 1 region. Je kan alle servers intern laten comminuceren via het interne netwerk van de region maar wel redundant zijn. Heb je heel lage latency nodig (>1ms) dan kan je beter werken in 1 availability zone.

![Regions & Availability Zones](./availability-zones.png)

Deze afbeelding van Microsoft geeft een mooi overzicht van de verschillende zones en regions.

Elke region heeft een code naam, bijvoorbeeld `eu-west-1` voor de eerste region in Europa. De availability zones hebben een letter toegekend, bijvoorbeeld `eu-west-1a` voor de eerste availability zone in de eerste region in Europa.

Deze naamgeving is niet altijd hetzelfde, bijvoorbeeld in Azure is de eerste availability zone `1` en niet `a`.

Hier een klein overzicht van enkele regions bij de grote spelers:

| Locatie     | Amazon Web Services (AWS) | Google Cloud Platform (GCP) | Microsoft Azure                      | Oracle Cloud Infrastructure (OCI) | OpenStack              |
| ----------- | ------------------------- | --------------------------- | ------------------------------------ | --------------------------------- | ---------------------- |
| Frankfurt   | eu-central-1              | europe-west3                | westeurope                           | eu-frankfurt-1                    | _afhankelijk provider_ |
| London      | eu-west-2                 | europe-west2                | uksouth                              | eu-london-1                       |                        |
| US East     | us-east-1 (N. Virginia)   | us-east1 (South Carolina)   | eastus                               | us-ashburn-1 (Ashburn)            |                        |
| Belgium     |                           | europe-west1                | [soon](https://aka.ms/belgiumintent) |                                   | EU-SIN-KOT-1           |
| Netherlands |                           | europe-west4                |                                      | eu-amsterdam-1                    |                        |

## Projects

## Resources

### What's in a name?

Cloud providers hebben altijd wel een eigen naam voor een technologie. Met AWS wel als winnaar met namen als "Elastic Beanstalk", "Lamda","Corretto"...

Hieronder een klein overzicht van veel gebruikte diensten:

| Beschrijving            | Amazon Web Services (AWS)  | Google Cloud Platform (GCP) | Microsoft Azure          | Oracle Cloud Infrastructure (OCI)   | OpenStack                                            |
| ----------------------- | -------------------------- | --------------------------- | ------------------------ | ----------------------------------- | ---------------------------------------------------- |
| Virtuele Machine        | Amazon EC2                 | Compute Engine              | Virtual Machines         | Compute Instance                    | Compute (Nova)                                       |
| Containers (Kubernetes) | Amazon EKS                 | Kubernetes Engine           | Azure Kubernetes Service | Container Engine for Kubernetes     | Container Orchestration Engine Provisioning (Magnum) |
| Containers)             | Amazon ECS                 | App Engine Flexible         | Azure Container Apps     |                                     | Containers (Zun)                                     |
| Database                | Amazon RDS                 | Cloud SQL                   | SQL Database             | Database Service                    | Databases (Trove)                                    |
| Object Storage          | Amazon S3                  | Cloud Storage               | Blob Storage             | Object Storage                      | Object Store (Swift)                                 |
| Load Balancer           | Elastic Load Balancing     | Cloud Load Balancing        | Load Balancer            | Load Balancer                       | Load Balancer (Octavia)                              |
| DNS                     | Route 53                   | Cloud DNS                   | DNS                      | DNS                                 | DNS (Designate)                                      |
| CDN                     | CloudFront                 | Cloud CDN                   | CDN                      | CDN                                 |                                                      |
| Firewall                | Security Groups            | Firewall Rules              | Network Security Groups  | Security Lists                      | Security Group (Neutron)                             |
| VPN                     | Virtual Private Gateway    | Cloud VPN                   | VPN Gateway              | VPN Gateway                         | VPN (Neutron)                                        |
| Block Storage           | Elastic Block Store (EBS)  | Persistent Disk             | Managed Disks            | Block Volume                        | Volumes (Cinder)                                     |
| Functions               | Lambda                     | Cloud Functions             | Functions                | Functions                           |                                                      |
| Container Registry      | Elastic Container Registry | Container Registry          | Container Registry       | Container Registry                  |                                                      |
| MongoDB                 | DocumentDB                 | Cloud Firestore             | Cosmos DB                |                                     | Databases (Trove)                                    |
| Web app hosting         | Elastic Beanstalk          | App Engine                  | App Service              | Application Container Cloud Service |                                                      |
| Images                  | EC2 Image Builder          | Cloud Build                 | Virtual Machine Images   |                                     | Images (Glance)                                      |
| Billing                 | Cost Explorer              | Cloud Billing               | Cost Management          |                                     | Cloudkitty                                           |

## IAM

## Facturatie

> The modern app does not run on servers but on YAML and Credit Cards

## Dit alles is Public Cloud? Wat is dan Private Cloud?

https://www.rackspace.com/cloud/openstack/private

## The Future: MultiCloud? Edge Cloud?

(trying not to cry about arc...)

https://azure.microsoft.com/en-us/services/azure-arc/#infrastructure

