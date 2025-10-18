#!/bin/bash

# absolute path to this script
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
FILES_DIR="$SCRIPT_DIR/files"
CUSTOM_DIR="$FILES_DIR/custom"
DEFAULT_DIR="$FILES_DIR/default"
source "$SCRIPT_DIR/packages"

log() {
    echo -e "\e[32m[INFO]\e[0m $1"
}

setup_packages() {
    log "Setting up packages..."
    sudo pacman -Syu --needed --noconfirm "${PACKAGES[@]}"

    sudo systemctl enable sddm
    sudo systemctl enable sshd
}

setup_paru() {
    if ! command -v paru &> /dev/null; then
        echo "Installing paru..."
        cd /tmp || exit
        git clone https://aur.archlinux.org/paru-bin.git
        cd paru-bin || exit
        makepkg -si --noconfirm
        cd .. || exit
        rm -rf paru-bin
        cd $SCRIPT_DIR || exit
    else
        echo "paru is already installed."
    fi
}

setup_aur_packages() {
    paru -Syu --needed --noconfirm "${AUR_PACKAGES[@]}"
}

setup_config() {
    log "Setting up configuration..."
    mkdir -p ~/.ssh/
    cd $SCRIPT_DIR || exit
    cp -rv $DEFAULT_DIR/user/. $HOME/
    stow --adopt --target=$HOME --dir=$DEFAULT_DIR user

    # copy files that can change per system
    # these will not be linked to
    cp -rv $CUSTOM_DIR/user/. $HOME/
}

system_afterinstall() {
    log "Running system after-install tasks..."
    sudo mkdir -p /etc/sddm.conf.d
    echo -e "[General]\nSession=hyprland-uwsm" | sudo tee /etc/sddm.conf.d/hyprland.conf >/dev/null
}

main() {
    setup_packages
    setup_paru
    setup_aur_packages
    setup_config
    system_afterinstall
    log "Setup complete!"
}

main "$@"
