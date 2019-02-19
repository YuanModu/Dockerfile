FROM nginx:alpine

# Remove the default configuration files
RUN set -x \
  && rm -f \
    /etc/nginx/nginx.conf.default \
    /etc/nginx/conf.d/default.conf

# Copy the configuration files.
COPY docker-nginx.conf              /etc/nginx/nginx.conf
COPY docker-python.conf.template    /etc/nginx/conf.d/python.conf.template
# COPY docker-static-conf.template    /etc/nginx/conf.d/static.conf.template

COPY docker-entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

EXPOSE 80 8000
CMD ["nginx", "-g", "daemon off;"]
