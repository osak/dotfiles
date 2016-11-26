# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="osak"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git rails mercurial)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/var/lib/gems/1.9.1/bin:$HOME/script:$HOME/.cabal/bin:$HOME/.gem/bin:$HOME/.chefdk/gem/ruby/2.1.0/bin:$HOME/app/arm-2011.09/bin:$HOME/.local/bin:/usr/bin/vendor_perl:$HOME/.rbenv/shims:$PATH"
export GEM_HOME="$HOME/.gem"
export PYTHONPATH="/home/osak/.local/lib/python:$PYTHONPATH"
export EDITOR="vim"
export SVN_SSH='ssh -l osak -i /home/osak/.ssh/sakura_key'
export LANG=ja_JP.utf8
export TZ='Asia/Tokyo'
export CFLAGS="-Wall -O2"
export CXXFLAGS="-Wall -O2 -g -std=c++11"
export MAKEFLAGS="-j4"
export GOPATH=/home/osak/program/Go

export REPORTTIME=60

alias cp='rsync -a --progress'
alias rm='rm -v'
alias vi='vim'
alias ls='ls -F --color'
alias azcat=cat

function cal() {
    if [ $# -ne 2 ]; then
        command cal $*
    else
        month=$1
        year=$2
        if [ $month -gt $year ]; then
            tmp=$month
            month=$year
            year=$tmp
        fi
        command cal $month $year
    fi
}

zstyle ':completion:*' menu select
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
. /home/osak/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
