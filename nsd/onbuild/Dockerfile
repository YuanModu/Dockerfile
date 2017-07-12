FROM arm64v8/alpine

RUN set -x \
	&& apk add --no-cache nsd \
	&& rm -rf /var/cache/apk/*

# Copy NSD config file and zonefiles.
ONBUILD COPY nsd.conf /etc/nsd/
ONBUILD COPY *.zone /etc/nsd/

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 53 53/udp
CMD ["nsd", "-d"]
