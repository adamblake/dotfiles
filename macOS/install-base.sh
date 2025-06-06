#!/bin/bash
# shellcheck disable=1091

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -z "${RUBY_VERSION}" ]; then
    export RUBY_VERSION="3.4.1"
fi


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
    eval "$(${brew_bin} shellenv)"
fi

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

remark "Configuring jenv for Java version management"
jenv enable-plugin export
jenv add "$(brew --prefix)/opt/openjdk@17"
jenv add "$(brew --prefix)/opt/openjdk@21"
jenv global version 17

if ! command -v ruby &> /dev/null || [[ "$(ruby -v)" != *"${RUBY_VERSION}"* ]]; then
    remark "Installing Ruby"
    ruby-install ruby "${RUBY_VERSION}"
fi

describe "Configuring VSCode file associations"
# associate all source code extensions known to Github’s linguist library with VSCode
curl "https://raw.githubusercontent.com/github/linguist/master/lib/linguist/languages.yml" \
  | yq -r "to_entries | (map(.value.extensions) | flatten) - [null] | unique | .[]" \
  | xargs -L 1 -I "{}" duti -s com.microsoft.VSCode {} all

remark "Configuring MacOS"
source "$current_dir/set-system-defaults.sh"

describe "Configuring Dock"
source "$current_dir/set-dock-apps.sh"

remark "Configuring R Makevars"
mkdir -p ~/.R
ln -sfv "$current_dir/R.Makevars" ~/.R/Makevars

remark "Configuring zsh"
ln -sfv "$current_dir/zsh/.zshrc" ~
ln -sfv "$current_dir/zsh/.zshenv" ~
ln -sfv "$current_dir/zsh/.zprofile" ~
ln -sfv "$current_dir/zsh/starship.toml" ~/.config