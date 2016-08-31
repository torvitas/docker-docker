#!/bin/bash

docker daemon \
    --host=unix:///var/run/docker.sock \
    --storage-driver=aufs &

sleep 2s

exec "$@"
