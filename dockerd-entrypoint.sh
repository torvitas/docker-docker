#!/bin/bash

docker daemon \
    --host=unix:///var/run/docker.sock \
    --storage-driver=devicemapper &

exec "$@"
