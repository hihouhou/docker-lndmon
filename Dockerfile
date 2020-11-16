#
# Lndmon Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

MAINTAINER hihouhou < hihouhou@hihouhou.com >

ENV GOROOT /usr/local/go
ENV GOPATH /opt/lndmon
ENV PATH $GOPATH/bin:$GOROOT/bin:$PATH
ENV GO_VERSION 1.13.5
ENV LNDMON_VERSION v0.1.0

# Update & install packages
RUN apt-get update && \
    apt-get install -y wget git make build-essential

# Get go
RUN wget https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz && \
    tar -xvf go${GO_VERSION}.linux-amd64.tar.gz && \
    mv go /usr/local

WORKDIR /opt/lndmon

# Get the source & install it
RUN mkdir -p $GOPATH/src/github.com/lightninglabs/lndmon && \
    cd $GOPATH/src/github.com/lightninglabs/lndmon && \
    git clone https://github.com/lightninglabs/lndmon.git && \
    cd lndmon && \
    make && \
    ls

CMD ./src/github.com/lightninglabs/lndmon/lndmon/lndmon $OPTIONS
