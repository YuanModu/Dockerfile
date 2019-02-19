#!/bin/sh
set -e

: ${NGINX_DOMAIN_NAME:=example.com}
: ${NGINX_UPSTREAM_SERVERS:=127.0.0.1}

if [ "$1" = 'nginx' ]; then
  NGINX_UPSTREAM_SERVERS=$(for SERVER in $NGINX_UPSTREAM_SERVERS; do printf "server %s:8000;\\\n\t\t" $SERVER; done)

  # Remove the last newline and tabs.
  NGINX_UPSTREAM_SERVERS=${NGINX_UPSTREAM_SERVERS::-4}
  sed -e "s|@@NGINX_DOMAIN_NAME@@|$NGINX_DOMAIN_NAME|" \
      -e "s|@@NGINX_UPSTREAM_SERVERS@@|$NGINX_UPSTREAM_SERVERS|" \
      /etc/nginx/conf.d/python.conf.template > /etc/nginx/conf.d/python.conf
fi

exec "$@"
