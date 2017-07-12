#!/bin/bash
set -e

if [ "$1" = 'nsd' ]; then
    # Clean files related to some previous run.
    rm -f /var/run/nsd/nsd.pid
    rm -f /var/db/nsd/{nsd.db,xfrd.state}
fi

exec "$@"
