# shellcheck shell=bash

brew update
brew bundle --file "$DOTFILES_DIR/install/Brewfile"

# temporary fix for dockutil v3
if [ ! "$(command -v dockutil)" ]; then
    brew tap lotyp/homebrew-formulae
    brew install lotyp/formulae/dockutil
fi

brew upgrade
brew cleanup