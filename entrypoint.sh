#!/bin/bash -eu

adduser tor

chown -R tor: /var/lib/tor

sudo -u tor "$@"
