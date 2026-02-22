#!/usr/bin/env bash

function install_paru() {
    if [ ! -x "$(command -v paru)" ]; then
        local CUR_DIR="$PWD"
        sudo pacman -S --needed base-devel
        mkdir "/tmp/paru-install"
        git clone https://aur.archlinux.org/paru.git
        cd paru
        makepkg -si
        cd "$CUR_DIR"
    fi
}

function install_tools() {
    for tool in "$@"; do
        if [ ! -x "$(command -v $tool)" ]; then
            sudo paru -Syu $tool
        else
            echo "$tool already exists"
        fi
    done
}

function install_cli_tools() {
    # Install paru
    install_paru
    # Install basic tools
    install_tools git curl wget vim stow uv
    # Install tools for nvim plugins toolit
    install_tools fzf fd ripgrep yazi mise neovim uutils-coreutils
    # Install rust toolchains
    install_tools rustup
}

function install_shell() {
    # Install oh-my-zsh
    if [[ "$ZSH" != *"oh-my-zsh" ]]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else
        echo "oh-my-zsh already exists"
    fi
}

function install_gui_tools() {
    install_tools kitty
    install_tools firefox firefox-i18n-zh-cn
}

while getopts "c:g:" arg; do
  case $arg in
    c)
      echo "Install Cli tools" 
      install_cli_tools
      ;;
    g)
      echo "Install GUI apps"
      install_gui_tools
      ;;
  esac
done

