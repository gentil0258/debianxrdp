FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    curl \
    wget \
    nano \
    net-tools \
    htop \
    git \
    python3 \
    python3-pip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN echo "root:root" | chpasswd

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN mkdir -p /run/sshd

RUN echo '#!/bin/bash\n/usr/sbin/sshd -D' > /start.sh && chmod +x /start.sh

EXPOSE 22

CMD ["/start.sh"]
