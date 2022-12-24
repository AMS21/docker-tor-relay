#!/bin/bash -eu

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# Make sure the latest images was build
./build.sh

# Create volume
docker volume create tor-relay-volume

docker run -d --name tor-relay \
  -p 127.0.0.1:9050:9050 \
  -p 9001:9001 \
  -p 9030:9030 \
  -p 127.0.0.1:9051:9051 \
  --volume "${SCRIPT_DIR}/config/torrc":/etc/tor/torrc:ro \
  --volume /etc/localtime:/etc/localtime \
  --volume tor-relay-volume:/var/lib/tor:rw \
  ams21/tor-relay:latest
