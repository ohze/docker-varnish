# we don't use alpine because varnish package in alpine is outdated
FROM debian:stretch-slim

LABEL maintainer="Ohze JSC <thanhbv@sandinh.net>"

ARG VERSION_STR=varnish40
ARG BUILD_PACKAGES="curl apt-transport-https gnupg2"

# https://packagecloud.io/varnishcache/varnish40/install#manual
RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        $BUILD_PACKAGES && \
    echo "\
deb https://packagecloud.io/varnishcache/$VERSION_STR/debian/ stretch main \n\
deb-src https://packagecloud.io/varnishcache/$VERSION_STR/debian/ stretch main" > /etc/apt/sources.list.d/varnish.list && \
    curl -L https://packagecloud.io/varnishcache/$VERSION_STR/gpgkey | apt-key add - && \
    apt-get update && apt-get install -y \
        varnish && \
    apt-get purge -y --auto-remove $BUILD_PACKAGES && \
    rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT  ["/docker-entrypoint.sh"]

ENV VARNISH_SECRET=""

CMD ["varnishd", "-F", \
 "-a", ":6081", \
 "-T", "127.0.0.1:6082", \
 "-f", "/etc/varnish/default.vcl", \
 "-S", "/etc/varnish/secret", \
 "-s", "file,/var/lib/varnish/storage.bin,1G", \
 "-t", "120"]
