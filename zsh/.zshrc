# need to run these for autocompletion to work
autoload -Uz +X compinit && compinit
autoload -Uz +X bashcompinit && bashcompinit

# gcloud shell and completion need to be loaded before oh-my-zsh
if [ -f '/Users/adamblake/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/adamblake/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/adamblake/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/adamblake/google-cloud-sdk/completion.zsh.inc'; fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# path to oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(kubectl helm-autocomplete)

source $ZSH/oh-my-zsh.sh

# User configuration

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# enable autocompletion for aliases
setopt completealiases

# zsh config
alias ec='$EDITOR $HOME/.zshrc'
alias ea='$EDITOR $HOME/.zsh_aliases'
alias sc='source $HOME/.zshrc'

# viewing/editing files
alias edit='$EDITOR'
alias view='less -FX'

# use radian for R (better terminal experience for R)
alias r=radian

alias python=python3
alias pip=pip3

# git stuff
alias gs='git status'
alias gl='git logdog'
alias gc='git commit'

# git-flow stuff
alias gff='git flow feature'
alias gfh='git flow hotfix'
alias gfr='git flow release'
alias gfs='git flow support'
alias gfv='git flow version'

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
