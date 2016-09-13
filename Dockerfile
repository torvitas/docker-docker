FROM centos:7
MAINTAINER docker@saschaschmidt.net

# Install Docker and dependencies
RUN yum install epel-release -y && yum install -y \
  curl \
  make \
  iptables \
  python-pip \
  git \
  supervisor \
  sudo \
  docker \
  && yum clean all \
  && pip install --upgrade docker-compose pip \
  && rm -rf /root/.cache/pip/

VOLUME /var/lib/docker
ENTRYPOINT ["dockerd-entrypoint.sh"]
CMD '/bin/bash'
RUN mkdir -p /var/log/docker

COPY src/ /usr/local/
