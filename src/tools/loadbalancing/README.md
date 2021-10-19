# Reverse Proxy & Load Balancing

Reverse proxies zijn niet meer weg te denken uit ons netwerkverkeer. Ze vormen de mogelijkheid om webverkeer op applicatie niveau te routeren. We draaien meerdere webservers op een server als soms ook op meerdere servers. Net als onze router verkeer tussen de servers gaat sturen gaat onze reverse proxy dat ook doen maar dan voor webservers. Dit laat ons toe 1 endpoint te hebben naar de buitenwereld. Met onze reverse proxy kunnen we ook gaan loadbalancen om zo verkeer over servers te verdelen en zo te kunnen opschalen.

Reverse Proxies kunnen in alle verkeer van en naar je server kijken en op basis van de inhoud beslissingen maken. [Cloudflare](https://cloudflare.com) maakt hier ideaal gebruik van. Zij bieden een reverse proxy dienst aan die we webpagina probeert efficiënter te maken, en filtert ook verdacht verkeer. Met een grote capaciteit aan netwerk kunnen zij zo je onder andere ook helpen bij DdoS attacks.

## Reverse Proxy

Een klassieke proxy zit meestal tussen de gebruiker en het internet, onze reverse proxy zit tussen het internet en onze servers. Vandaar dus de naam "reverse".

![reverse proxy flow](./reverse-proxy-flow.svg)

Onze reverse proxy zit dus voor onze verschillende servers en gaat op basis van de requests bepalen welke server de request moet afhandelen. Vaak zijn interne reverse proxies ook verantwoordelijk voor het afhandelen van TLS (HTTPS).

Bij het gebruiken van een reverse proxy zien we een aantal voordelen:

-   We kunnen 1 endpoint hebben voor meerdere servers met zowel dezelfde als andere content
-   We kunnen via loadbalancing verkeer spreiden over servers
-   We hebben 1 centraal punt voor beheer TLS certificaten

## Load balancing

Load balancing is een techniek die we gebruiken om verkeer over verschillende servers te verdelen. Deze techniek is onmisbaar in deze tijden, beeld je in dat iedereen die Facebook bezoekt op 1 server terecht zou komen. We kunnen grote hoeveelheden verkeer gaan opvangen door onze requests over meerdere servers te verdelen. Hiervoor zijn verschillende technieken beschikbaar, maar ook op verschillende niveaus. We kunnen bijvoorbeeld via DNS naar mensen andere IPs gaan sturen. Op netwerk niveau kunnen we hetzelfde doen met onze routing tables.

In deze cursus gaan we echter aan loadbalancing doen op niveau van HTTP. Dit laat ons toe om via een reverse proxy verkeer over verschillende servers te delen. Het laat ons ook toe om meteen gebruikte maken van de voordelen van onze reverse proxy.
Houd echter in het achterhoofd dat in praktijk meestal een mix van loadbalancing systemen gebruikt wordt. In dit voorbeeld gaan we de zwaarste server load dat meestal het genereren van dynamische inhoud is op apparte servers doen. Maar onze loadbalancer zelf is ook een server met limitieten. Een reverse proxy draaien is echter wel veel minder resource intensief dan een applicatie draaien.

## Load balancing met Nginx

De meest populaire reverse proxy server is Nginx. Nginx is eigenlijk een webserver net als Apache maar we zien deze enorm veel gebruikt worden als reverse proxt dankzij goede ingebouwde support hiervoor, alsook de goede performance.

We bekijken een voorbeeld van een reverse proxy op Nginx, Nginx zelf draaien we in een Docker container.
We gaan hier meerdere containers gebruiken waartussen we een reverse proxy gaan maken, dus is Docker Compose ideaal:

docker-compose.yml:

```yaml
version: "3.9"
networks:
    nginxdemo: {}
services:
    nginx:
        image: nginx:1.21
        ports:
            - 80:80
        volumes:
            - ./nginx.conf:/etc/nginx/conf.d/default.conf
        networks:
            - nginxdemo
    demo1:
        image: maartje/demo1
        networks:
            - nginxdemo
    demo2:
        image: maartje/demo2
        networks:
            - nginxdemo
```

We starten hier Nginx en 2 demo containers. De demo containers zijn simpele web servers die "hallo van demo x" zeggen.
We merken dat voor Nginx we `./nginx.conf` als volume linken. Zo kunnen we nu de default configuratie gaan overschrijven.

### Reverse proxy

We maken dan ook in dezelfde map een `nginx.conf` aan. We gaan hier een reverse proxy configuratie maken.

```
server {
    listen 80;
    server_name demo1.totaal-geen-bestaand-domein.be;
    location / {
        proxy_pass http://demo1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

In deze configuratie zetten we een virtual host op voor `demo1.totaal-geen-bestaand-domein.be`. Hierbij linken we alle URLs (alles na `/`) door naar de container `demo1`. Met de `proxy_set_header` sturen we ook het originele IP als de hostname mee, hierdoor weet de applicatie dat we via een reverse proxy gegaan zijn.

We kunnen nu deze configuratie nog eens opzetten voor de andere container `demo2`.

```
server {
    listen 80;
    server_name demo2.totaal-geen-bestaand-domein.be;
    location / {
        proxy_pass http://demo2;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

Nu gaat Nginx demo2.totaal-geen-bestaand-domein.be doorsturen naar de container `demo2`. (En demo1.totaal-geen-bestaand-domein.be naar `demo1`).

### Loadbalancing

In het voorbeeld hierboven hebben we een verkeer naar demo1 en demo2 gestuurd op basis van de domeinnaam.
Stel dat demo1 en demo2 dezelfde site hebben kunnen we ook verkeer tussen deze twee containers door een loadbalancer op te zetten.

De configuratie is gelijk, alleen gebruiken we `upstream` on een pseudo server op te zetten die tussen de 2 servers balanceerd.
We vervangen alle configuratie in nginx.conf door de onderstaande:

```
upstream demo-lb {
    server demo1;
    server demo2;
}

server {

    listen 80;
    server_name demo.totaal-geen-bestaand-domein.be;
    location / {
        proxy_pass http://demo-lb;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

Open nu een browser en bezoek `localhost` we merken nu dat Nginx mooi alle verkeer tussen 1 en 2 gaat verdelen.

## References

-   [Cloudflare on reverse proxies](https://www.cloudflare.com/learning/cdn/glossary/reverse-proxy/)

```

```
