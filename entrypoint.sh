#!/usr/bin/env sh

set -e
set -u

# Nickname
NICK=${NICKNAME:-DockerTorRelay}

# Bandwith
RATE=${BANDWITHDRATE:-"20 MBits"}
BURST=${BANDWITHDBURST:-"40 MBits"}

echo "Using NICKNAME=${NICK}, OR_PORT=${OR_PORT}, DIR_PORT=${DIR_PORT}, and EMAIL=${EMAIL}."

ADDITIONAL_VARIABLES_PREFIX="TORRC_"
ADDITIONAL_VARIABLES="# Additional properties from processed '$ADDITIONAL_VARIABLES_PREFIX' environment variables"

IFS=$'\n'
for V in $(env | grep "^$ADDITIONAL_VARIABLES_PREFIX"); do
    VKEY_ORG="$(echo $V | cut -d '=' -f1)"
    VKEY="${VKEY_ORG#$ADDITIONAL_VARIABLES_PREFIX}"
    VVALUE="$(echo $V | cut -d '=' -f2)"
    echo "Overriding '$VKEY' with value '$VVALUE'"
    ADDITIONAL_VARIABLES="$ADDITIONAL_VARIABLES"$'\n'"$VKEY $VVALUE"
done

cat >/etc/tor/torrc <<EOF
# For more information see https://2019.www.torproject.org/docs/tor-manual.html.en
RunAsDaemon 0

ORPort ${OR_PORT}
DirPort ${DIR_PORT}
ControlPort 9051
# We don't need an open SOCKS port.
SocksPort 0

# User info
Nickname ${NICK}
ContactInfo ${EMAIL}

# Logging
Log notice file /var/log/tor/log
Log notice stdout

# Bandwithrating
BandwidthRate ${RATE}
BandwidthBurst ${BURST}

CookieAuthentication 1
# We're not an exit relay
ExitRelay 0
ExitPolicy reject *:*

User tor
DataDirectory /var/lib/tor

$ADDITIONAL_VARIABLES
EOF

echo "Starting tor."
tor -f /etc/tor/torrc
