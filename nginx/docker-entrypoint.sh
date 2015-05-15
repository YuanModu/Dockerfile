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

if [ "$1" = 'nginx' ]; then
    if [ ! -h /etc/nginx/nginx.conf  ]; then
        render ${PROJECT_ROOT}/nginx.conf.template ${PROJECT_ROOT}/nginx.conf
        ln -sf ${PROJECT_ROOT}/nginx.conf /etc/nginx/nginx.conf
    fi

fi

exec "$@"
