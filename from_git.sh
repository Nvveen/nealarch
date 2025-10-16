#!/bin/bash

cd $HOME || exit;
sudo pacman -Sy git --noconfirm || exit
mkdir -p $HOME/.local/share
git clone https://github.com/Nvveen/nealarch
cd nealarch || exit
bash install.sh
