FROM ubuntu:noble as builder

ENV DEBIAN_FRONTEND=noninteractive
ARG SRC_PREFIX=fai_6.2.4

RUN apt-get update && apt-get install -y \
    pbuilder \
    debootstrap \
    devscripts \
    fakeroot \
    build-essential \
    sudo \
    ca-certificates

WORKDIR /build
COPY ${SRC_PREFIX}.dsc ${SRC_PREFIX}.tar.xz ./

RUN pbuilder create --distribution noble --debootstrapopts --variant=buildd

RUN mkdir /build/output && \
    pbuilder build ${SRC_PREFIX}.dsc --buildresult /build/output

FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN add-apt-repository universe && \
    apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    reprepro \
    dosfstools \
    xorriso \
    syslinux \
    isolinux \
    squashfs-tools \
    parted \
    grub2-common \
    grub-pc-bin \
    grub-efi-amd64-bin && \
    rm -rf /var/lib/apt/lists/*

# Copy only locally built FAI packages
COPY --from=builder /build/output /tmp/fai-debs

# Install FAI from local debs
RUN apt install /tmp/fai-debs/fai-*.deb

COPY faibuilder /usr/local/bin/faibuilder
COPY faibuilder.conf /usr/local/etc/faibuilder.conf
RUN chmod +x /usr/local/bin/faibuilder

ENTRYPOINT ["/usr/local/bin/faibuilder"]
