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
export GBROWSER="firefox"
export XDG_CONFIG_HOME="~/.config"

# Support for accents in us layout
setxkbmap -layout us -variant intl

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/thiroc/caos/google-cloud-sdk/path.bash.inc' ]; then . '/home/thiroc/caos/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/thiroc/caos/google-cloud-sdk/completion.bash.inc' ]; then . '/home/thiroc/caos/google-cloud-sdk/completion.bash.inc'; fi

# Function for tmux alias, that starts new session named after the current dir
function tmn() {
	tmux new-session -As "${PWD}"
}
export -f tmn

if [[ $DISPLAY ]]; then
	if [[ -z "$TMUX" ]]; then # if $TMUX not defined
		#ID=$(tmux ls | grep -vm1 attached | cut -d: -f1)
		SID=$(tmux ls | grep pessoal | cut -d: -f1) # get session name
		if [[ -z "$SID" ]]; then # if session don't with SID do not exist
			exec ~/bin/scripts/tmux-session-pessoal.sh
		fi
	fi
fi

# ALIASES
alias dotfiles='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias ls='ls --color=auto'
alias mut='neomutt -F $HOME/.config/mutt/muttrc'
alias ncm='ncmpcpp'
alias nsb='newsboat'
alias rai='rainbowstream'
alias ran='ranger'
alias tma='tmux attach-session'
alias tunb='task proj:estudos.unb'
