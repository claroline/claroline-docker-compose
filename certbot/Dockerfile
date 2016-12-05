FROM ubuntu:16.10

MAINTAINER Donovan Tengblad <donovan.tengblad@claroline.com>

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    python-certbot-apache

COPY obtain.sh:/
COPY renew.sh:/

CMD ["tail", "-f", "dev/null"]
