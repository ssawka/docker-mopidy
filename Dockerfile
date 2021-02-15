FROM ghcr.io/linuxserver/baseimage-ubuntu:bionic

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="ssawka"

# environment variables
ARG DEBIAN_FRONTEND="noninteractive"
ARG MOPIDY_EXTENSIONS=""

# ENV PYTHON_EGG_CACHE="/config/plugins/.python-eggs"

# install software
RUN \
 echo "**** update OS ****" && \
 apt-get update && \
 apt-get upgrade -y \
 echo "**** install python3 ****" && \
 apt-get update && \
 apt-get install -y \
 	build-essential \
	python3-dev \
	python3-pip && \
 echo "**** install GStreamer ****" && \
 apt-get install -y \
	python3-gst-1.0 \
    gir1.2-gstreamer-1.0 \
    gir1.2-gst-plugins-base-1.0 \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-tools && \
 echo "**** install Mopidy ****" && \
 python3 -m pip install --upgrade mopidy && \
 echo "**** install Mopidy ****" && \
 for ext in $MOPIDY_EXTENSIONS ; do \
 	python3 -m pip install $ext ; \
 done
#echo "**** cleanup ****" && \
#rm -rf \cd
#	/tmp/* \
#	/var/lib/apt/lists/* \
#	/var/tmp/*

# add local files
# COPY root/ /

# ports and volumes
# EXPOSE 8112 58846 58946 58946/udp
# VOLUME /config /downloads
