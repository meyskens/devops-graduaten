# Indicent Response

Wat is een incident? Het is zeer simpel een gebeurtenis met je netwerk/servers/security/klanten die enorm dringend is! Je kan je inbeelden dat bijvoorbeeld je site plat ligt dat is een incident, maar een datalek kan dat ook zijn. Het moet niet altijd een technisch probleem zijn: het faillisement van een grote klant kan ook een incident zijn als je daardoor last minute dingen moet wijzigen.

Als je ooit incident response hebt gegoogeld, dan heb je een heleboel resultaten gevonden over incident rollen. Atlassian heeft een aantal fantastische documenten die de concepten goed uitleggen.

## Rollen bij een incident

Incident rollen helpen bij het schalen van incidenten als je response team groeit of grote delen van ej bedrijf geimpacteerd zijn. Rollen helpen verantwoordelijkheden te scheiden, zodat iemand zich op elk aspect van een incident kan concentreren. Het definiëren van deze rollen kan helpen om iedereen duidelijk te maken wat er van hen verwacht wordt, en wat ze van elkaar kunnen verwachten.

Twee rollen waarvan die je gaat toekennen:

-   **Incident commander**, het enige aanspreekpunt voor acties die worden ondernomen in verband met dit incident. Zij hoeven niet de persoon te zijn die de actie onderneemt. Maar voordat je bijvoorbeelt die server herstart, check je dat bij hen. Dit voorkomt het klassieke "shit, ik wist niet dat je de database op die database bezig was" moment wanneer je botst met een andere collega.

-   **Communicator**. Essentieel, en meestal het eerste wat vergeten wordt bij gebrek aan een gestructureerd incident response proces. Wijs zo vroeg mogelijk iemand aan die de communicatie beheert, en zorg ervoor dat alle responders de communicatie actief aan hen overdragen. Deze persoon zal alleen instaan voor comminucatie tussen het bedrijf en het incident team. (Meestal dus de irritante "hoe ver staat het" telefoontjes van de CEO)

Er zijn vele andere rollen gedefinieerd in de literatuur, maar rollen helpen alleen als je team goed begrijpt wat elke rol inhoudt. Commander en communicatie zijn, naar mijn mening, essentieel - meer granulariteit toevoegen zonder voldoende training kan je team verwarren.

Als je je vertrouwd voelt met de rollen die je wilt gebruiken, en je team goed geoefend is in al die rollen, hebt u de eerste stap gezet naar een effectieve incident response.

## De aanpak

Maar nu je de rollen hebt, hoe gaat je team het probleem oplossen?

Eerst moet je vaststellen "wat er bloedt" (zoals in de medische wereld dus...). Als je de omvang van een incident vroeg kunt vaststellen, is de kans veel groter dat je met uw volgende stappen het probleem aanpakt.

Probeer het volgende:

-   Identificeer welke systemen falen, werk vervolgens door de afhankelijkheden heen om te begrijpen of het probleem te wijten is aan een upstream of downstream component.

-   Noteer alle acties, zodat je team kan zien wat er is gebeurd en waarom. Dit kan best in een speciaal chat kanaal dat is snel en je het meteen de exacte tijd.

-   Wees uiterst voorzichtig met veronderstellingen. Voor alle info geldt: vertrouw maar verifieer. Noteer wat je deed om te verifiëren, zoals de commando's die je uitvoerde en het tijdstip waarop u ze uitvoerde. Een verkeerde veronderstelling kan je oplossing doen ontsporen, dus doe je best om ze te vermijden!

Zodra u de technische bron hebt gevonden, overweeg dan een **impactanalyse** uit te voeren.
Vertraag je reactie niet met dit werk, maar als iemand reserve is, laat hen dan de omvang van de impact inschatten - wie en hoeveel er zijn getroffen. Een onnauwkeurig begrip van de impact kan leiden tot slechte beslissingen, en duidelijkheid over wie is getroffen kan andere delen van je organisatie (Customer Success, Support, enz.) helpen adequaat te reageren. Je kan ook bepalen hoe veel teamleden en tijd je meten moet vrijmaken op basis hiervan.

