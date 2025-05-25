# Dockerfile
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive \
    CL="DEBIAN,DHCPC,DEMO,FAIBASE,UBUNTU,ONE,SSH_SERVER,STANDARD,XORG,FAIME,GRUB_PC,GRUB_EFI,AMD64" \
    MIRROR_DIR=/tmp/mirror \
    OUTPUT_DIR=/output

# 1. Install FAI + build tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    fai-server            \
    fai-client            \
    fai-cd                \
    fai-mirror            \
    grub-pc               \
    grub-efi-amd64        \
    xorriso               \
    syslinux               \
    isolinux              \
    squashfs-tools        \
    && rm -rf /var/lib/apt/lists/*

# 2. Copy entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

