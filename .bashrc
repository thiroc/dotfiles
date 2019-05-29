#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#export PS1='[\u@\h \W]\$ '
export PS1='\[\033[1;30m\][\[\033[0;32m\]\u@\h \W\[\033[1;30m\]]\[\033[0;32m\]\$\[\033[0m\] '

export EDITOR="vim"
export VISUAL="vim"
export BROWSER="w3m"
export GBROWSER="w3m"

# Support for accents in us layout
setxkbmap -layout us -variant intl

# Function for tmux alias, that starts new session named after the current dir
function tmn() {
	tmux new-session -As "tnew ${PWD}"
}

export -f tmn

# ALIASES
alias dotfiles='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias ls='ls --color=auto'
alias mut='neomutt'
alias ncm='ncmpcpp'
alias nsb='newsboat'
alias rai='rainbowstream'
alias ran='ranger'
alias tma='tmux attach-session'
alias tunb='task proj:estudos.unb'

