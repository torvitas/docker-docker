#!/bin/bash

supervisord -c /usr/local/etc/supervisor.conf &

sleep 2s

exec "$@"