Zodra het team de aard van het incident begrijpt, kan he beginnen het bloeden te stoppen.
Anders gezegd, ke doel moet zijn de **onmiddellijke pijn te stoppen** en het opruimen uit te stellen tot een minder druk moment. Is er bijvoorbeeld een actie die je kan uitvoeren om het probleem op te stellen dan een minder belangrijk process stopt (bijvoorbeeld de maandelijkse facturatie die de site plat legt) dan doe je dat!

Hiervoor moeten we prioriteiten stellen om de beste kans op een positief resultaat te bereiken. Let op de uitdrukking "beste kans": routinematige (gescripte) oplossingen die snel kunnen worden toegepast, moeten het eerst worden toegepast, zelfs als je vermoedt dat het probleem daardoor slechts gedeeltelijk wordt opgelost.

Dit betekent:

-   Rollback naar een bekende goede revisie, zelfs als u denkt dat je heel snel een fix kunt schrijven- je kan dat altijd doen nadat alles werkt, wanneer er minder urgentie is
-   Onderneem actie om kritieke systemen te behouden, zelfs ten koste van andere minder kritieke systemen. Als een enkel eindpunt ervoor zorgt dat het hele systeem faalt, aarzel dan niet om dat eindpunt op te heffen als dat de service herstelt voor de onderdelen die er toe doen.
-   Maak gebruik van je team en pas proactief de oplossingen parallel toe waarvan je denkt dat ze weinig risico inhouden, zelfs als u vermoedt dat ze niet het hele probleem zullen oplossen: schaal niet-essentiële wachtrijen naar beneden, herstart een server. Effectief delegeren betekent dat het weinig kost om te proberen, op voorwaarde dat andere responders blijven werken aan de analyse van de hoofdoorzaak in de veronderstelling dat de gemakkelijke oplossingen zullen falen.

Dit zou je een idee moeten geven van waar je team aan zou moeten werken.

## Hoe communiceer je met je team?

Gebruik Slack/Discord/Teams/...:

