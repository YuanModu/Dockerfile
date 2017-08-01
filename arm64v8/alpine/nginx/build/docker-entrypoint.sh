#!/bin/sh
set -e

: ${NGINX_DOMAIN_NAME:=yuan.com.tr}
: ${NGINX_DOMAIN_PORT:=80}
: ${NGINX_UPSTREAM_SERVERS:=127.0.0.1}

if [ "$1" = 'nginx' ]; then
        # Clean files related to some previous run.
        rm -f /run/nginx/nginx.pid

        # Since we have no init system, runtime folders have to be created manually.
        install -dm700 -o nginx -g nginx /run/nginx

	NGINX_UPSTREAM_SERVERS=$(for SERVER in $NGINX_UPSTREAM_SERVERS; do printf "server %s:8000;" $SERVER; done)
	sed -e "s|@@NGINX_DOMAIN_NAME@@|$NGINX_DOMAIN_NAME|" \
	    -e "s|@@NGINX_DOMAIN_PORT@@|$NGINX_DOMAIN_PORT|" \
	    -e "s|@@NGINX_UPSTREAM_SERVERS@@|$NGINX_UPSTREAM_SERVERS|" \
		/nginx.conf.template > /etc/nginx/nginx.conf
fi

exec "$@"
