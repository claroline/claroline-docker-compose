#!/bin/bash

set -e

echo **************hello******************

echo 'Checking for existing certificates'
if [ ! -f "/certs/cert.pem" ]; then
  echo 'No certificates found matching your app url'
  echo 'Generating self-signed SSL certificates.'
  openssl \
  req -new -newkey rsa:4096 -days 365 -nodes -x509 \
  -subj "/C=AU/ST=NSW/L=Sydney/O=My Org/CN=$APP_URL" \
  -keyout "/etc/ssl/certs/key.pem" \
  -out "/etc/ssl/certs/ca.pem"
  cp /etc/ssl/certs/key.pem /certs/cert.pem
  cat /etc/ssl/certs/ca.pem >> /certs/cert.pem
else
  echo 'Certificates found'
fi

echo 'Checking for claroline install'
if [ ! -d "/var/www/html/claroline/web" ]; then
  echo 'No previous Claroline install found, Installing Claroline'
  curl http://packages.claroline.net/releases/latest/claroline-16.09.tar.gz | tar xzv --strip 1
  chmod -R 777 app/cache app/config app/logs app/sessions files web
  php scripts/configure.php
  composer fast-install
else
  echo 'Claroline found'
fi


#exit 1



echo ***************bye*******************

exec "$@"
