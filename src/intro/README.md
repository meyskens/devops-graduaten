# Introductie

Welkom in de cursus DevOps. Deze cursus behoord tot de graduaatsopleiding netwerkbeheer van Thomas More.

In deze cursus bouwen we op de voorafgaande kennis van de opleiding. We bekijken DevOps langs 2 kanten.
Eerst kijken we naar de term DevOps, we bespreken wat we hieronder verstaan vanuit een niet technisch aspect.
We leren hier werken in een DevOps-driven organisatie en hoe we een team kunnen organiseren.

In het tweede deel gaan we onze handen vuil maken en verschillende tools van dichtbij bekijken.
Deze tools typeren vaak in een DevOps organisatie of zijn nodig voor het werken in een DevOps-driven organisatie.

Het einddoel van deze cursus is onze veilige leeromgeving te verlaten en aan de slag te gaan door het starten van een mini organisatie,
hier ontwikkelen we een eigen hosting omgeving voor een applicatie.

## Geschiedenis

Voor we beginnen met uit te leggen wat DevOps is moete we eerst weten waar het vandaan komt. DevOps is namelijk geen technologie of een verzamelmaam
maar een beweging binnen de software en netwerk wereld.  
We situeren ons rond het jaar 2008, om ons een idee te geven moeten we best de wereld van toen eens bekijken. We zaten in een pre-smartphone era.
De iPhone was pas aan zijn 2de levensjaar toe maar de PC had al al onze huiskamers veroverd net als het breedband internet. Het bedrijfsleven was
gelijkaardig. Web gecentreerde bedrijven als Facebook zagen pas het licht, grotere machten als Google waren al al langer bekend. We kwamen net uit een browser en zoekmachine oorlog (IE en Google).

Hoe werkte deze organisaties intern? We kijken daarvoor even naar onze collega's van de opleiding prgrammeren.
Het Agile manifesto kwam al uit in 2000. Dit was wel niet de doorbraak door het publiceren van een boek (het is geen religie) maar
het einde van het waterfall model om development van applicaties strict in fases uit te voeren (analyseren, ontwikkelen en publiceren) was wel al zeker.
Als we over Agile spreken spreken we over continu opleveren van software, onze grote handleidingen werden post-it notas op een bord naast ons op kantoor.
Onze klant kreeg elke 2 weken wel iets nieuws te zien wat was afgewerkt. Deze nieuwe werkmethode bewees zijn nut in een als maar snel veranderende maatschapij.  
Op Agile werken gaan we verder op in in het verloop van de cursus.

Nu we toch al even naar onze opleidingen hebben gekeken zien we dat we een Graduaat Programeren en een Graduaat Netwerkbeheer hebben.
Nu dit was exact hoe bedrijven werken (en vaak nog altijd, maar daar komen we op terug)! Binnenin meeste organisaties hebben we twee teams.
De programeurs en "die mensen in de kelder die de servers online houden". Waarom die neerkijkende toon?
In vele gevallen werkte de twee "afdelingen" in andere verdiepen of gebouwen. Fouten werden op elkaar gestoken (het bekende "works on my laptop")
en comminucatie was minimaal. Kennisuitwisseling van vakexperten in beide domeinen bestond ook amper. Developers en Operations.

