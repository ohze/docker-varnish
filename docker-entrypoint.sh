#!/bin/sh

if [ "${1}" = "varnishd" ]; then
    [ -z "$VARNISH_SECRET" ] || echo ${VARNISH_SECRET} > /etc/varnish/secret

    if [ `ulimit -n` -lt 131072 ]; then
        ulimit -n 131072
        if [ $? -ne 0 ]; then
            echo "\
ulimit -n = `ulimit -n` is way too small for varnish\n\
Pls run docker with '--ulimit nofile=131072:131072' or '--cap-add SYS_RESOURCE' option"
            exit
        fi
    fi
    if [ `ulimit -l` -lt 82000 ]; then
        ulimit -l 82000
        if [ $? -ne 0 ]; then
            echo "\
ulimit -l = `ulimit -l` is way too small for varnish.\n\
Pls run docker with '--ulimit memlock=83968000' or '--cap-add SYS_RESOURCE' option"
            exit
        fi
    fi
fi

exec "$@"
