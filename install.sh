#!/bin/bash

# absolute path to this script
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
FILES_DIR="$SCRIPT_DIR/files"
PACKAGES=$(cat "$SCRIPT_DIR/packages" | tr '\n' ' ')

log() {
    echo -e "\e[32m[INFO]\e[0m $1"
}

setup_packages() {
    log "Setting up packages..."
    sudo pacman -Syu --noconfirm $PACKAGES

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

setup_config() {
    log "Setting up configuration..."
    # Add any additional configuration steps here
    cd $SCRIPT_DIR || exit
    cp -r $FILES_DIR/user/. $HOME/
    stow --adopt --target=$HOME --dir=$FILES_DIR user
}

main() {
    setup_packages
    setup_paru
    setup_config
    log "Setup complete!"
}

main "$@"