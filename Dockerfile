# This Dockerfile
# Author: shazi7804

# pull base image
FROM ubuntu:16.04

MAINTAINER shazi7804@gmail.com

ENV DOMAIN wordpress.example.com

# Install
# Base
RUN apt-get update && apt-get install -y openssh-server curl lsb_release

# Nginx, PHP7
RUN apt-get install -y nginx php7.0 php7.0-fpm php7.0-mysql php7.0-gd

# Percona 
RUN wget https://repo.percona.com/apt/percona-release_0.1-4.$(lsb_release -sc)_all.deb
RUN dpkg -i percona-release_0.1-4.$(lsb_release -sc)_all.deb
RUN apt-get update && apt-get install -y percona-server-server-5.5

# Generate setting
COPY bash/init.sh /init.sh
RUN chmod 755 /init.sh
CMD ["/bin/bash", "/init.sh", "$DOMAIN"]

# dehydrated renew ssl