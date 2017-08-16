# [docker-varnish](https://hub.docker.com/r/sandinh/varnish/)

Docker image for [varnish](https://www.varnish-cache.org/), based on [debian:stretch-slim](https://hub.docker.com/_/debian/).

We don't use alpine for now because varnish package in alpine is outdated.

## usage
```bash
docker run --rm -d -p 6081:6081 --cap-add SYS_RESOURCE \
    -v `pwd`/default.vcl:/etc/varnish/default.vcl sandinh/varnish
# or
docker run --rm -d -p 6081:6081 --ulimit nofile=131072:131072 --ulimit memlock=83968000 \
    -v `pwd`/default.vcl:/etc/varnish/default.vcl sandinh/varnish
# or
docker run --rm -d -p 6081:6081 --ulimit nofile=131072:131072 --ulimit memlock=83968000 \
    -v `pwd`/default.vcl:/etc/varnish/default.vcl sandinh/varnish \
    varnishd -F -a :6081 \
        -T 127.0.0.1:6082 \
        -f /etc/varnish/default.vcl \
        -S /etc/varnish/secret \
        -s s0=malloc,20m \
        -s s1=file,/tmp,100M \
        -t 120

#or
docker run --rm -d -p 6081:6081 --cap-add SYS_RESOURCE \
    -v `pwd`/default.vcl.tpl:/etc/varnish/default.vcl.tpl sandinh/varnish:consul-template
#...
```

## Licence
This software is licensed under the Apache 2 license:
http://www.apache.org/licenses/LICENSE-2.0

Copyright 2017 Sân Đình (https://sandinh.com)
