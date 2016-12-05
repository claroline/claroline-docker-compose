#!/bin/bash
docker-compose exec certbot certbot certonly --webroot --agree-tos -m ${CERT_EMAIL} -d ${DOMAIN_NAME} -w /var/www/html/claroline/web
