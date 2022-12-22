FROM alpine:edge

RUN apk add --no-cache tor
RUN apk add --update \
    python3 \
    python3-dev \
    py3-pip \
    build-base

RUN pip install --no-cache-dir wheel
RUN pip install --no-cache-dir nyx

EXPOSE 9050 9051

VOLUME ["/var/lib/tor"]

USER tor

CMD ["/usr/bin/tor"]
