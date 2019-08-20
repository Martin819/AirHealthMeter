#!/bin/bash

## Install OpenThread
cd ~
git clone --recursive https://github.com/openthread/openthread.git
cd openthread
/bin/bash ./script/bootstrap
/bin/bash ./bootstrap