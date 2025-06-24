export TERM="xterm-256color"

# Pager
export PAGER=less
# Less status line
export LESS='-R -f -X -i -F -P ?f%f:(stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'
export LESSCHARSET='utf-8'

# LESS man page colors (makes Man pages more readable).
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[00;44;37m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# History
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=1000000
export LISTMAX=50
# don't keep history when running as root
if [[ $UID == 0 ]]; then
    unset HISTFILE
    export SAVEHIST=0
fi
# maintain separate terminal histories
unsetopt share_history
setopt noincappendhistory
setopt nosharehistory
setopt appendhistory

# need to run these for autocompletion to work
autoload -Uz +X compinit && compinit
autoload -Uz +X bashcompinit && bashcompinit

# >>> gcloud shell and completion >>>
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi
# <<< gcloud shell and completion <<<

# >>> direnv >>>
emulate zsh -c "$(direnv hook zsh)"
# <<< direnv <<<

# >>> VSCode venv deactivate hook >>>
[ -f "$HOME/.vscode-python/deactivate" ] && source "$HOME/.vscode-python/deactivate"
# <<< VSCode venv deactivate hook <<<

# >>> chruby >>>
source "$(brew --prefix)/opt/chruby/share/chruby/chruby.sh"
source "$(brew --prefix)/opt/chruby/share/chruby/auto.sh"
chruby ruby-3.4.1
# <<< chruby <<<

# >>> jenv >>>
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
# <<< jenv <<<

# enable autocompletion for aliases
setopt completealiases

# viewing/editing files
alias edit="$EDITOR"
alias view='less -FX'

# update brew packages
alias bu='brew update && brew upgrade && brew cleanup'

alias python=python3
alias pip="uv pip"

# git stuff
alias gs='git status'
alias gl='git logdog'

# git-flow stuff
alias gff='git flow feature'
alias gfh='git flow hotfix'
alias gfr='git flow release'
alias gfs='git flow support'
alias gfv='git flow version'

alias setup-r='Rscript --no-init-file "$HOME/personal/dotfiles/R/r-packages.r"'

# cd into a ~/work directory
cdw() {
  cd "$HOME/work/$1" || return
}

# cd into a ~/personal directory
cdp() {
  cd "$HOME/personal/$1" || return
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

# open a ~/personal directory in vscode
op() { code_nested personal "$1"; }

# define autocomplete for the above functions
compdef "_path_files -W $HOME/work -/ $$ return 0 || return 1" cdw
compdef "_path_files -W $HOME/personal -/ $$ return 0 || return 1" cdp
compdef "_path_files -W $HOME/work -/ $$ return 0 || return 1" ow
compdef "_path_files -W $HOME/personal -/ $$ return 0 || return 1" op

# enable Docker CLI completions.
fpath=(/Users/adamblake/.docker/completions $fpath)

# load other auto-completions from ~/.zfunc
zstyle ':completion:*' menu select
fpath=(~/.zfunc $fpath)

# load starship prompt
if (which starship > /dev/null) then
  eval "$(starship init zsh)"
fi
