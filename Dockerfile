FROM ubuntu:16.04

LABEL maintainer "Richard Regeer" \
      email="rich2309@gmail.com"

RUN apt-get update \
  && apt-get install -y davfs2 ca-certificates unison \
  && mkdir -p /mnt/source \
  && mkdir -p /mnt/webdrive \
  && apt-get clean \
  && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

COPY ./default.prf /root/.unison/default.prf
COPY ./start-sync.sh /usr/local/bin

ENTRYPOINT [ "/usr/local/bin/start-sync.sh" ]