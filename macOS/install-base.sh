#!/bin/bash

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


# Utility functions
# -----------------------------------------------------------------------------

function remark {
    echo -e "\n\033[1;33m$1\033[0m"
}

function describe {
    echo -e "\n\033[1;34m$1\033[0m"
}

function xcode_cli_is_configured {
    brew config | grep '^CLT' | grep -v 'N/A' >/dev/null
}

# Main script
# -----------------------------------------------------------------------------

# homebrew installs to /opt/homebrew on Apple Silicon Macs and to /usr/local on Intel Macs
if [[ "$(uname -m)" == "arm64" ]]; then
    brew_prefix="/opt/homebrew"
else
    brew_prefix="/usr/local"
fi

brew_bin="${brew_prefix}/bin/brew"

# install Homebrew if not already installed
if [ ! -x "${brew_bin}" ]; then
    remark "Installing Homebrew"
    NONINTERACTIVE=1 /bin/bash -c "$(sudo curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # ensure the brew binary gets added to the PATH when the shell starts
    touch ~/.zprofile
    shellenv_cmd="eval \"\$(${brew_bin} shellenv)\""
    if ! grep -Fxq "$shellenv_cmd" ~/.zprofile; then
        echo >> ~/.zprofile
        echo "$shellenv_cmd" >> ~/.zprofile
    fi
fi

# ensure the brew binary is in the PATH
eval "$(${brew_bin} shellenv)"

describe "Disabling Homebrew analytics"
brew analytics off

# check for XCode Command Line Tools
if ! xcode_cli_is_configured; then
    remark "Xcode Command Line Tools are not configured. Please run 'xcode-select --install' and follow the instructions."
    exit 1
fi

remark "Installing and updating Homebrew packages"
describe "This will require your password multiple times"
brew update
brew bundle --file "$current_dir/Brewfile"
brew upgrade
brew cleanup

if ! command -v ruby &> /dev/null || [[ "$(ruby -v)" != *"3.4.1"* ]]; then
    remark "Installing Ruby"
    ruby-install ruby 3.4.1
fi

if [ ! -d "$HOME/.scm_breeze" ]; then
    remark "Installing SCM Breeze"
    git clone https://github.com/scmbreeze/scm_breeze.git "$HOME/.scm_breeze"
    ~/.scm_breeze/install.sh
fi

remark "Configuring R Makevars"
mkdir -p ~/.R
ln -sfv "$current_dir/R.Makevars" ~/.R/Makevars

describe "Configuring VSCode file associations"
# associate all source code extensions known to Github’s linguist library with VSCode
curl "https://raw.githubusercontent.com/github/linguist/master/lib/linguist/languages.yml" \
  | yq -r "to_entries | (map(.value.extensions) | flatten) - [null] | unique | .[]" \
  | xargs -L 1 -I "{}" duti -s com.microsoft.VSCode {} all

remark "Configuring MacOS"
source "$current_dir/set-system-defaults.sh"

describe "Configuring Dock"
source "$current_dir/set-dock-apps.sh"

remark "Configuring zsh"
ln -sfv "$current_dir/.zshrc" ~
ln -sfv "$current_dir/.zshenv" ~