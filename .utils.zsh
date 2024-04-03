if command -v batcat >/dev/null 2>&1; then
    alias bat="batcat"
fi

if command -v fdfind >/dev/null 2>&1; then
    alias fd="fdfind"
fi

export EDITOR="nvim"

export GOPATH="$(go env GOPATH)"
export PATH="$GOPATH/bin:$PATH"
export GOPATH="$GOPATH:$HOME/code/projects/go"

export PATH="$HOME/.local/share/fnm:$PATH"
eval "$(fnm env)"

eval "$(thefuck -a wtf)"

source "$HOME/.cargo/env"

alias ls="exa"
alias tree="exa --tree"

alias cat="bat"

eval "$(atuin init zsh)"

export PATH="$HOME/.scripts:$PATH"

utils=(
    nvim
    tmux
    fnm
    thefuck
    exa
    fzf
    bat
    rg
    zoxide
    fd
    go
    atuin
    btop
    screenkey
    tmux-cht.sh
    tmux-sessionizer
)

for util in $utils; do
    if ! command -v $util >/dev/null 2>&1; then
        echo >&2 "$util not installed"
    fi
done


