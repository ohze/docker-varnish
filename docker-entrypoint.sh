#!/bin/sh
set -x

if [ "${1}" = "varnishd" ]; then
    [ -z "$VARNISH_SECRET" ] || echo ${VARNISH_SECRET} > /etc/varnish/secret

    if [ `ulimit -n` -lt 131072 ] || [ `ulimit -l` -lt 82000 ]; then
        echo "\
ulimit NFILES or MEMLOCK is way too small for varnish.\n\
Pls run docker with '--ulimit nofile=131072:131072 --ulimit memlock=83968000' options"
        exit
    fi
fi
exec "$@"
