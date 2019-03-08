#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
#export PS1='[\u@\h \W]\$ '
export PS1='\[\033[1;30m\][\[\033[0;32m\]\u@\h \W\[\033[1;30m\]]\[\033[0;32m\]\$\[\033[0m\] '

export EDITOR="vim"
export VISUAL="vim"

# Support for accents in us layout
setxkbmap -layout us -variant intl

# Function for tmux alias, that starts new session named after the current dir
function tnew() {
	tmux new-session -As "tnew ${PWD}"
}

export -f tnew

