if command -v batcat >/dev/null 2>&1; then
    alias bat="batcat"
fi

if command -v fd-find >/dev/null 2>&1; then
    alias fd="fdfind"
fi

export EDITOR="nvim"

if ! command -v go >/dev/null 2>&1; then
    export PATH="/usr/local/go/bin:$PATH"
fi
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

export PATH="$HOME/.local/share/fnm:$PATH"
eval "$(fnm env)"

eval "$(thefuck -a wtf)"

source "$HOME/.cargo/env"

alias ls="exa"
alias tree="exa --tree"

alias cat="bat"

eval "$(atuin init zsh)"

export PATH="$HOME/.scripts:$PATH"

export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
esac

alias fman="compgen -c | fzf | xargs man"

utils=(
    nvim
    tmux
    fnm
    pnpm
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


