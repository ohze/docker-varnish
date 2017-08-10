#!/bin/sh
set -x

[ -z "$VARNISH_SECRET" ] || echo ${VARNISH_SECRET} > /etc/varnish/secret

if [ `ulimit -n` -lt 131072 ]; then
    echo "\
'ulimit -n' = `ulimit -n` is way too small for varnish.\n\
Pls run docker with '--ulimit nofile=131072:131072' option"
    exit
fi

exec "$@"
