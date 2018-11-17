FROM resin/rpi-raspbian:stretch

RUN  apt-get update -q \
  && apt-get install -y --no-install-recommends \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /root/.cache /home/*/.cache \
  && apt-get upgrade -q \
  && apt-get install -y \
     curl \
     rsync \
     sudo \
     vim-tiny \
     nano \
     wget \
     apt-transport-https \
     ca-certificates \
     netcat \
     tzdata \
     gnupg2 \
     zlib1g-dev \
     iputils-ping \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /root/.cache /home/*/.cache \

