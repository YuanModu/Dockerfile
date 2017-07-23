FROM yuanmodu/alpine-arm32v7

LABEL description "Simple DNS authoritative server" \
	maintainer="Atila Satilmis <atila.satilmis@gmail.com>"


RUN set -x \
	&& apk add --no-cache nginx \
	&& install -dm700 -o nginx -g nginx /run/nginx

# Copy the configuration file template and static files.
COPY docker-nginx.conf.template /nginx.conf.template

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80 8000
CMD ["nginx", "-g", "daemon off;"]
