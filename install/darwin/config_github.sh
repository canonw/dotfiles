#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

readonly PACKAGES=(
    gh
)

readonly GITHUB_SSH_KEYFILE_NAME="id_github"

function install_github() {
    for package in "${PACKAGES[@]}"; do
        if brew list --versions "${package}" >/dev/null; then
            echo "Package ${package} is installed"
        else
            echo "Installing ${package}..."
            brew install "$package"
            echo "Installed ${package}..."
        fi
    done
}

function uninstall_github() {
    n=${#PACKAGES[@]}

    # Loop from the last index to the first index
    for (( i = n - 1; i >= 0; i-- )); do
        package="${PACKAGES[$i]}"
        if brew list --versions "${package}" >/dev/null; then
            echo "Uninstalling ${package}..."
            brew uninstall "$package"
            echo "Uninstalled ${package}..."
        else
            echo "Package ${package} is not installed"
        fi
    done
}

function config_github_ssh() {
    keyfile_name="$GITHUB_SSH_KEYFILE_NAME"
    ssh_keyfile="$HOME/.ssh/$keyfile_name"

    if [[ -f "$ssh_keyfile" ]]; then
        echo "$ssh_keyfile exists."
        return 0
    fi

    echo "Creating ssh $ssh_keyfile."

    dir_name=$(dirname "$ssh_keyfile")
    if [ ! -d "$dir_name" ]; then
        echo "Creating $dir_name"
        mkdir -p "$dir_name"
        chmod 700 "$dir_name"
        echo "Created $dir_name"
    fi

    ssh-keygen -t ed25519 -C "$keyfile_name" -f "$ssh_keyfile" -q

    cat <<EOF >>~/.ssh/config
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile $ssh_keyfile

EOF

    eval "$(ssh-agent -s)"

    # TODO: Add conditionally
    # Use this with passphrase
    ssh-add --apple-use-keychain "$ssh_keyfile"
    # Use this with empty passphrase
    # ssh-add "$ssh_keyfile"

    chmod 600 "$ssh_keyfile"

    echo 'TODO: 1. upload public key to https://github.com/settings/keys as "Authentication Keys"'
    echo 'TODO: 2. Confirm config setup "ssh -T github.com" && "ssh -T git@github.com"'
    echo 'TODO: 2. Confirm config setup "ssh-keyscan github.com >> ~/.ssh/known_hosts"'
}

function main() {
    install_github

    config_github_ssh

    # TODO: config gpg key
}

if [ ${#BASH_SOURCE[@]} = 1 ]; then
    main
fi
