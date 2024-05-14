FROM alpine:edge

RUN apk update && apk upgrade --no-cache && \
    apk add --no-cache tor libcap-utils && \
    setcap cap_net_bind_service=+ep /usr/bin/tor && \
    chown tor: /etc/tor && \
    chown tor: /var/lib/tor && \
    chown tor: /var/log/tor && \
    rm -rf /var/cache/apk/*

COPY --chmod=0755 entrypoint.sh /usr/local/bin

CMD [ "/usr/local/bin/entrypoint.sh" ]
