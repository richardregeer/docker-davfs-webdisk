FROM ubuntu:16.04

LABEL maintainer "Richard Regeer" \
      email="rich2309@gmail.com"

RUN apt-get update \
  && apt-get install -y davfs2 ca-certificates unison \
  && apt-get clean \
  && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

RUN echo {TODO} >> /etc/davfs2/secrets