FROM debian:stretch

MAINTAINER Adam Cecile <acecile@le-vert.net>

ENV TERM xterm
ENV HOSTNAME cpuminer.local

WORKDIR /root

# Upgrade base system
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y -o 'Dpkg::Options::=--force-confdef' -o 'Dpkg::Options::=--force-confold' dist-upgrade \
    && rm -rf /var/lib/apt/lists/*

# Install build dependencies
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y -o 'Dpkg::Options::=--force-confdef' -o 'Dpkg::Options::=--force-confold' --no-install-recommends install \
    libssl-dev libcurl4-openssl-dev libgmp-dev zlib1g-dev git build-essential automake ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Clone current code
RUN git clone https://github.com/JayDDee/cpuminer-opt.git /root/src/

# At runtime, update GIT and build with -march=native to get maximum optimization everytime
RUN echo '#!/bin/sh\n\n\
cd /root/src && git pull && ./build.sh && ./cpuminer $@\n' > /root/start.sh && chmod 0755 /root/start.sh
