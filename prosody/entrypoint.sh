#!/bin/bash
set -e

if [ -f "/etc/prosody/conf.d/claroline.cfg.lua" ]; then
  rm /etc/prosody/conf.d/claroline.cfg.lua
fi

echo "VirtualHost \"$APP_URL\"" >> /etc/prosody/conf.d/claroline.cfg.lua

if [[ "$1" != "prosody" ]]; then
    exec prosodyctl $*
    exit 0;
fi

if [ "$LOCAL" -a  "$PASSWORD" -a "$DOMAIN" ] ; then
    prosodyctl register $LOCAL $DOMAIN $PASSWORD
fi

exec "$@"
