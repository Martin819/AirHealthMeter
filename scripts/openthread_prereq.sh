#!/bin/bash

apt-get update

## Install JLink
wget -O /tmp/jlink/JLink_Linux_x86_64.deb https://www.segger.com/downloads/jlink/JLink_Linux_x86_64.deb
dpkg -i /tmp/jlink/JLink_Linux_x86_64.deb

## Install nRF CLI Tools
wget -O /tmp/nrfclitools/nRFCommandLineTools1030Linuxamd64tar.gz https://www.nordicsemi.com/-/media/Software-and-other-downloads/Desktop-software/nRF-command-line-tools/sw/Versions-10-x-x/nRFCommandLineTools1030Linuxamd64tar.gz
tar xvzf /tmp/nrfclitools/nRFCommandLineTools1030Linuxamd64tar.gz -C /usr/lib/nrfclitools
export PATH=/usr/lib/nrfclitools:$PATH

## Update packages
apt-get install -y software-properties-common
apt-get install -y gcc gawk g++ libdbus-1-dev libboost-dev libreadline-dev
apt-get install -y gcc-arm-none-eabi
apt-get install -y libtool autoconf autoconf-archive
apt-get install -y lib32z1 lib32ncurses5

## Install ARM Toolchain
wget -O /tmp/armtoolchain/gcc-arm-none-eabi-8-2019-q3-update-linux.tar.bz2 https://developer.arm.com/-/media/Files/downloads/gnu-rm/8-2019q3/RC1.1/gcc-arm-none-eabi-8-2019-q3-update-linux.tar.bz2
tar xjf /tmp/armtoolchain/gcc-arm-none-eabi-8-2019-q3-update-linux.tar.bz2 /opt/gnu-mcu-eclipse/arm-none-eabi-gcc/
export PATH=/opt/gnu-mcu-eclipse/arm-none-eabi-gcc/bin:$PATH

## Install wpantund
cd ~
git clone --recursive https://github.com/openthread/wpantund.git
cd wpantund
/bin/bash ./bootstrap.sh
/bin/bash ./configure --sysconfdir=/etc
make
make install

echo "Done - rebboting the system..."
sleep 5
reboot