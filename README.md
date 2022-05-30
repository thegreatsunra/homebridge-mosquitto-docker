# homebridge-mosquitto-docker

> Homebridge and Mosquitto in Docker containers via `docker-compose`

- Homebridge in a Docker container
- Mosquitto in a Docker container, with:
  - Self-signed TLS at port `8883`
  - Required MQTT username/password at ports `1883` and `8883`

## Usage

1. Copy `./mosquitto/example.env` to `./mosquott/.env` and update the variable values it contains as suits your purposes.

2. Run the thing:

```shell
git clone https://github.com/thegreatsunra/homebridge-mosquitto-docker.git
cd homebridge-mosquitto-docker
docker-compose -p homebridge up -d
```

## License

MIT
