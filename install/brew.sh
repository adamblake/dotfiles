# shellcheck shell=bash
# shellcheck disable=1091

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
source "$DOTFILES_DIR/install/brew-packages.sh"
