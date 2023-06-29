#!/usr/bin/env bash

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

remark "Symlinking dotfiles..."
ln -sfv "$DOTFILES_DIR/git/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/git/.gitignore" ~
ln -sfv "$DOTFILES_DIR/git/.gitattributes" ~
