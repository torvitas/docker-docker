FROM docker:1.13-dind
MAINTAINER docker@saschaschmidt.net

# Install Docker and dependencies
RUN apk add -U \
    curl \
    bash \
    openssh-client \
    make \
    git \
    supervisor

VOLUME /var/lib/docker
ENTRYPOINT ["dockerd-entrypoint.sh"]
CMD "bash"
RUN mkdir -p /var/log/docker

COPY src/ /usr/local/
