FROM resin/rpi-raspbian:stretch

RUN  apt-get update -q \
  && apt-get install -y --no-install-recommends \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /root/.cache /home/*/.cache

RUN apt-get update -y \
  && apt-get install -y \
     apt-utils \
     apt-transport-https \
     man \
     curl \
     rsync \
     sudo \
     vim-tiny \
     nano \
     wget \
     ca-certificates \
     netcat \
     tzdata \
     gnupg2 \
     zlib1g-dev \
     iputils-ping \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /root/.cache /home/*/.cache \

