# homebridge-mosquitto-docker

> Homebridge and Mosquitto in Docker containers via `docker-compose`

- Homebridge in a Docker container
- Mosquitto in a Docker container, with:
  - Self-signed TLS at port `8883`
  - Required MQTT username/password at ports `1883` and `8883`

## Usage

1. Change the name of `example.env` to `.env` and update the values as necessary.

2. Run the thing:

```shell
git clone https://github.com/thegreatsunra/homebridge-mosquitto-docker.git
cd homebridge-mosquitto-docker
docker-compose -p homebridge up -d
```

## License

MIT
