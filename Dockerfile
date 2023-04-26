FROM alpine:3.17

LABEL maintainer="admin@restsend.com"
LABEL org.opencontainers.image.source=https://github.com/restsend/docker-rspamd

RUN addgroup -g 2000 rspamd && \
    adduser -u 2000 -G rspamd -h /var/lib/rspamd -D -s /sbin/nologin rspamd

RUN apk update && \
    apk --no-cache add rspamd rspamd-proxy rspamd-utils rspamd-controller

COPY rspamd/local.d/ /etc/rspamd/local.d/

EXPOSE 11332 11333 11334

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "sh", "/entrypoint.sh" ]