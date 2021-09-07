FROM --platform=$BUILDPLATFORM node:16 as frontend

COPY ./ /go/src/github.com/meyskens/devops-graduaten

WORKDIR /go/src/github.com/meyskens/devops-graduaten

RUN npm install
RUN npm run build

FROM nginx:1.21-alpine

RUN mkdir -p /var/www/SAT
WORKDIR /var/www/SAT

COPY --from=frontend  /go/src/github.com/meyskens/devops-graduaten/build /var/www/
COPY nginx.conf /etc/nginx/conf.d/default.conf
