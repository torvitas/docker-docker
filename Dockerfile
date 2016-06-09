FROM docker:latest

ENV DOCKER_COMPOSE_VERSION 1.7.1
RUN apk --update add git py-pip py-yaml bash make &&\
    pip install -U docker-compose==${DOCKER_COMPOSE_VERSION} &&\
    rm -rf `find / -regex '.*\.py[co]' -or -name apk`

ADD https://github.com/docker/machine/releases/download/v0.7.0/docker-machine-linux-x86_64 /usr/local/bin/docker-machine
RUN chmod +x /usr/local/bin/docker-machine
