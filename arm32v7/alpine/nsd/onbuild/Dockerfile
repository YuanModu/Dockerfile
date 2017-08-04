FROM yuanmodu/arm32v7-alpine

LABEL description "Simple DNS authoritative server" \
	maintainer="Atila Satilmis <atila.satilmis@gmail.com>"

RUN set -ex \
	&& apk add --no-cache nsd

# Copy NSD config file and zonefiles.
ONBUILD COPY nsd.conf /etc/nsd/
ONBUILD COPY *.zone /etc/nsd/

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 53 53/udp
CMD ["nsd", "-d"]
