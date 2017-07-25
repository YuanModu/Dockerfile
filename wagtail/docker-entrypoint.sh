#!/bin/sh
set -e

: ${GIT_REPO:=https://github.com/YuanModu/yuan.com.tr}
: ${MASTER:=true}
: ${VACUUM:=false}
: ${THUNDER_LOCK:=true}
: ${PROCESSES:=4}
: ${THREADS:=4}
: ${HARAKIRI:=20}
: ${MAX_REQUEST:=5000}
: ${POST_BUFFERING:=0}
: ${OFFLOAD_THREADS:=0}
: ${MEMORY_REPORT:=true}


if [ "$1" = 'uwsgi' ]; then
    # Clean files related to some previous run.
    rm -f /run/uwsgi/uwsgi.pid

    # Since we have no init system, runtime folders have to be created manually.
    install -dm700 -o uwsgi -g uwsgi /run/uwsgi

    git clone $GIT_REPO /usr/share/webapp
    chown -R uwsgi.uwsgi /usr/share/webapp
    pip3 install -r requirements.txt

    sed -e "s|@@MASTER@@|$MASTER|" \
    	-e "s|@@VACUUM@@|$VACUUM|" \
    	-e "s|@@THUNDER_LOCK@@|${THUNDER_LOCK}|" \
    	-e "s|@@PROCESSES@@|$PROCESSES|" \
    	-e "s|@@THREADS@@|$THREADS|" \
    	-e "s|@@HARAKIRI@@|$HARAKIRI|" \
    	-e "s|@@MAX_REQUEST@@|$MAX_REQUEST|" \
    	-e "s|@@POST_BUFFERING@@|$POST_BUFFERING|" \
    	-e "s|@@OFFLOAD_THREADS@@|$OFFLOAD_THREADS|" \
    	-e "s|@@MEMORY_REPORT@@|$MEMORY_REPORT|" \
		/defaults.ini.template > /etc/uwsgi/defaults.ini
fi

exec "$@"
