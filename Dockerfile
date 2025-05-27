# Dockerfile
FROM ubuntu:24.04

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository universe && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
       fai-server       \
       fai-client       \
       reprepro         \
       dosfstools       \
       xorriso          \
       syslinux         \
       isolinux         \
       squashfs-tools   \
       parted           \
       grub2-common     \
       grub-pc-bin      \
       grub-efi-amd64-bin \
    && rm -rf /var/lib/apt/lists/*

COPY faibuilder /usr/local/bin/faibuilder
COPY faibuilder.conf /usr/local/etc/faibuilder.conf
RUN chmod +x /usr/local/bin/faibuilder

ENTRYPOINT ["/usr/local/bin/faibuilder"]

