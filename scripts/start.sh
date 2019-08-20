#!/bin/bash

REPOPATH="/root/AirHealthMeter"
SCRIPTSPATH="$REPOPATH/scripts"

## Detect I2c
i2cdetect -y 1

## Install prereq
if [ -e $SCRIPTSPATH/prepare.sh ]; then
    /bin/bash $SCRIPTSPATH/prepare.sh
fi


## Start measuring
if [ -e $SCRIPTSPATH/measure.py ]; then
    python $SCRIPTSPATH/measure.py
fi