export EDITOR="nvim"

export CHROME_EXECUTABLE="chromium"

# fnm
export PATH="/home/xenitane/.local/share/fnm:$PATH"
eval $(fnm env)

eval $(thefuck -a wtf)
. "$HOME/.cargo/env"
