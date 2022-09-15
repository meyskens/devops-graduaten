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

### Oracle Cloud

2016 under the name "Oracle Bare Metal Cloud Services."

Zoom en de TikTok affaire

overname netsuite Inc eerstr cloud software

### OpenStack (Open Source)

OpenStack begon in 2010 als een project van NASA en de grote server hosting gigant Rackspace. Ondertussen maken 500 bedrijven deels uit van de Open Infrastructure Foundation een non-profit vergelijkbaar met de Linux Foundation. OpenStack is een open source cloud platform met een collectie van 38 diensten die je kan hosten. Je zult dit dus vaak zien terugkomen in geavanceerde on-prem servers of onderzoeksinstellingen.

Kleinere cloud providers als [OVH](https://us.ovhcloud.com/public-cloud/compute/) bieden ook OpenStack aan als public cloud!

::: note
De fanatieke tech historicus in mij duid graag op een heraling van de jaren 80/90 met Unix. Waar Unix de oorsprong kent als een side-project binnen Bell (van de telefoon) wat uitbreide naar meerdere tech giganten die een eigen Unix maakten: HP/UX (Hewlett-Packard), SunOS (Sun Microsystems), AIX (IBM), A/UX (Apple) Windows Services for UNIX (SFU) (Microsoft), ... Met daarnaast Linux als een open source Unix variant.
:::

### Andere

Valt het op dat bovenaan geen enkel bedrijf met een Europeese roets staat?

https://iagovar.com/mapas/european-web-hosting-alternatives/

https://www.eucloud.tech/

## Cloud vs On Premise (aka server in de kast)

## Regions & Availability Zones

## Projects

## Resources

### What's in a name?

| Beschrijving     | Amazon Web Services (AWS) | Google Cloud Platform (GCP) | Microsoft Azure  | Oracle Cloud Infrastructure (OCI) | OpenStack (OS) |
| ---------------- | ------------------------- | --------------------------- | ---------------- | --------------------------------- | -------------- |
| Virtuele Machine | Amazon EC2                | Compute Engine              | Virtual Machines | Compute Instance                  | Compute (Nova) |

## IAM

## Facturatie

> The modern apps do not run on servers but on YAML and Credit Cards

## Dit alles is Public Cloud? Wat is dan Private Cloud?

https://www.rackspace.com/cloud/openstack/private

## The Future: MultiCloud? Edge Cloud?

(trying not to cry about arc...)

https://azure.microsoft.com/en-us/services/azure-arc/#infrastructure

