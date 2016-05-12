FROM docker:dind
RUN sed -i "s/storage-driver=vfs/storage-driver=aufs/g" /usr/local/bin/dockerd-entrypoint.sh
