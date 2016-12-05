# claroline-docker-compose

## Installing (with a self signed certificate)
1) Copy .env.dist to .env

```
cp .env.dist .env
```
2) Change the values in .env to suit your environment


3) Add your prosody virtualhost to prosody/config/prosody.cfg.lua

```
echo "VirtualHost \"mydomain.com\"" >> prosody/config/prosody.cfg.lua
```

4) To build and start the platform

```
docker-compose up -d --build
```

5) Create your default Claroline Connect user

```
docker-compose exec web php app/console claroline:user:create -a Jhon Doe admin pass admin@mydomain.com
```

## Obtaining a "let's encrypt" certificate

```
docker-compose exec certbot ./obtain.sh
docker-compose restart lb
```

## Renewing a "let's encrypt" certificate

This should be set to a CRON task twice daily

```
docker-compose exec certbot ./renew.sh
docker-compose restart lb
```
