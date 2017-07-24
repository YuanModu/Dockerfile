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
		tiff-dev

	&& pip install wagtail

	&& rm -rf /root/.cache/
	&& apk del .build-deps

	&& apk add --no-cache \
		python3 \
		libjpeg-turbo \
		libwebp \
		tiff \
		freetype \
		lcms2

EXPOSE 8000 5432
CMD ["sh"]
