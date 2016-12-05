# claroline-docker-compose

## Installing (with a self signed certificate)

1) Add your prosody virtualhost to prosody/config/prosody.cfg.lua

2) To install the platform

```
docker-compose up -d --build
docker-compose exec web php app/console claroline:user:create -a Jhon Doe admin pass admin@mydomain.com
```

## Obtaining a real "let's encrypt" certificate

```
docker-compose exec prosody bash
$ certbot certonly --webroot --agree-tos -m ${CERT_EMAIL} -d ${DOMAIN_NAME} -w /var/www/html/claroline/web
$ cat /etc/letsencrypt/live/${DOMAIN_NAME}/fullchain.pem /etc/letsencrypt/live/${DOMAIN_NAME}/privkey.pem > /certs/cert.pem
```

The haproxy container needs to be restarted for the new certificate to work

```
docker-compose restart lb
```
