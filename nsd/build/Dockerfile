FROM alpine

LABEL description "Simple DNS authoritative server" \
    maintainer="Atila Satilmis <atila.satilmis@gmail.com>"

RUN set -ex \
    && apk add --no-cache nsd \
    && apk add --no-cache openssl

# Copy NSD config file and zonefiles.
COPY docker-nsd.conf.template /nsd.conf.template
COPY docker-nsd.zone.template /nsd.zone.template

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 53 53/udp
CMD ["nsd", "-d"]
