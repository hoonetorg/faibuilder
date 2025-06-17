FROM debian:trixie

ENV DEBIAN_FRONTEND=noninteractive

# Install basic build tooling + HTTPS support
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      wget \
      ca-certificates \
      dosfstools \
      mtools \
      btrfs-progs \
 && rm -rf /var/lib/apt/lists/*
#      wget \
#      gnupg \
#      apt-transport-https \
#      ca-certificates \
#      pbuilder \
#      debootstrap \
#      devscripts \
#      fakeroot \
#      build-essential \
#      sudo \
#      grub-efi-amd64-bin \
# && rm -rf /var/lib/apt/lists/*

# Add FAI project GPG key
RUN wget -O /usr/share/keyrings/fai-project-archive-keyring.gpg \
      https://fai-project.org/download/fai-project.gpg

# Add the FAI “koeln” repository for Debian Trixie
RUN echo \
    "deb [signed-by=/usr/share/keyrings/fai-project-archive-keyring.gpg] \
     https://fai-project.org/download trixie koeln" \
    > /etc/apt/sources.list.d/fai-project.list

# Install the FAI packages
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      fai-server \
      fai-client \
      fai-doc \
      fai-setup-storage \
      fai-quickstart \
 && rm -rf /var/lib/apt/lists/*

# Copy your faibuilder script + config
COPY faibuilder /usr/local/bin/faibuilder
RUN chmod +x /usr/local/bin/faibuilder

ENTRYPOINT ["/usr/local/bin/faibuilder"]

