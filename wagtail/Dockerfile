FROM yuanmodu/alpine-arm32v7

LABEL description "Python application server" \
	maintainer="Atila Satilmis <atila.satilmis@gmail.com>"

RUN set -x \
	&& apk add --no-cache --virtual .build-deps \
		zlib-dev \
		build-base \
		python3-dev \
		libjpeg-turbo-dev \
		libwebp-dev \
		tiff-dev \

	&& pip3 install --no-cache-dir wagtail \

	&& apk del .build-deps \

	&& apk add --no-cache \
		python3 \
		uwsgi \
		uwsgi-python3 \
		libjpeg-turbo \
		libwebp \
		tiff \
		freetype \
		lcms2

COPY docker-entrypoint.sh /entrypoint.sh
COPY docker-defaults.ini.template /defaults.ini.template

EXPOSE 8000 5432
CMD ["uwsgi", "--ini", "/etc/uwsgi/defaults.ini"]
