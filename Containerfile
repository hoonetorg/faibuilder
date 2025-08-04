FROM debian:trixie

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      wget \
      ca-certificates \
      dosfstools \
      mtools \
      btrfs-progs \
 && rm -rf /var/lib/apt/lists/*

RUN wget -O /usr/share/keyrings/fai-project-archive-keyring.gpg \
      https://fai-project.org/download/fai-project.gpg

RUN echo \
    "deb [signed-by=/usr/share/keyrings/fai-project-archive-keyring.gpg] \
     https://fai-project.org/download trixie koeln" \
    > /etc/apt/sources.list.d/fai-project.list

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      fai-server \
      fai-client \
      fai-doc \
      fai-setup-storage \
      fai-quickstart \
 && rm -rf /var/lib/apt/lists/*

COPY src/faibuilder /usr/local/bin/faibuilder
RUN chmod +x /usr/local/bin/faibuilder
COPY src/50-add-btrfs /usr/local/etc/50-add-btrfs


RUN mkdir -p /faibuilder
WORKDIR /faibuilder

ENTRYPOINT ["/usr/local/bin/faibuilder"]

