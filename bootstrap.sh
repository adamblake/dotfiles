#!/usr/bin/env bash
# shellcheck disable=1091

function remark {
    echo -e "\n\033[1;33m$1\033[0m"
}

function describe {
    echo -e "\n\033[1;34m$1\033[0m"
}

# this script can run from anywhere
export DOTFILES_DIR EXTRA_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

remark "Updating dotfiles..."
[ -d "${DOTFILES_DIR}/.git" ] && git --work-tree="${DOTFILES_DIR}" --git-dir="${DOTFILES_DIR}/.git" pull origin main

remark "Installing Homebrew..."
source "$DOTFILES_DIR/install/brew.sh"

remark "Setting up R for Homebrew..."
mkdir ~/.R
ln -sfv "$DOTFILES_DIR/R/R.Makevars" ~/.R/Makevars

remark "Installing and updating Homebrew packages..."
source "$DOTFILES_DIR/install/brew-packages.sh"

remark "Installing Rust..."
# depends on rustup (brew)
source "$DOTFILES_DIR/install/rust.sh"

remark "Installing global Python packages..."
# depends on pip (brew)
source "$DOTFILES_DIR/install/python.sh"

remark "Installing R packages..."
# depends on R (brew)
Rscript --no-init-file "$DOTFILES_DIR/R/r-packages.r"
ln -sfv "$DOTFILES_DIR/R/.Rprofile" ~

remark "Configuring git..."
ln -sfv "$DOTFILES_DIR/git/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/git/.gitignore" ~
ln -sfv "$DOTFILES_DIR/git/.gitattributes" ~
source "$DOTFILES_DIR/install/scm-breeze.sh"
ln -sfv "$DOTFILES_DIR/scm-breeze/.git.scmbrc" ~
ln -sfv "$DOTFILES_DIR/scm-breeze/.scmbrc" ~

remark "Configuring MacOS..."
source "$DOTFILES_DIR/mac/defaults.sh"
# depends on dockutil (brew)
source "$DOTFILES_DIR/mac/dock.sh"
# depends on duti (brew) and yq (python)
source "$DOTFILES_DIR/mac/file-associations.sh"

# configure oh-my-zsh and zsh last because they depend on other packages
remark "Installing oh-my-zsh..."
source "$DOTFILES_DIR/install/oh-my-zsh.sh"
ln -sfv "$DOTFILES_DIR/zsh/.p10k.zsh" ~

remark "Configuring zsh..."
[ -f "$HOME/.zshrc" ] && mv ~/.zshrc ~/.zshrc.pre-dotfiles
ln -sfv "$DOTFILES_DIR/zsh/.zshrc" ~
ln -sfv "$DOTFILES_DIR/zsh/.zshenv" ~
