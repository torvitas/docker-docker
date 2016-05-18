FROM gitlab/dind
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y make && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
