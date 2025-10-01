#!/bin/bash

PACKAGES=$(cat "$(dirname "$0")/packages" | tr '\n' ' ')

log() {
    echo -e "\e[32m[INFO]\e[0m $1"
}

setup_packages() {
    log "Setting up packages..."
    sudo pacman -Syu --noconfirm $PACKAGES
}

install_defaults () {
    log "Installing default configuration files..."
    mkdir -p ~/.local/share/nealhost/default
    cp -r "$(dirname "$0")/files/default/"* ~/.local/share/nealhost/default/
}

install_configs() {
    log "Installing configuration files..."
    mkdir -p ~/.config
    cp -r "$(dirname "$0")/files/config/"* ~/.config/
}

setup_paru() {
    if ! command -v paru &> /dev/null; then
        echo "Installing paru..."
        cd /tmp || exit
        git clone https://aur.archlinux.org/paru.git
        cd paru || exit
        makepkg -si --noconfirm
        cd .. || exit
        rm -rf paru
    else
        echo "paru is already installed."
    fi
}

main() {
    setup_packages
    setup_paru
    install_defaults
}

main "$@"