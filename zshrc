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
export PROMPT='YUKI.N> '
export PATH="$PATH:/var/lib/gems/1.9.1/bin:$HOME/script:$HOME/.cabal/bin:$HOME/.gem/bin:$HOME/app/arm-2011.09/bin:/home/osa/.gem/ruby/1.9.1/bin"
export GEM_HOME="$HOME/.gem"
export PYTHONPATH="/home/osa/.local/lib/python:$PYTHONPATH"
export EDITOR="vim"
export LANG=ja_JP.utf8
export TZ='Asia/Tokyo'

export REPORTTIME=60

alias cp='cp -v'
alias rm='rm -v'
alias vi='vim'
alias ls='ls -F --color'

autoload -Uz compinit
compinit
# End of lines added by compinstall
