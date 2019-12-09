FROM debian:latest

MAINTAINER Paul Spooren <mail@aparcar.org>


RUN set -ex \
&& cat > /etc/apt/sources.list < -EOF \
# deb http://snapshot.debian.org/archive/debian/20191118T000000Z buster main
deb http://deb.debian.org/debian buster main
# deb http://snapshot.debian.org/archive/debian-security/20191118T000000Z buster/updates main
deb http://mirrors.163.com/debian-security buster/updates main
# deb http://snapshot.debian.org/archive/debian/20191118T000000Z buster-updates main
deb http://deb.debian.org/debian buster-updates main \
EOF 

RUN apt-get update -qq &&\
    apt-get install -y \
        build-essential \
        curl \
        file \
        gawk \
        gettext \
        git \
        libncurses5-dev \
        libssl-dev \
        python2.7 \
        python3 \
        rsync \
        subversion \
        sudo \
        swig \
        unzip \
        wget \
        zlib1g-dev \
        && apt-get -y autoremove \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN useradd -c "OpenWrt Builder" -m -d /home/build -G sudo -s /bin/bash build
COPY --chown=build:build . /home/build/openwrt/
RUN chown build:build /home/build/openwrt/

USER build
ENV HOME /home/build
WORKDIR /home/build/openwrt/
