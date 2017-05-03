#!/bin/bash

if [ -z "$1" ]; then
  echo Command required.
  exit 1
fi

supervisord -c /usr/local/etc/supervisor.conf &
SUPERVISOR_PID=$!

PROCESS_PID=

on_exit() {
  exit_code=$1
  if [ -n "${PROCESS_PID}" ]; then
    kill -TERM ${PROCESS_PID}
    wait ${PROCESS_PID}
    PROCESS_PID=
  fi
  if [ -n "${SUPERVISOR_PID}" ]; then
    kill -TERM ${SUPERVISOR_PID}
    wait ${SUPERVISOR_PID}
    SUPERVISOR_PID=
  fi
  exit $exit_code
}
trap 'on_exit 0' EXIT
trap 'on_exit 1' TERM INT

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

"$@" &
PROCESS_PID=$!
wait $PROCESS_PID
exit_code=$?
PROCESS_PID=
on_exit $exit_code
