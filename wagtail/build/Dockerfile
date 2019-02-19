FROM alpine

LABEL description "Python application server" \
	maintainer="Atila Satilmis <atila.satilmis@gmail.com>"

RUN set -ex \
    && apk add --no-cache --virtual .build-deps \
        build-base \
        python3-dev \
        libjpeg-turbo-dev \
        zlib-dev \
        tiff-dev \
        freetype-dev \
        lcms2-dev \
        libwebp-dev \
        openjpeg-dev \
    && apk add --no-cache \
        python3 \
        uwsgi \
        uwsgi-python3 \
        py3-psycopg2 \
        git \
        libjpeg-turbo \
        zlib \
        tiff \
        freetype \
        lcms2 \
        libwebp \
        openjpeg \
    && pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir \
        wagtail \
        django-compressor \
        django-libsass \
    && apk del .build-deps

COPY docker-defaults.ini.template /defaults.ini.template

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8000 5432
CMD ["uwsgi", "--ini", "/etc/uwsgi/defaults.ini"]
