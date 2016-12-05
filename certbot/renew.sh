#!bin/bash
certbot renew --post-hook 'cat /etc/letsencrypt/live/${DOMAIN_NAME}/fullchain.pem /etc/letsencrypt/live/${DOMAIN_NAME}/privkey.pem > /certs/haproxy/cert.pem
