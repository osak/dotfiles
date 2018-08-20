# User configuration
source ~/zsh-git-prompt/zshrc.sh

export PATH="$HOME/.rbenv/bin:$HOME/script:$HOME/.cabal/bin:$HOME/.gem/bin:$HOME/.chefdk/gem/ruby/2.1.0/bin:$HOME/app/arm-2011.09/bin:$HOME/.local/bin:/usr/bin/vendor_perl:$HOME/.rbenv/shims:$PATH"
export GEM_HOME="$HOME/.gem"
export PYTHONPATH="/home/osak/.local/lib/python:$PYTHONPATH"
export EDITOR="vim"
export CFLAGS="-Wall -O2"
export CXXFLAGS="-Wall -O2 -g -std=c++11"
export MAKEFLAGS="-j4"
export GOPATH=/home/osak/program/Go
export MOZ_USE_XINPUT2=1

export PROMPT='
[%D{%Y-%m-%d %H:%M:%S%z}][%/]
%n@%M$(git_super_status)> '
export REPORTTIME=60

#alias cp='rsync -a --progress'
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

function smart-unzip() {
    file=$1
    topdirs=$(unzip -Z1 "${file}" | cut -d '/' -f 1 | sort -u | wc -l)
    if [ $topdirs -gt 1 ]; then
        dirname=${file%.zip}
        unzip "${file}" "-d${dirname}"
    else
        unzip "${file}"
    fi
}

setopt extendedglob
zstyle ':completion:*' menu select
zstyle ':completion:*:cd:*' ignore-parents parent pwd

bindkey -e

#. /home/osak/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(rbenv init -)"
