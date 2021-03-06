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

echo 'Checking for claroline install'
if [ ! -d "/var/www/html/claroline/web" ]; then
  echo 'No previous Claroline Connect install found, Installing Claroline Connect...'
  curl http://packages.claroline.net/releases/16.09/claroline-16.09.tar.gz | tar xzv --strip 1
  chmod -R 777 app/cache app/config app/logs app/sessions files web/uploads
  php scripts/configure.php
  composer fast-install
  echo '*********************************************************************************************************************'
  echo "Creating default admin user : ${ADMIN_FIRSTNAME} ${ADMIN_LASTNAME} ${ADMIN_USERNAME} ${ADMIN_PASSWORD} ${ADMIN_EMAIL}"
  echo '*********************************************************************************************************************'

  php app/console claroline:user:create -a ${ADMIN_FIRSTNAME} ${ADMIN_LASTNAME} ${ADMIN_USERNAME} ${ADMIN_PASSWORD} ${ADMIN_EMAIL}

  if [[ -v PLATFORM_NAME ]]; then
    echo "Changing platform name to $PLATFORM_NAME";
    sed -i "/name: claroline/c\name: $PLATFORM_NAME" app/config/platform_options.yml
  fi

  if [[ -v PLATFORM_SUPPORT_EMAIL ]]; then
    echo "Changing platform support email to $PLATFORM_SUPPORT_EMAIL";
    sed -i "/support_email: null/c\support_email: $PLATFORM_SUPPORT_EMAIL" app/config/platform_options.yml
  fi

  if [[ -v PLATFORM_SSL_ENABLED ]]; then
    echo "Changing ssl enabled to $PLATFORM_SSL_ENABLED";
    sed -i "/ssl_enabled: false/c\ssl_enabled: $PLATFORM_SSL_ENABLED" app/config/platform_options.yml
  fi

  # Set up chat
  if [[ -v PLATFORM_CHAT_XMPP_HOST ]]; then
    echo "Setting chat XMPP host to $PLATFORM_CHAT_XMPP_HOST";
    echo "chat_xmpp_host: $PLATFORM_CHAT_XMPP_HOST" >> app/config/platform_options.yml
    unset PLATFORM_CHAT_XMPP_HOST
  fi

  if [[ -v PLATFORM_CHAT_ADMIN_USERNAME ]]; then
    echo "Setting chat admin username to $PLATFORM_CHAT_ADMIN_USERNAME";
    echo "chat_admin_username: $PLATFORM_CHAT_ADMIN_USERNAME" >> app/config/platform_options.yml
    unset PLATFORM_CHAT_ADMIN_USERNAME
  fi

  if [[ -v PLATFORM_CHAT_ADMIN_PASSWORD ]]; then
    echo "Setting chat admin password to $PLATFORM_CHAT_ADMIN_PASSWORD";
    echo "chat_admin_password: $PLATFORM_CHAT_ADMIN_PASSWORD" >> app/config/platform_options.yml
    unset PLATFORM_CHAT_ADMIN_PASSWORD
  fi

  if [[ -v PLATFORM_CHAT_BOSH_PORT ]]; then
    echo "Setting chat BOSH port to $PLATFORM_CHAT_BOSH_PORT";
    echo "chat_bosh_port: $PLATFORM_CHAT_BOSH_PORT" >> app/config/platform_options.yml
    unset PLATFORM_CHAT_BOSH_PORT
  fi

  if [[ -v PLATFORM_CHAT_SSL ]]; then
    echo "Setting chat ssl to $PLATFORM_CHAT_SSL";
    echo "chat_ssl: $PLATFORM_CHAT_SSL" >> app/config/platform_options.yml
    unset PLATFORM_CHAT_SSL
  fi

  if [[ -v PLATFORM_CHAT_XMPP_MUC_HOST ]]; then
    echo "Setting chat XMPP MUC host to $PLATFORM_CHAT_XMPP_MUC_HOST";
    echo "chat_xmpp_muc_host: $PLATFORM_CHAT_XMPP_MUC_HOST" >> app/config/platform_options.yml
    unset PLATFORM_CHAT_XMPP_MUC_HOST
  fi

  echo 'Claroline Connect has finished installing.'

else
  echo 'Claroline Connect found, no need to install it again.'
fi

#exit 1

exec "$@"
