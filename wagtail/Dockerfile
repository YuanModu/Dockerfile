FROM alpine

LABEL description "Python application server" \
    maintainer="Atila Satilmis <atila.satilmis@gmail.com>"

ENV PYTHONUNBUFFERED 1
ENV DJANGO_ENV production

RUN set -ex \
    && apk add --no-cache --virtual .build-deps \
        gcc \
        g++ \
        musl-dev \
        python3-dev \
        libjpeg-turbo-dev \
        postgresql-dev \
        zlib-dev \
    && apk add --no-cache \
        python3 \
        libjpeg-turbo \
        libpq \
        libstdc++ \
    && pip3 install --no-cache-dir --upgrade pip wheel \
    && pip3 install --no-cache-dir \
        wagtail \
        django-libsass \
        psycopg2 \
        gunicorn \
    && apk del .build-deps

RUN set -ex \
    && cd /usr/share \
    && wagtail start webapp \
    && python3 webapp/manage.py migrate

WORKDIR /usr/share/webapp

EXPOSE 8000 5432
CMD ["gunicorn", "webapp.wsgi:application", "--bind", "172.17.0.2:8000", "--workers", "3"]
