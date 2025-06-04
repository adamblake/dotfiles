# maintain separate terminal histories
unsetopt share_history
setopt noincappendhistory
setopt nosharehistory
setopt appendhistory

# need to run these for autocompletion to work
autoload -Uz +X compinit && compinit
autoload -Uz +X bashcompinit && bashcompinit

# gcloud shell and completion
if [ -f '/Users/adamblake/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/adamblake/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/adamblake/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/adamblake/google-cloud-sdk/completion.zsh.inc'; fi

# direnv
emulate zsh -c "$(direnv hook zsh)"

# >>> scm_breeze >>>
[ -s "~/.scm_breeze/scm_breeze.sh" ] && source "~/.scm_breeze/scm_breeze.sh"
# <<< scm_breeze <<<

# >>> VSCode venv deactivate hook >>>
source ~/.vscode-python/deactivate
# <<< VSCode venv deactivate hook <<<

# >>> chruby >>>
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby ruby-3.4.1
# <<< chruby <<<

# enable autocompletion for aliases
setopt completealiases

# viewing/editing files
alias edit="$EDITOR"
alias view='less -FX'

# update brew packages
alias bu='brew update && brew upgrade && brew cleanup'

alias python=python3
alias pip=uv pip
alias r=/Users/adamblake/.local/bin/radian

# git stuff
alias gs='git status'
alias gl='git logdog'

# git-flow stuff
alias gff='git flow feature'
alias gfh='git flow hotfix'
alias gfr='git flow release'
alias gfs='git flow support'
alias gfv='git flow version'

alias setup-r='Rscript --no-init-file "$HOME/pd/dotfiles/R/r-packages.r"'

# cd into a ~/work directory
cw() {
  cd "$HOME/work/$1" || return
}

# open the directory ~/$1/$2 in vscode
code_nested() {
  if [ -z ${1+x} ] || [ ! -d "$HOME/$1" ]; then
    echo "First argument should be a directory in the home directory (~)"
    return
  fi

  if [ -z ${2+x} ]; then
    echo "You must indicate which ~/$1 folder to open."
    return
  fi

  if [ ! -d "$HOME/$1/$2" ]; then
    echo "The folder \"$HOME/$1/$2\" does not exist."
    return
  fi

  code "$HOME/$1/$2" || return
}

# open a ~/work directory in vscode
ow() { code_nested work "$1"; }

# open a ~/pd directory in vscode
op() { code_nested pd "$1"; }

# define autocomplete for the above functions
compdef "_path_files -W $HOME/work -/ $$ return 0 || return 1" cw
compdef "_path_files -W $HOME/work -/ $$ return 0 || return 1" ow
compdef "_path_files -W $HOME/pd -/ $$ return 0 || return 1" op

# load other auto-completions from ~/.zfunc
autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc
