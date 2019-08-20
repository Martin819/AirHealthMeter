#!/bin/bash

FILEFORBINARY=$1
BINARYOUTPUT=$2
SERIALNR=$3
HEXDIR=$BINARYOUTPUT

## Make binary
make -f $FILEFORBINARY clean
make -f $FILEFORBINARY COMMISSIONER=1 JOINER=1

## Conver to hex
arm-none-eabi-objcopy -O ihex $BINARYOUTPUT/ot-cli-ftd $HEXDIR/ot-cli-ftd.hex

## Flash hex file on the board
nrfjprog -f nrf52 -s $SERIALNR --chiperase --program $HEXDIR/ot-cli-ftd.hex --reset
