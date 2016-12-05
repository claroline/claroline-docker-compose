#!/bin/bash

set -e

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
