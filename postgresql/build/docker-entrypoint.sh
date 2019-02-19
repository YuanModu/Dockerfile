#!/bin/sh

set -e

if [ "$1" = 'postgres' ]; then

    if [ -z "$(ls -A "$PGDATA")" ]; then
        su-exec postgres initdb

        : ${POSTGRES_USER:="postgres"}
        : ${POSTGRES_DB:=$POSTGRES_USER}

        if [ "$POSTGRES_PASSWORD" ]; then
          pass="PASSWORD '$POSTGRES_PASSWORD'"
          authMethod=md5
        else
          echo "==============================="
          echo "!!! Use \$POSTGRES_PASSWORD env var to secure your database !!!"
          echo "==============================="
          pass=
          authMethod=trust
        fi
        echo

        if [ "$POSTGRES_DB" != 'postgres' ]; then
          createSql="CREATE DATABASE $POSTGRES_DB;"
          echo $createSql | su-exec postgres postgres --single -jE
          echo
        fi

        if [ "$POSTGRES_USER" != 'postgres' ]; then
          op=CREATE
        else
          op=ALTER
        fi

        userSql="$op USER $POSTGRES_USER WITH SUPERUSER $pass;"
        echo $userSql | su-exec postgres postgres --single -jE
        echo

        # internal start of server in order to allow set-up using psql-client
        # does not listen on TCP/IP and waits until start finishes
        su-exec postgres pg_ctl -D "$PGDATA" \
            -o "-c listen_addresses=''" \
            -w start

        su-exec postgres pg_ctl -D "$PGDATA" -m fast -w stop

        { echo; echo "host all all 0.0.0.0/0 $authMethod"; } >> "$PGDATA"/pg_hba.conf
    fi

    exec su-exec postgres postgres
fi

exec "$@"
