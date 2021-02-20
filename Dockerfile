FROM ghcr.io/linuxserver/baseimage-ubuntu:focal

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="ssawka"

# environment variables
ARG DEBIAN_FRONTEND="noninteractive"

# install software
RUN echo "**** update OS ****" && \
    apt-get update && \
    apt-get upgrade -y

RUN echo "**** Install support packages ****" && \
    apt-get install -y wget build-essential python3-dev python3-pip

RUN echo "**** Add the archive’s GPG key ****" && \
    wget -q -O - https://apt.mopidy.com/mopidy.gpg | apt-key add - && \
    echo "**** Add the APT repo to your package sources ****" && \
    wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/buster.list

RUN echo "**** Install Mopidy and all dependencies ****" && \
    apt-get -y update && \
    python3 -m pip install --upgrade pip && \
    apt-get install -y mopidy

Run echo "**** Create alternative directories ****" && \
    mkdir -p /cache && \
    mkdir -p /config && \
    mkdir -p /data && \
    mkdir -p /music

# add local files
COPY root/ /

# ports and volumes
EXPOSE 6680
VOLUME /config /data /music
