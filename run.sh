#!/bin/bash -eu

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# Make sure the latest images was build
./build.sh

# Create volume
docker volume create tor-relay-volume

OR_PORT=9001
DIR_PORT=9030

docker run -d --name tor-relay \
  --volume tor-relay-volume:/var/lib/tor:rw \
  -e OR_PORT=${OR_PORT} \
  -e DIR_PORT=${DIR_PORT} \
  -e EMAIL=you@email.com \
  ams21/tor-relay:latest
