#!/bin/bash

FILEFORBINARY=$1
BINARYOUTPUT=$2
SERIALNR=$3
DEVICEPORT=$4
IFACENAME=$5
HEXDIR=$BINARYOUTPUT

## Make binary
make -f $FILEFORBINARY clean
make -f $FILEFORBINARY JOINER=1 USB=1

## Conver to hex
arm-none-eabi-objcopy -O ihex $BINARYOUTPUT/ot-ncp-ftd $HEXDIR/ot-ncp-ftd.hex

## Flash hex file on the board
nrfjprog -f nrf52 -s $SERIALNR --chiperase --program $HEXDIR/ot-ncp-ftd.hex --reset

## Configure wpantund
wpantund -o Config:NCP:SocketPath $DEVICEPORT -o Config:TUN:InterfaceName $IFACENAME -o Daemon:SyslogMask " -info"

## Connect to iface
wpanctl -I $IFACENAME
