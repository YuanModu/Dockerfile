#!/bin/sh
set -e

: ${NGINX_DOMAIN_NAME:=example.com}

if [ "$1" = 'nginx' ]; then
        # Clean files related to some previous run.
        rm -f /run/nginx/nginx.pid

        # Since we have no init system, runtime folders have to be created manually.
        install -dm700 -o nginx -g nginx /run/nginx

	sed "s|@@NGINX_DOMAIN_NAME@@|$NGINX_DOMAIN_NAME|" \
		/nginx.conf.template > /etc/nginx/nginx.conf
fi

exec "$@"
