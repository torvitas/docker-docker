#!/bin/bash

sh "$(which dind)" docker daemon \
    --host=unix:///var/run/docker.sock \
    --storage-driver=aufs &

exec "$@"
