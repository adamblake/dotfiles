# shellcheck shell=bash

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    /bin/bash -c -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh! already installed"
fi
