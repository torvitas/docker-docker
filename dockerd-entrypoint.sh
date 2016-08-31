#!/bin/bash

docker daemon \
    --host=unix:///var/run/docker.sock \
    --storage-driver=aufs &>/dockerd.log &

sleep 2s

tail -fn0 /dockerd.log

exec "$@"
