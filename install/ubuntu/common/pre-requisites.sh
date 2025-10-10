#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

readonly PACKAGES=(
    apt-transport-https
    ca-certificates
    curl
    gnupg
    lsb-release
    software-properties-common
    unzip
    wget
)

function install_apt_packages() {
    sudo apt-get install -y "${PACKAGES[@]}"
}

function uninstall_apt_packages() {
    sudo apt-get remove -y "${PACKAGES[@]}"
}

function main() {
    sudo apt-get update -y
    sudo apt-get upgrade -y
    install_apt_packages
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi
