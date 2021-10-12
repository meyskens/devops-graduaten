# Monitoring

Monitoring staat in als een belangrijke waarde in DevOps. Monitoring gaat ons een concreet zicht kunnen bieden op onze infrastructuur. We willen op basis van objectieve metingen beslissingen kunnen maken. We hebben natuurlijk wel eerst metingen nodig.

Concreet bekijken we in deze cursus een monitoring stack gebaseerd op Prometheus en Grafana. Maar voor we hieraan beginnen bekijken we eerst wat een goede monitoring inhoud.
We bekijken types van monitoring als ook hoe we ermee aan de slag kunnen gaan

## Types

### Blackbox monitoring

Dit type van monitoring is de simpeleste vorm maar gaat ons ook weinig informatie kunnen bieden. Je ziet dit bijna altijd gebruikt worden, ook al is er geen fatsoendelijke monitoring voorzien. Bij zogenaamde "blackbox" monitoring bekijken we en systeem altijd van buitenaf. We checken op regelmatige basis of een systeem online is en in gevorderde vorm of het juist antwoord. Wat er binnen de systemen gebeurd is hier niet van belang. Werkt een server ja of nee is de enige vraag dat we kunnen beantwoorden.
Vaak gebeurd dit ook door een externe dienst als Pingdom of UptimeRobot. Zij sturen ook alerts uit bij problemen.

Terwijl het een minimale en op eerste zicht misschien slechte monitoring is is dit wel een essentieel deel van je setup, een extern systeem gaat je bij een complete outage kunnen verwittigen waarbij de kans dat je interne monitoring down is hoger is.

### System Monitoring

Een verdere stap dieper in systemen is system monitoring. Dit princiepe is al sinds jaar en dag van toepassing. Hierbij monitoren we onze servers op niveau van het systeem. We spreken dan over cijfers zoals CPU, RAM en schijfgebruik. Dit speelt zich vooral af op niveau van de server en op het netwerk.
Belangrijk hier ook is dat we niet enkel de huidige data kunnen bekijken maar ook historische, zo kunnen we een analyse maken over een lange tijd. Ook gaan we merken dat onze klanten waarschijnlijk meer load veroorzaken binnen bepaalde uren.

### Application Monitoring

Dit is een vrij recentere evolutie die waarschijnlijk mede te danken is aan DevOps. Klassiek werd er vooral gekeken naar system resources.
Een volgende stap is het bijhouden van statistieken over onze servers. Hoeveel requests handeld onze web server af per seconde, hoeveel queries behandeld onze database nu.
Interessant kan ook zijn welke status codes stuurt onze web server uit, hoeveel van die codes zijn errors? Dit gebeurd op allemaal applicatie niveau.
We kunnen dit ook allemaal in onze Prometheus database laten opnemen (lees dit als project tip).

Een verdere stap kan dan ook nog eens binnen een programma gaan. Bij problemen (of constant) kunnen we gaan monitoren binnen in programmas en zo statistieken krijgen over de interne werking. Je kan zo bijvoorbeeld gaan zien welke functie binnen code hoeveel tijd inneemt. Of bij een trage werking uitzoeken of het de database of de achterliggende logica de bottleneck is. Het monitoring bedrijf New Relic is hiermee groot geworden.

### Logging

Wat we ook veel terugzien is log agregation. Onze servers en applicaties die we hosten produceren allemaal logs. Terwijl we deze op onze servers bijhouden is er nut om deze aan te bieden aan developers of (misschien nog handiger) doorzoekbaar te maken.
We zien daarom vaak in organisaties een logging tool die alle logs verzamelt en doorzoekbaar maakt op tijd, keyword, error code enzovoort in een makkelijke web interface.
Voorbeelden zijn Grafana Loki of Elasticsearch met fluentd.

## Effective monitoring

We kunnen enorm veel data gaan verzamelen op onze servers maar we moeten het natuurlijk ook nog bruikbaar maken.

### Definieer normaal gebruik

We moeten een basislijn kunnen definiëren van acceptabel servergedrag. We kijken hier bijvoorbeeld naar de tijd van een request en wat acceptabel is. Als we op een grotere schaal kijken moeten we ook kijken welke impact normaal gebruik geeft. Je hebt bijvoorbeeld elke ochtend om 08u30 een piek als iedereen begint te werken, we willen niet dat onze monitoring elke dag door deze piek problemem ziet
Vadanf dat we deze hebben kunnen we kijken naar afwijkingen van de normale patronen, dit zijn zijn tekenen van problemen.

Een ander voordeel van deze methode is dat het vroegtijdige indicatoren oplevert dat servers tegen de beschikbare capaciteit aanzitten. Deze informatie is vooral belangrijk voor managers om zowel upgrades als groei te plannen.

