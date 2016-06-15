FROM docker:dind
MAINTAINER docker@saschaschmidt.net

# Install Docker and dependencies
RUN apk --update add \
  bash \
  make \
  py-pip \
  git \
  openssh-client \
  && pip install --upgrade docker-compose pip \
  && rm -rf /var/cache/apk/* \
  && rm -rf /root/.cache/pip/*

COPY dockerd-entrypoint.sh /usr/local/bin/

VOLUME /var/lib/docker
ENTRYPOINT ["dockerd-entrypoint.sh"]
CMD ['sh']
