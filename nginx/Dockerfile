FROM yuanmodu/archlinux

MAINTAINER Atila Satilmis "atila.satilmis@gmail.com"

RUN pacman -Syu nginx --noconfirm --needed \
    && pacman -Sc --noconfirm

# Forward request and error logs to docker log collector.
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log
    
# Export the root path of dirs that will be served.
ENV PROJECT_ROOT /srv/http
WORKDIR ${PROJECT_ROOT}

# Copy the configuration file template and static files.
COPY docker-nginx.conf.template nginx.conf.template
ONBUILD COPY static static/

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80 8000
CMD ["nginx", "-g", "daemon off;"]
