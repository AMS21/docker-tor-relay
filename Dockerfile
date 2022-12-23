FROM alpine:edge

RUN apk add --no-cache \
    tor \
    python3 \
    python3-dev \
    py3-pip \
    build-base \
    sudo

RUN rm -rf "/var/cache/apk/*"

RUN pip install --no-cache-dir wheel
RUN pip install --no-cache-dir nyx

EXPOSE 9050 9051

VOLUME ["/var/lib/tor"]

# Entry point
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/bin/sh", "entrypoint.sh"]
CMD ["/usr/bin/tor"]
