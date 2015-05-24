#!/bin/bash
set -e

render() {
    : > $2
    while IFS= read line ; do
        while [[ "$line" =~ (\$\{[a-zA-Z_][a-zA-Z_0-9]*\}) ]] ; do
            LHS=${BASH_REMATCH[1]}
            RHS="$(eval echo "\"$LHS\"")"
            line=${line//$LHS/$RHS}
        done
        echo "$line" >> $2
    done < $1
}

: ${UWSGI_PYTHONPATH:=${PROJECT_ROOT}}
: ${UWSGI_MODULE:=${PROJECT_NAME}}
: ${UWSGI_MASTER:=True}
: ${UWSGI_PROCESSES:=4}
: ${UWSGI_VACUUM:=True}

if [ "$1" = 'uwsgi' ]; then
    if [ ! -h /defaults.ini ]; then
        render ${PROJECT_ROOT}/defaults.ini.template ${PROJECT_ROOT}/defaults.ini
        ln -sf ${PROJECT_ROOT}/defaults.ini /defaults.ini
    fi
fi

exec "$@"
