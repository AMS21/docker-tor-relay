#!/usr/bin/env bash

set -e
set -u

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

docker build -t "ams21/tor-relay:latest" "${SCRIPT_DIR}"
