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

In deze cursus ga ik kort in op 3 modellen die DevOps verklaren.

### "The Three Ways"

### "Mature capabilities in technical and management practices"

### "CALMS"

![CALMS Diagram](devops.png)

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
