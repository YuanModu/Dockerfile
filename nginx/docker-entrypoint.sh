#!/bin/sh
set -e

: ${NGINX_DOMAIN_NAME:=example.com}

if [ "$1" = 'nginx' ]; then
	sed "s|@@NGINX_DOMAIN_NAME@@|$NGINX_DOMAIN_NAME|" \
		/nginx.conf.template > /etc/nginx/nginx.conf
fi

exec "$@"
