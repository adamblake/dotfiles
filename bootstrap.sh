#!/usr/bin/env bash
# shellcheck disable=1091

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -z "$COMPUTER_NAME" ]; then
    current_computer_name=$(scutil --get ComputerName 2>/dev/null || hostname)
    read -rp "Computer name [$current_computer_name]: " COMPUTER_NAME
    COMPUTER_NAME=${COMPUTER_NAME:-$current_computer_name}
fi

# Utility functions
# -----------------------------------------------------------------------------

function remark {
    echo -e "\n\033[1;33m$1\033[0m"
}

function describe {
    echo -e "\n\033[1;34m$1\033[0m"
}

# Main script
# -----------------------------------------------------------------------------

# keep a reference to this script's directory
export DOTFILES_DIR="$current_dir"

# choose the base install script based on the OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    describe "Detected macOS: using macOS install script"
    source "$DOTFILES_DIR/macOS/install-base.sh"
else
    describe "Currently unsupported OS: $OSTYPE"
    exit 1
fi

remark "Configuring git"
ln -sfv "$DOTFILES_DIR/git/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/git/.gitignore" ~
ln -sfv "$DOTFILES_DIR/git/.gitattributes" ~

remark "Installing Rust"
rustup-init --no-modify-path -y

remark "Installing R and R packages"
rig add release
Rscript --no-init-file "$DOTFILES_DIR/R/r-packages.r"
ln -sfv "$DOTFILES_DIR/R/.Rprofile" ~

remark "Installing Python-based tools"
uv tool install pre-commit

remark "Updating Node.js tools"
npm install -g npm@latest

remark "Installing GCLoud Kubernetes Authenticator"
gcloud components install gke-gcloud-auth-plugin --quiet
