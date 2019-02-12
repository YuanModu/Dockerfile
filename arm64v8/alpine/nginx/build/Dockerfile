FROM nginx:alpine

# Copy the configuration files.
COPY docker-nginx.conf              /etc/nginx/nginx.conf
COPY docker-python.conf.template    /etc/nginx/conf.d/python.conf.template
# COPY docker-static-conf.template    /etc/nginx/conf.d/static.conf.template

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80 8000
CMD ["nginx", "-g", "daemon off;"]
