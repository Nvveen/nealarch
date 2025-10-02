#!/bin/bash

mkdir -p /tmp/nealarch
cd /tmp/nealarch || exit
sudo pacman -Sy git --noconfirm || exit
git clone https://github.com/Nvveen/nealarch && cd nealarch || exit
bash install.sh
cd /tmp || exit
rm -rf nealarch
