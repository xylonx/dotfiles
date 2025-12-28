# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"

function install_omz_plugins() {
    local resource_name="$1"
    local resource_url="$2"
    local oh_my_zsh_resource_dir=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/$resource_name

    # Check if the plugin already exists
    if [ ! -d "$oh_my_zsh_resource_dir" ]; then
        echo "Installing plugin $resource_name to path: $oh_my_zsh_resource_dir"
        git clone --quiet --depth 1 "$resource_url" "$oh_my_zsh_resource_dir"
    fi
}
function install_omz_github_plugins() {
    install_omz_plugins $1 "https://github.com/$2.git"
}

install_omz_github_plugins zsh-syntax-highlighting zsh-users/zsh-syntax-highlighting
install_omz_github_plugins zsh-autosuggestions zsh-users/zsh-autosuggestions

plugins=(
    zsh-autosuggestions
    zsh-syntax-highlighting
    git
    bundler
    dotenv
    macos
    docker
    brew
    # rake
    # rbenv
    # ruby
    # yarn
)

source $ZSH/oh-my-zsh.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# Manually set language environment
export LC_ALL=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='nvim'
else
    export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias ks="kitten ssh"
alias proxy_on="export ALL_PROXY=http://127.0.0.1:7890 HTTP_PROXY=http://127.0.0.1:7890 HTTPS_PROXY=http://127.0.0.1:7890"
alias proxy_off="unset ALL_PROXY HTTP_PROXY HTTPS_PROXY"
alias vimdiff="nvim -d"

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
# ask homebrew not to request github access keychains
export HOMEBREW_NO_GITHUB_API=1

# Cargo
if [ -f "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
fi

# Local
export PATH="$PATH:$HOME/.local/bin"


# uv
if [ -x "$(command -v uv)" ]; then
    eval "$(uv generate-shell-completion zsh)"
    export PATH="$HOME/.local/share/uv/tools/:$PATH"
fi

# MISE
if [ -x "$(command -v mise)" ]; then
    eval "$(mise activate zsh)"
fi

