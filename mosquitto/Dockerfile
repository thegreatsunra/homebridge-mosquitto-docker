FROM eclipse-mosquitto:latest

RUN apk update && apk upgrade
RUN apk add openssl
COPY ./mosquitto.conf /mosquitto/config/mosquitto.conf
COPY ./docker-entrypoint.sh /

ENTRYPOINT ["sh", "./docker-entrypoint.sh"]

CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]
