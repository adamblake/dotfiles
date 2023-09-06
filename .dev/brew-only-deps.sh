#!/bin/bash

# Be careful, this will overwrite the Brewfile in the current directory
brew bundle dump --force
cat Brewfile | egrep "$(brew leaves | xargs printf '"%s"|')tap|cask|vscode" > Brewfile
