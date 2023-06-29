# shellcheck shell=bash

brew update
brew bundle --file "$DOTFILES_DIR/install/Brewfile"
brew upgrade
brew cleanup
