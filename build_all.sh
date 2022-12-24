#!/bin/bash -eu

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# If this fails check the link to learn how to setup a multi architecture builder
# https://cloudolife.com/2022/03/05/Infrastructure-as-Code-IaC/Container/Docker/Docker-buildx-support-multiple-architectures-images/

docker buildx build --tag "ams21/tor-relay:latest" --platform "linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64/v8,linux/i386,linux/ppc64le,linux/riscv64" --pull "${SCRIPT_DIR}"
