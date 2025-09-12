FROM debian:trixie

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      python3 \
      wget \
      ca-certificates \
      kpartx \
      parted \
      fuse3 \
      qemu-utils \
      dosfstools \
      mtools \
      e2fsprogs \
      btrfs-progs \
      sudo \
    rsync \
    apt-cacher-ng \
    grub-efi-amd64-signed \
    shim-signed \
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

RUN mkdir -p /faibuilder
WORKDIR /faibuilder

COPY src/50-add-btrfs /usr/local/etc/50-add-btrfs
COPY src/grub.cfg /usr/local/etc/grub.cfg

COPY src/faibuilder /usr/local/bin/faibuilder
RUN chmod +x /usr/local/bin/faibuilder

ENTRYPOINT ["/usr/local/bin/faibuilder"]
