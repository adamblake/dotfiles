export EDITOR="code --wait"
export VISUAL=code

# Language settings
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

# make git use pin-entry for gpg2
export GPG_TTY=$(tty)

# gcloud
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# Go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"
. "$HOME/.cargo/env"

# uv tools
export PATH="$HOME/.local/bin:$PATH"
