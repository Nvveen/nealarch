#!/bin/bash

mkdir -p /tmp/nealhost
cd /tmp/nealhost || exit
sudo pacman -Sy git --noconfirm || exit
git clone https://github.com/Nvveen/nealhost && cd nealhost || exit
bash install.sh
cd /tmp || exit
rm -rf nealhost