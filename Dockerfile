FROM docker:latest

ENV DOCKER_COMPOSE_VERSION 1.7.1
RUN apk --update add py-pip py-yaml &&\
    pip install -U docker-compose==${DOCKER_COMPOSE_VERSION} &&\
    rm -rf `find / -regex '.*\.py[co]' -or -name apk`
