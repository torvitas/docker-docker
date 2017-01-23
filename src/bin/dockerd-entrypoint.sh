#!/bin/bash

supervisord -c /usr/local/etc/supervisor.conf &

is_docker_up() {
  curl --unix-socket /var/run/docker.sock -o /dev/null --silent --fail http://docker/_ping
}

echo 'Waiting for Docker to start up...'
attempt=0
until is_docker_up || [ $attempt -eq 30 ]; do
  sleep 1
  ((attempt++))
done

if ! is_docker_up; then
  echo 'ERROR: Docker failed to start up.' > /dev/stderr
  cat /var/log/docker/*.log > /dev/stderr
  exit 1
fi

exec "$@"
