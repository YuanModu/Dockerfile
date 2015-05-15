FROM yuanmodu/archlinux

MAINTAINER Atila Satilmis "atila.satilmis@gmail.com"

RUN pacman -Syu nsd --noconfirm --needed \
    && pacman -Scc --noconfirm

# Base image doesn't have systemd-tmpfiles command.
# We have to put the directory in place manually.
RUN mkdir /run/nsd && chown -R nsd:nsd /run/nsd

# Forward nsd logs to docker log collector.
RUN ln -sf /dev/stdout /var/log/nsd.log

# Generate SSL keys and certificates.
RUN nsd-control-setup

# Copy NSD config file and zonefiles.
ONBUILD COPY nsd.conf /etc/nsd/
ONBUILD COPY *.zone /etc/nsd/

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 53/udp
CMD ["nsd", "-d", "-c", "/etc/nsd/nsd.conf"]
