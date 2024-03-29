export EDITOR="nvim"

export CHROME_EXECUTABLE="chromium"

# go
export GOPATH="$(go env GOPATH)"
export PATH="$GOPATH/bin:$PATH"
export GOPATH="$GOPATH:$HOME/code/projects/go"

# fnm
export PATH="/home/xenitane/.local/share/fnm:$PATH"
eval $(fnm env)

eval $(thefuck -a wtf)
. "$HOME/.cargo/env"
