# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/osa/.zshrc'

export RPROMPT='[%~]'
export PROMPT='YUKI.N@%m> '
export PATH="$PATH:/var/lib/gems/1.9.1/bin:$HOME/script:$HOME/.cabal/bin:$HOME/.gem/bin:$HOME/app/arm-2011.09/bin:/home/osa/.gem/ruby/1.9.1/bin:/home/osa/.local/bin"
export GEM_HOME="$HOME/.gem"
export PYTHONPATH="/home/osa/.local/lib/python:$PYTHONPATH"
export EDITOR="vim"
export SVN_SSH='ssh -l osak -i /home/osa/.ssh/sakura_key'
export LANG=ja_JP.utf8
export TZ='Asia/Tokyo'
export CFLAGS="-Wall -O2"
export CXXFLAGS="-Wall -O2"

export REPORTTIME=60

alias cp='cp -v'
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

autoload -Uz compinit
compinit
# End of lines added by compinstall

DIRSTACKSIZE=100
setopt AUTO_PUSHD

zstyle ':completion:*' menu select
zstyle ':completion:*:cd:*' ignore-parents parent pwd
