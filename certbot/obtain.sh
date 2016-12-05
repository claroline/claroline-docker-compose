#!bin/bash
certbot certonly --webroot --agree-tos -m ${CERT_EMAIL} -d ${DOMAIN_NAME} -w /var/www/html/claroline/web
cat /etc/letsencrypt/live/${DOMAIN_NAME}/fullchain.pem /etc/letsencrypt/live/${DOMAIN_NAME}/privkey.pem > /certs/cert.pem
