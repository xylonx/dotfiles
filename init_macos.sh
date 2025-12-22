#/usr/bin/env bash

function homebrew_install_tools() {
    for tool in "$@"; do
        if [ ! -x "$(command -v $tool)" ]; then
            brew install $tool
        else
            echo "$tool already exists"
        fi
    done
}

function homebrew_install_formulas() {
    for package in "$@"; do
        if ! brew list --formula $package &>/dev/null; then
            brew install $package
        else
            echo "$package already exists"
        fi
    done
}

function homebew_install_casks() {
    for cask in "$@"; do
        if ! brew list --cask $cask &>/dev/null; then
            brew install --cask $cask
        else
            echo "$cask already exists"
        fi
    done
}

# Install homebrew
if [ ! -f "$(command -v brew)" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "homebrew already exists"
fi

# Install basic tools
homebrew_install_tools git curl wget vim stow uv

# Install tools for nvim plugins toolit
homebrew_install_formulas fzf fd ripgrep yazi mise neovim

# Install useful cask apps
homebew_install_casks iterm2 kitty betterdisplay clipy jordanbaird-ice

# Install pnpm
if [ ! -x "$(command -v pnpm)" ]; then
    curl -fsSL https://get.pnpm.io/install.sh | sh -
else
    echo "pnpm already exists"
fi
# Install Powerline Fonts
# git clone https://github.com/powerline/fonts.git


# Install oh-my-zsh
if [[ "$ZSH" != *"oh-my-zsh" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "oh-my-zsh already exists"
fi


# Install git commitizen
if [ ! -x "$(command -v cz)" ]; then
    uv tool install commitizen
fi

