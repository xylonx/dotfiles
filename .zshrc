# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"

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

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
# ask homebrew not to request github access keychains
export HOMEBREW_NO_GITHUB_API=1

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end## [Completion]

# Cargo
if [ -x "$(command -v cargo)" ]; then
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