De eerste actie bij elk incident zou het aanmaken van een **berichtkanaal** moeten zijn. Verschillende tools (incident.io, monzo/response, Netflix's Dispatch) kunnen dat (en meer) automatisch voor u aanmaken, maar zelfs als je manueel op die knoppen moet klikken, doe het. Het is de extra minuut downtime meer dan waard om die ruimte gereed te maken.

Ik pleit sterk tegen private incident response kanalen. Als de bedrijfscultuur voorziet, maak een intern openbaar kanaal zodat je de toegang tot informatie te kan vergemakkelijken. Dit kan coördinatieproblemen voorkomen! (zoals twee afzonderlijke incidentteams hetzelfde incident zien aanpakken, zonder kennis van elkaars bestaan...).

Wanneer je op het punt staat iets destructiefs te doen, zoals een commando uitvoeren of een server opnieuw opstarten, stuur dan een bericht naar het kanaal. Niet alleen kan dit het bewustzijn in het team verbeteren, maar het biedt ook een onschatbare bron bij het bouwen van een incident log voor je post-mortem.

Instant messaging is geweldig voor informatie met een tijdstempel die niet gewijzigd mag worden.
Voor inhoud die je verwacht te wijzigen naarmate het incident vordert, maakt u een incidentdocument aan in uw favoriete online editor (Google Docs, Dropbox Paper, Notion, enz.):

Je organisatie kan incident doc templates opstellen die de structuur bevatten die je nodig hebt: misschien heb je rapportage verantwoordelijkheden, of heb je een specifieke communicatie flow? Zet het hier allemaal in, en maak het gemakkelijk om met één klik documenten te maken vanuit deze sjablonen.

Vooral bij grootschalige incidenten waarbij mensen door het incidentteam rouleren (over meerdere uren/werkdagen/tijdzones...), kan dit document fungeren als de ingang voor het inwerken van mensen in het incident. Laat degene die de communicatie verzorgt dit document beheren, een tijdlijn van belangrijke gebeurtenissen bijhouden en zelfs een samenvatting maken als het incident bijzonder complex is.
Laat uw technische team codefragmenten of relevante logregels in de bijlage van het document plaatsen, zodat iedereen een centraal overzicht van het incident heeft.

Samen kunnen chatlogboek en incidentdocument krachtige hulpmiddelen zijn om het responsteam te helpen coördineren en tegelijkertijd transparantie te bieden aan eventuele geïnvesteerde toeschouwers. Nog beter, deze inhoud kan gemakkelijk worden omgezet in een post-mortem zodra het stof is neergedaald.

## Wat met stress?

Ten slotte, en dat is het belangrijkste, het menselijke element. Mensen nemen slechte beslissingen als ze gestrest zijn, en de opwinding van een incident kan ervoor zorgen dat je de zorg voor jezelf helemaal vergeet. Geef het goede voorbeeld en moedig uw hulpverleners aan voor zichzelf te zorgen.

Een paar dingen om te overwegen:

-   Een zeer effectieve methode om stress te verminderen is het nemen van pauzes, weggaan van je scherm, en ademhalen. Moedig uw team actief aan om deze pauzes samen met u te nemen, zodat u de kans verkleint dat u dingen verpest door u te haasten.

Als algemene regel, neem **pauzes** wanneer:

-   Je wordt **gepaged**. Het hoeft niet lang te duren; slechts **10 seconden ademhalen** kan je lichaam eraan herinneren dat je de controle hebt, en je adrenaline verlagen.
-   Wanneer de **productie impact is gestopt**. Zodra het alarm stilvalt en de situatie stabiel lijkt, roep dan een pauze in voor het **hele team**. Het komt zelden voor dat incidenten geen uitgebreid vervolgwerk hebben: rust minstens 15m uit voor je aan dat proces begint.
-   Tijdens de follow-up, voordat je een procedure start, zoals 'herstel van X'. Laat iedereen een luchtje scheppen voordat de checklist wordt uitgevoerd, zodat iedereen zich kan opladen voor het geval het proces misgaat of veel langer duurt dan verwacht.

Een belangrijke taak is het bestellen (en uitgeven!) van eten voordat mensen honger krijgen. Je zal verbaasd zijn hoe een incident response team veel gaat eten, na luidkeels te hebben geprotesteerd dat ze geen eten nodig hebben! Bied ze ook tijdens het werk de nodige koffies/colas en snacks aan.

Denk eraan: haal diep adem, let op je collega's, **geef de schuld aan systemen en niet aan mensen**, en haast je niet.

Ik hoop dat je dit niet veel nodig hebt maar... veel succes!

## De post-mortem

Enkele dagen na het incident zit je best samen met het team en je chat logs voor het opstellen van een post-mortem. Je maakt best een interne en zeker een externe versie hiervan! Dit document gaat beschrijven wat gebeurd is, waarom het gebeurd is, en wat je kan doen om het in de toekomst te voorkomen. Deel dit ook met je collega's zodat zij hieruit lessen kunnen trekken voor een toekomstig incident.

Je klanten waarderen ook een publieke versie zodat ze duiding kregen wat er wa misgelopen en dat je er actief mee bezig bent het op te lossen. (Dit is ook een heel mooie manier om personeel aan te werven...)

Er zijn vele mooie voorbeelden te vinden:

-   [danluu's post-mortem collectie](https://github.com/danluu/post-mortems)
-   [API Outage at GoCardless](https://gocardless.com/blog/incident-review-api-and-dashboard-outage-on-10th-october/)
-   [Cassandra goes boom at Monzo](https://monzo.com/blog/2019/09/08/why-monzo-wasnt-working-on-july-29th)

## Thank You

Voor dit hoofdstuk had ik graag uitgebrieid [Lawrence Jones](https://blog.lawrencejones.dev/) bedankt voor zijn visie en concepten uit lange ervering in incident response.

