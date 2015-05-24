FROM yuanmodu/archlinux

MAINTAINER Atila Satilmis "atila.satilmis@gmail.com"

RUN pacman -Syu python python-pip gcc libjpeg-turbo sqlite3 --noconfirm --needed \
    && pacman -Sc --noconfirm

ENV LANG en_US.utf8

RUN pip install uwsgi
RUN pip install mezzanine

# Export the python project root path that will be served by uWSGI.
ENV PROJECT_ROOT /srv/http
ENV PYTHONPATH ${PROJECT_ROOT}
WORKDIR ${PROJECT_ROOT}

# Copy uWSGI ini files.
COPY docker-defaults.ini.template defaults.ini.template

ENV PROJECT_NAME webapp
RUN mezzanine-project ${PROJECT_NAME}
ONBUILD COPY local_settings.py ${PROJECT_NAME}/
ONBUILD RUN python ${PROJECT_NAME}/manage.py createdb --noinput
ONBUILD RUN python ${PROJECT_NAME}/manage.py collectstatic --noinput

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Expose nginx and postgresql ports.
EXPOSE 8000 5432
CMD ["uwsgi", "--ini", "/defaults.ini"]
