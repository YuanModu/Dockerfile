#!/bin/sh
set -e

if [ "$1" = 'nsd' ]; then
    # Clean files related to some previous run.
    rm -f /var/run/nsd/nsd.pid
    rm -f /var/db/nsd/nsd.db
    rm -f /var/db/nsd/xfrd.state

    # Since we have no init system, runtime folders have to be created manually.
    install -dm700 -o nsd -g nsd /var/run/nsd/
    install -dm700 -o nsd -g nsd /var/db/nsd/
    
    nsd-control-setup
fi

exec "$@"
