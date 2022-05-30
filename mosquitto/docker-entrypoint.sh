#!/usr/bin/env bash

set -euo pipefail


## Fix write permissions for mosquitto directories
chown --no-dereference --recursive "$USER" /mosquitto/log
chown --no-dereference --recursive "$USER" /mosquitto/data


if [ -z "${MOSQUITTO_USERNAME}" ] || [ -z "${MOSQUITTO_PASSWORD}" ]; then
  echo MOSQUITTO_USERNAME or MOSQUITTO_PASSWORD not defined
  exit 1
fi

## create mosquitto passwordfile
touch passwordfile
mosquitto_passwd -b passwordfile "$MOSQUITTO_USERNAME" "$MOSQUITTO_PASSWORD"

exec "$@"