Net als in de software wereld voor Agile werken merkten we een inefficiëntie, het kon niet veel beter, een server opszetten koste veel tijd en resources.
Virtuele Machines loste al veel op voor ons maar was lauter een technisch hulpmiddel. Nieuwe versies van software kwamen alsmaar sneller. En het internet? Dat begon [de start van een exponentiele curve](https://en.wikipedia.org/wiki/Internet_traffic). Met de populariteit van smartphones, laptops,...

Twee groepen die elkaar ontmoeten, en georganiseerd ontmoeten. Een paar trekkers in de community organiseerde Meetups en conferenties om de twee samen te brengen. Om ideeën uit te wisselen met elkaar. Online en offline starte enkelen de gebroken communicatie op te lossen.
Wat hier ontstond was een wisselwerking tussen de twee groepen. Developers leerden over hoe rekening te houden met waar hun code terecht komt, de operations mensen zagen inzicht van code, automatie en agile werkmethodes.

Nu in 2008 was het nog niet opgelost door de invoer van een kanban bord in de kelder.
Aan de organisatie kant kwam er een verandering, de twee teams werken nu vaker samen "op hetzelfde verdiep". In sommige bedrijven gaat het verder en
maken ze deel uit van hetzelfde team met een constante wisselwerking.

Wat het voor ons nog interessanter maakt is de opkomst van nieuwe technologieën.
De eerste is cloud computing, in 2006 kwam Amazon met een toevoeging van S3 en EC2 aan hun aanbod die tot vandaag een van de meest gebruikte cloud services zijn.  
Nu onze servers zo snel en flexibel te kopen waren was de tijd van een server een naam te geven en uren mee te spenderen gedaan. Een op;lossing
vonden we in de wereld van de Developers, code! Infrastructure as Code liet ons toe om doormiddel van een basis kennis aan programeren het werk
van het opzetten, updaten en aanpassen van servers te verbeteren.
Een volgende revolutie kwam uit een onverwachte hoek: dotCloud wou de cloud nog een stukje makkelijker maken voor developers. Die naam ken je niet,,
want de techologie was beter dan de cloud. Daarom kennen we het nu beter als [Docker](https://www.docker.com/). Containers waren niet nieuw, maar
hoe de technologie te gebruiken als tool voor developers, operations en de open source community was het wel.

Dit is de wereld waar we ons in gaan verdiepen in het vak.

### De Toekomst

Wat is de toekomst? Er zijn nog zovele domeinen waar we nog in kunnen verbeteren in IT... Momenteel zitten we in een grote crisis rond security.
Dagelijks komen we achter nieuwe vunerabilities (velen te vermijden) en het wordt niet beter in al maar complexere systemen. DevSecOps is een vrij
nieuwe beweging die hierop een antwoord wil bieden. Maar dat is nog niet het einde, komen we aan limitaties door hardware? Of is het tijd voor
DevSecMarketingOps? Of kan deze werkmethode ook een antwoord bieden waarom vele kleine startups met 10 of 100 mennsen veel sneller kunnen innoveren dan
een technologiegigant met meer dan 1000 mensen?
Ik kan het niet voorspellen, maar de IT sector gaat zo snel dat deze cursus binnen 10 jaar gewoon weer in de digitale kringloopwinkel gaat liggen onder "acherhaalde ideeën".

## Wat is DevOps?

Nu weten we al veel over de geschiedenis van DevOps. Maar wat houd DevOps nu EXACT in?

### DevOps vs DevOps vs DevOps

En hier moet ik mezelf al gaan tegenspreken. Er is iets heel belangrijk. DevOps is geen exacte wet, geen exact handboek om te volgen.  
DevOps word door velen als iets anders bekeken. Sommige zien het als een manier om je kantoor in te delen, dev naast ops. Andere zien het als een manier
van teams combineren. Sommige zien het als de kennis van developers en operations te combineren in de rol van "DevOps Engineer".
Sommige maken er modellen rond zoals CALMS (Culture, Automation, Lean, Measurement, Sharing). Sommigen zien DevOps dan weer als de enige manier om in de
cloud te kunnen werken.

![DevOps Diagram](devops.png)

In deze cursus ga ik kort in op 3 modellen die DevOps verklaren.

### "The Three Ways"

Dit concept over DevOps komt uit "The Phoenix Project" of "The DevOps Handbook" zij zien DevOps in 3 manieren te benaderen.

-   The First Way: Principles of Flow
-   The Second Way: Principles of Feedback
-   The Third Way: Principles of Continuous Learning

We bekijken even kort de waarden dan deze 3 "ways"

#### Principles of Flow

-   Werk **"zichtbaar"** maken. In tegenstelling tot productieprocessen als in fabrieken is de flow van software door zijn ontwikkelingslevenscyclus niet gemakkelijk te zien. Het gebruik van methoden zoals kanban borden moet dit oplossen hierdoor kan het werkt zichtbaar gemaakt worden voor het team en manaagement. Iedereen kan zien hoe ver we staan in een project op alle tijden.

-   Beperken van work-in-progress (WIP). Je zal zien dat er vele taken te gebeuren staan, zeker na het zichtbaar maken door een kanban bord. We moeten ervoor zorgen dat een bepaalde persoon best maar tegelijk is aangesteld voor 1 taak, multitasken veroorzaakt een trager proces door zogenaamd "context switchen".

-   Verkleinen van batchgroottes. Het "opdelen" van werk in kleinere stukken, zoals in sprints volgens het SCRUM principe. Ook moeten taken zo "hapklaar" gemaakt worden waardoor ze makkelijk in enkele dagen uitgevoerd, gereviewd en gedeployed kan worden. Er moet ook duidelijkheid zijn voor de uitvoerder van de taken. Vage taken moeten eerst verder beschreven worden.

-   Identificeren en verwijderen van beperkingen en tijdsverspillingen. We moeten pijnpunten vinden en beperken. Dit kan gebeuren door het gebruik maken van testomgevingen voor experimenten, vermijden van handmatig werk door tools en het gebruik van systeem architectuur.

#### Principles of Feedback

The Second Way: Principles of Feedback staat voor een snelle en constante feedback cycli mogelijk te maken in alle stadia van een ontwikkeling.

-   Problemen oplossen om nieuwe kennis op te bouwen. Dit principe past in de "fail fast" mentaliteit. Het ontwikkelen van een Minimum Viable Product om deze snel uit te kunnen testen. Zo kunnen we snel problemen met een implementatie zo snel mogelijk kunnen vinden en ze vroeg op te lossen.

-   Quality Control en testing dichter bij de bron brengen. Dit principe is zeer popilaur DevSecOps-beweging, die zich bezighoudt met het aanpakken van beveiligingsproblemen tijdens de ontwikkelcyclus. We moeten onze software testen tijdens de ontwikkeling en niet enkel op het einde zodat we snel fundamentele problemen kunnen vinden.

-   Geen "gooi het over de muur" mentaliteit. Zowel developers als operations werken samen aan het oplossen van problemen met de applicaties, we werken aan een gezamelijk doel en niet ieders op een eigen taak.

#### Principles of Continuous Learning

The Third Way: Principles of Continuous Learning staat voor een cultuur van voortdurend leren en experimenteren binnen de organisatie.
Het leren voor een ITer houd niet op bij het verlaten van de school. Organisaties moeten hiervoor open staan dat het altijd beter kan worden.

-   Het mogelijk maken van organisatorisch leren en "safety culture". Leiders moeten helpen "de toon te zetten" voor de organisatie, door het goed te maken om te leren, **fouten te maken**, en het opnieuw te proberen. We mogen het geen taboe maken een fout te maken.

-   Het institutionaliseren van verbetering in dagelijks werk. We moeten durven nadenken over onze dagelijkse taken en hoe deze verbetered kunnen worden. We mogen "omdat het altijd al zo was" niet als excuus gebruiken.

-   Lokale ontdekkingen omzetten in globale verbeteringen. Verbeteringen binnen een deel van een organisatie moeten gedeeld worden zodat iedereen vooruit gaat. Het is geen sprint naar de finish maar een estafette.
    Het injecteren van veerkrachtpatronen in het dagelijkse werk. Sommige voorbeelden zouden het repeteren van mislukkingen kunnen omvatten, en het werken aan het verbeteren van belangrijke metriek voor implementatie.

### "Mature capabilities in technical and management practices"

Dit principe komt uit "Accelerate: The Science of Lean Software and Devops"[^accelerate] presenteren de auterus op basis van hun onderzoek de belangrijkste technische en management praktijken die goed presterende DevOps teams hebben aangenomen en blijven verfijnen.

#### Technische Praktijken

Volgens Acceletate zijn dit de belangrijksye methodes die gebruikt worden gebruikt door goed presterende DevOps-teams:

-   Continuous Delivery
-   Architecture
-   Product and Process

##### Continuous Delivery

De Accelerate auteurs kozen ervoor om verschillende methodes te combineren onder de paraplu van continue levering (CD). Hoewel CD zelf zijn eigen principe is onder CI/CD, stellenze vast dat dit deel essentieel is voor een goed presterende DevOps team.
Ze spreken over:

-   Version Control: op dit vlak gaan we Git bekijken.
-   Deployment automation: in de vorm van pipelines. Als ook het automatiseren van server setups.
-   Continuous integration (CI): autmatisch testen van software.
-   Trunk-based development: version control met hierop verschillende versies die individueel nog gepatched kunnen worden.
-   Test automation: automatisch testen van software door Unit Tests, End to end tests en Integration Tests.
-   Test data management: beheren van test data in test omgevingen om analoog te blijven aan de echte omgeving.
-   Shift left on security (DevSecOps): Security mee opnenem in het ontwikkelproces
-   Continuous delivery (CD): constant deployen van software.

##### Architecture

De architectuur van onze setup is belangrijk niet enkel voor het draaien van de servers maar ook de flexibiliteit.

-   Het is belngrijk om testen te kunnen uitvoeren in een geisoeede omgeving die onze productie omgeving niet beinvloedt.
-   We moeren verschillende applicaties en services onafhankelijk van elkaar kunnen uitrollen en updaten

In feite worden de hierboven beschreven kenmerken - testbaarheid en inzetbaarheid - bereikt door het implementeren van de volgende twee architecturale technische principes:

-   **Loosely coupled architecture.** Het doel is dat verschillende componenten van de applicatie onafhankelijk zijn van elkaar. Zo is er weinig coordinatie nodig tussen de verschillende teams wanneer iets moet aangepast worden.
-   **Empowered teams** Wanneer teams individueel kunnen kiezen welke tools gebrikt kunnen worden resulteert dit in snellere doorlooptijd.

##### Product and Process

DevOps teams moeten niet enkel kijken daar het technische aspect maar ook bedrijsprocessen volgen om hun werk te verbeteren.

-   **Customer feedback** Teams moeten met de klant kunnen comminuceren om feedback te krijgen, en dit al zo vroeg mogelijk.
-   **Value stream** Teams moeten verstaan dat continue verbetering ook waarde oplevert voor de klan
-   **Working in small batches** Kleinere batches zorgen voor snellere oplevering aan klanten, en zetten de feedback loop in actie.
-   **Team experimentation** Teams werken beter als ze individueel mogen experimenteren met ideeen en theorien zonder toestemming van bovenaf.

#### Management Praktijken

Niet enkel op team niveau moet een organisatie efficient werken, maar ook op management niveau. Een organisatie moet op alle niveaus flexiebel kunnen werken. Een kracht die we tegenwoordig vooral veel in startups zien terugkomen, in grotere organisaties proberen ze dit te verbeteren.

-   **Lightweight change approval processes.** Teams die geen goedkeuringsproces hadden of peer review gebruikten, behaalden een snellere ontwikkelingscyclus en prestaties.
-   **Monitoring** Gebruik gegevens van monitoring tools van de infrastructuur moeten gebruikt worden om dagelijkse besluitvorming te informeren.
-   WIP limiteren en werk visualiseren ook voor en naar management toe.
-   Een cultuure van leren en ondersteunen op alle niveaus.
-   Je teams voorzien van de juiste tools om hun werk te kunnen doen.

### "CALMS"

Dit principe komt van Jez Humble, co-auteur van The DevOps Handbook en Accelerate. Het CALMS raamwerk gebruikt als een middel om te beoordelen of een organisatie klaar is om DevOps processen te adopteren, of hoe een organisatie vordert in hun DevOps transformatie.
Het vat de bovenstaande ideeen samen in een een aantal pijlers en een continue verbetering.
Het is gebaseerd op de volgende vijf pijlers:

-   **Culture** Voordat we de silos van verschillende teams neer kunnen halen moet er een cultuur zijn van gedeelde verantwoordelijkheid zijn, of op zijn minst een groep mensen die zich toelegt op het vestigen van die cultuur, met goedkeuring en steun van het management
-   **Automation** Door gebruik te maken van CD (zie hierboven) moeten ops teams inzetten op op het automatiseren van alle manuele handelingen.
-   **Lean** Ontwikkelingsteams maken gebruik van LEAN principes om verspilling te elimineren en de waardestroom te optimaliseren, zoals het minimaliseren van WIP, het zichtbaar maken van werk, en het verminderen van hand-off complexiteit en wachttijden.
-   **Measurement** De organisatie moet willen inzetten op het verzamelen van informatie over prosecssen en deplooyments om hun huidige mogelijkheden te kennen en probleempunten te identificeren.
-   **Sharing** Er moet een cultuur wijn van openheid en delen van informatie en kennis tussen teams, om samen naar een gezamelijk doel te kunnen werken.

## Belang

Waarom leren wij DevOps? DevOps laat ons toe om sneler te kunnen itereren, in te spelen op veranderingen en servers op te schalen.
Onze nieuwe tools gaan veel manueel werk kunnen besparen waardoor we kunnen focussen op verbeteringnen van ons systeem.
We gaan ook kijken naar hoe we efficient in team kunnen werken en werk kunnen plannen en verdelen. We bekijken ook hoe we problemen kunnen
detecteren, vermijden en kunnen reageren in een crisis situatie. Ook bekijken we hoe we onze applicaties kunnen shippen in een cloud omgeving.

Ik hoop dat je nu al vanuit technisch vlak snapt waarom DevOps kan helpen. Nu het management van een bedrijf overtuigen is een ander verhaal.
Volgens het boek "Accelerate"[^accelerate] zagen bedrijven die DevOps implementeerde:

-   46 keer zoveel code deployments
-   440 keer snellere "lead time" van commit naar deploy
-   170 keer snellere tijden om te herstellen van downtime
-   1/5de de kans op systeem falen

Bovendien is deze cursus ontwikkeld volgens DevOps best practices.

## Nuttige bronnen

Deze bronnen zijn nuttig als je je verder wil verdiepen maar zijn _geen leerstof_:

-   [Atlassian (samenwerkings tools) over DevOps](https://www.atlassian.com/devops)
-   [Sonatype (code analysis) over DevSecOps](https://guides.sonatype.com/foundations/devops/what-is-devops/)

[^accelerate]: Accelerate: The Science of Lean Software and Devops: Building and Scaling High Performing Technology Organizations Paperback - Nicole Forsgren Phd, Jez Humble, Gene Kim - ISBN 978-1942788331
