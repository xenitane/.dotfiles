export EDITOR="nvim"

export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

eval "$(fnm env)"
eval "$(thefuck -a wtf)"
eval "$(atuin init zsh)"

alias ls="exa"
alias tree="exa --tree"
alias cat="bat"
alias fman="compgen -c | fzf | xargs man"
alias vi="nvim"
alias vim="nvim"

export PATH="$HOME/.scripts:$PATH"

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"

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
