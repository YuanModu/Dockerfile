#!/bin/sh
set -e

: ${NSD_DOMAIN_NAME:=example.com}
: ${NSD_DOMAIN_IP:=127.0.0.1}

if [ "$1" = 'nsd' ]; then
    # Clean files related to some previous run.
    rm -f /var/run/nsd/nsd.pid
    rm -f /var/db/nsd/nsd.db
    rm -f /var/db/nsd/xfrd.state

    # Since we have no init system, runtime folders have to be created manually.
    install -dm700 -o nsd -g nsd /var/run/nsd/
    install -dm700 -o nsd -g nsd /var/db/nsd/

    sed -e "s|@@NSD_DOMAIN_NAME@@|$NSD_DOMAIN_NAME|" \
  		/nsd.conf.template > /etc/nsd/nsd.conf

    sed -e "s|@@NSD_DOMAIN_NAME@@|$NSD_DOMAIN_NAME|g" \
        -e "s|@@NSD_DOMAIN_IP@@|$NSD_DOMAIN_IP|" \
      /nsd.zone.template > /etc/nsd/$NSD_DOMAIN_NAME.zone

    nsd-control-setup
fi

exec "$@"
