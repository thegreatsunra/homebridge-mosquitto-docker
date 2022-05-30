#!/usr/bin/env bash

set -euo pipefail

function generate_CA () {
  echo "$SUBJECT_CA"
  openssl req -x509 -nodes -sha256 -newkey rsa:2048 -subj "$SUBJECT_CA" -days 365 -keyout ca.key -out ca.crt
}
function generate_server () {
  echo "$SUBJECT_SERVER"
  openssl req -nodes -sha256 -new -subj "$SUBJECT_SERVER" -keyout server.key -out server.csr
  openssl x509 -req -sha256 -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 365
}
function generate_client () {
  echo "$SUBJECT_CLIENT"
  openssl req -new -nodes -sha256 -subj "$SUBJECT_CLIENT" -out client.csr -keyout client.key
  openssl x509 -req -sha256 -in client.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out client.crt -days 365
}
generate_CA
generate_server
generate_client

mkdir -p /mosquitto/config/certs \
  && cp ./ca.crt ./server.crt ./server.key /mosquitto/config/certs \
  && chown --no-dereference --recursive "$USER" /mosquitto/config/certs \
  && rm ca.crt ca.key ca.srl \
  && rm client.crt client.csr client.key \
  && rm server.crt server.csr server.key \

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
