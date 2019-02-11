FROM yuanmodu/arm64v8-alpine

LABEL description "Python application server" \
	maintainer="Atila Satilmis <atila.satilmis@gmail.com>"

RUN set -x \
	&& apk add --no-cache --virtual .build-deps \
		zlib-dev \
		build-base \
		python3-dev \
		libjpeg-turbo-dev \
		libwebp-dev \
		tiff-dev

RUN set -x \
	&& apk add --no-cache \
		python3 \
		uwsgi \
		uwsgi-python3 \
		py3-psycopg2 \
		git \
		libjpeg-turbo \
		libwebp \
		tiff \
		freetype \
		lcms2

RUN set -x \
	&& pip3 install --no-cache-dir --upgrade pip \
	&& pip3 install --no-cache-dir \
		wagtail \
		django-compressor \
		django-libsass


RUN set -x \
	&& apk del .build-deps

COPY docker-defaults.ini.template /defaults.ini.template

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8000 5432
CMD ["uwsgi", "--ini", "/etc/uwsgi/defaults.ini"]