### Historiek behouden

e vraagt je misschien af, waarom zou je een context bijhouden van problemen die zich in het verleden hebben voorgedaan en lang geleden zijn opgelost!
Wel, als je niet leert van het verleden, is de kans groot dat je het herhaalt. We herinneren ons dat bijleren over eigen fouten een waarde van DevOps was!
De historische context van welke problemen zich op een bepaald tijdstip en onder specifieke omstandigheden hebben voorgedaan, kan u waardevolle inzichten verschaffen. Het analyseren van deze bevindingen kan u helpen toekomstige ergernissen te beperken.

## Alerting

Elke dag je monitoring gaan checken of de server plat lag is geen goed idee... (ik hoop dat je dat doorhad)

Alerting is daarom een essentieel deel van monitoring. Je moet alerts kunnen uitsturen bij problemen, niet enkel bij rampen maar bijvoorbeeld ook bij vertraagde werking of een hoge belasting. Meestal werken we daarom ook in niveaus van alerts waarbij we minimaal een waarschuwing hebben en maximaal een "page" (van een pager, bieper ook genoemd) waarbij je meteen wakker moet gemaakt worden om het op te lossen.

Alerts mogen niet zomaar in je mailbox komen te staan. Ze zijn het meeste effectief om in een kanaal te komen waar enkel alerts komen zodat ze meteen de nodige aandacht krijgen.
Alerts die niet dringend zijn (vb schijf 80% vol) komen in meeste organisaties bijvoorbeeld aan in een Slack of Teams kanaal.
Als we over critieke alerts spreken komen ze vaak ook in Slack aan maar is er vaak een "page" aan gekoppeld, dit kan over een telefoontje of een SMS of een speciale alert. Diensten als PagerDuty zijn hiervoor speciaal ontworpen. Zij ondersteunen ook vaak een "on-call rotation" waarbij de verantwoordelijkheid van van wacht te zijn afwisseld.

> On-call zijn is niet altijd makkelijk. Je moet constant bereikbaar en werkklaar zijn, en natuurlijk ook een laptop mee hebben. In vele situaties kan het ook stresserend zijn.
> Zorg dus voor een evenwichtige wissel van de wacht. (En vraag zeker een vergoeding)

Alerts moeten ook duidelijk gestructureerd en gedefenieerd zijn. Je moet allereerst de situatie meteen kunnen inschattten, wat is de impact, wat kan de oorzaak zijn en hoe dringend is het. Een alert "disk almost full" zegt veel minder dan "disk 90% full" of "disk 95% full" of als je echt goed bent: "Disk 95% full estimated to be 10% in 3 hours".
Hoe weet je dat een alert duidelijk is? Zorg ervoor dat je het on 3 uur 's nachts perfect kan verstaan, dat is nu eenmaal wanneer je deze te zien gaat krijgen. (Dit telt ook voor disaster recovery documentatie!)

### Redblindness

Als we perfect willen weten wat er in onze servers omgaat dan kunnen we best genoeg alerts maken!

Dit is een mooie beginnersfout, we moeten alerts die niet direct "actionable" zijn. Alerts waar we enkel maar naar kunnen kijken tot het erger wordt zijn geen goede alerts. Je gaat zo veel alerts krijgen waardoor ze niet meer speciaal zijn. Zo kan je tussen alle 50 alerts van de dag die ene missen dat je systeem binnen het uur gaat platleggen.

## The next step: observability

Observability wordt gezien als de opvolger van monitoring. Met monitoring kunnen we onze eigen servers gaan bekijken in detail. Dit schaalt minder door naar alsmaar grotere en complexere systemen. Een Facebook bijvoorbeeld gaat al moeite hebben met het gewoon tellen van hub servers. Zij moeten op een absoluut andere schaal werken. Ook is er veel meer invloed van buitenaf die de perfomance kan beinvloeden.

We kunnen niet meer gaan observeren van buitenaf, we kunnen niet meer op schaal bugs gaan zoeken door de output te analyseren. We moeten van onderaf gaan werken, onze systemen gaan analyseren vanuit de innerlijke werking "Describes the world from the first-person perspective of the software, executing each request. Software explaining itself from the inside out."
We moeten ook vragen over de impact van een aanpassing kunnen bepalen zonder deze in de wereld te sturen.

Vele moeilijke vraagstukken waar de wereld van observability zich mee bezig houdt. Een heel interessant gebied, maar voor een andere cursus.

## References

-   Charity Majors on Observability https://www.honeycomb.io/wp-content/uploads/2020/05/DoD-Amsterdam-2019-Charity-Majors.pdf
-   Montadata over best practices https://www.motadata.com/blog/best-practices-server-performance-monitoring/
