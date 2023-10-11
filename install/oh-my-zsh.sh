# shellcheck shell=bash

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    /bin/bash -c -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
echo "Oh My Zsh! installed"

if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
fi
echo "Powerlevel10k installed"

if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/helm-autocomplete" ]; then
    mkdir -p ~/.oh-my-zsh/custom/plugins/helm-autocomplete/
    helm completion zsh > ~/.oh-my-zsh/custom/plugins/helm-autocomplete/helm-autocomplete.plugin.zsh
fi
echo "helm-autocomplete installed"

if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
fi
echo "zsh-autosuggestions installed"

if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
fi
echo "zsh-syntax-highlighting installed"
