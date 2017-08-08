FROM yuanmodu/arm64v8-alpine

LABEL description "Posgresql database server" \
	maintainer="Atila Satilmis <atila.satilmis@gmail.com>"

RUN set -ex \
	&& apk add --no-cache postgresql su-exec

RUN install -o postgres -g postgres -dm2777 /run/postgresql
RUN install -o postgres -g postgres -d /var/lib/postgresql
ENV PGDATA /var/lib/postgresql/data
RUN install -o postgres -g postgres -dm777 "$PGDATA"

ENV LANG en_US.utf8

RUN sed -ri "s!^#?(listen_addresses)\s*=\s*\S+.*!\1 = '*'!" \
	/usr/share/postgresql/postgresql.conf.sample

EXPOSE 5432

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["postgres"]
