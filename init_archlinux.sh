#!/usr/bin/env bash

function install_tools() {
    for tool in "$@"; do
        if [ ! -x "$(command -v $tool)" ]; then
            pacman -Syu $tool
        else
            echo "$tool already exists"
        fi
    done
}

# Install basic tools
install_tools git curl wget vim stow uv

# Install tools for nvim plugins toolit
install_tools fzf fd ripgrep yazi mise neovim uutils-coreutils

# Install useful cask apps
install_tools kitty

# Install Powerline Fonts
# git clone https://github.com/powerline/fonts.git


# Install oh-my-zsh
if [[ "$ZSH" != *"oh-my-zsh" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "oh-my-zsh already exists"
fi


# Install git commitizen
# if [ ! -x "$(command -v cz)" ]; then
#     uv tool install commitizen
# else
#     echo "commitizen already exists"
# fi

# Install rust toolchains
if [ ! -x "$(command -v cargo)" ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
else
    echo "rust toolchain already exists"
fi

