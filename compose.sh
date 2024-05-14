#!/usr/bin/env bash

set -e
set -u

OR_PORT=443 DIR_PORT=80 EMAIL=you@email.com \
    docker-compose up -d
