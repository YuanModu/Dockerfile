#!/bin/sh
set -e

if [ "$1" = 'nsd' ]; then
    # Clean files related to some previous run.
    rm -f /var/run/nsd/nsd.pid
    rm -f /var/db/nsd/{nsd.db,xfrd.state}
    install -d -o nsd -g nsd -m 0700 /var/run/nsd
fi

exec "$@"
