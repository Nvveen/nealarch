#!/bin/bash

cd $HOME || exit;
sudo pacman -Sy git --noconfirm || exit
git clone https://github.com/Nvveen/nealarch
cd nealarch || exit
bash install.sh
cd $HOME || exit;
rm -rf nealarch
