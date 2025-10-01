#!/bin/bash

mkdir -p /tmp/nealhost
cd /tmp/nealhost || exit
git clone https://github.com/Nvveen/nealhost && cd nealhost || exit
bash install.sh