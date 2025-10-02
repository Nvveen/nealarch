#!/bin/bash

mkdir -p /tmp/nealhost
cd /tmp/nealhost || exit
sudo pacman -Sy git --noconfirm || exit
git clone https://github.com/Nvveen/nealarch && cd nealarch || exit
bash install.sh
rm -rf /tmp/nealhost
