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

# Function for tmux alias, that starts new session named after the current dir
function tmn() {
	tmux new-session -As "${PWD}"
}
export -f tmn


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

if [[ "$HOSTNAME" == "ABELHA2626" ]] # Autotrac host
then
	setxkbmap -layout br
	export PATH=$PATH:/opt/toolchain/host/bin
	TMOUT=0 # unset timeout for terminal
	export TMOUT
	readonly TMOUT
	
	GIT_SCRIPT=$HOME/bin/scripts/git-prompt.sh
	if [ -f $GIT_SCRIPT  ]
	then
		source $GIT_SCRIPT
		export PS1='\[\033[1;30m\][\[\033[0;32m\]\u@\h \W\[\033[1;30m\]]\[\033[0;32m\]\$\[\033[0m\]$(__git_ps1 " (%s)")\[\e[0m\] '
		#PS1='[\u@\h \[\e[0;32m\]\w\[\e[0;33m\]$(__git_ps1 " (%s)")\[\e[0m\]]$ '
	fi

	if [[ $DISPLAY ]]; then
		if [ -z "$TMUX" ]; then # if $TMUX not defined
			##ID=$(tmux ls | grep -vm1 attached | cut -d: -f1)
			SESSIONS=$(tmux ls 2> /dev/null)
			if [ -n "$SESSIONS" ]; then
				SID=$(echo $SESSIONS | grep trabalho | cut -d: -f1) # get session name
				if [ -z "$SID" ]; then # if session with SID do not exist
					exec ~/bin/scripts/tmux-session-trabalho.sh
				fi
			fi
		fi
	fi
else # Home host
	setxkbmap -layout us -variant intl

	# The next line updates PATH for the Google Cloud SDK.
	if [ -f '/home/thiroc/caos/google-cloud-sdk/path.bash.inc' ]; then . '/home/thiroc/caos/google-cloud-sdk/path.bash.inc'; fi

	# The next line enables shell command completion for gcloud.
	if [ -f '/home/thiroc/caos/google-cloud-sdk/completion.bash.inc' ]; then . '/home/thiroc/caos/google-cloud-sdk/completion.bash.inc'; fi

	if [[ $DISPLAY ]]; then
		if [[ -z "$TMUX" ]]; then # if $TMUX not defined
			#ID=$(tmux ls | grep -vm1 attached | cut -d: -f1)
			SID=$(tmux ls | grep pessoal | cut -d: -f1) # get session name
			if [[ -z "$SID" ]]; then # if session don't with SID do not exist
				exec ~/bin/scripts/tmux-session-pessoal.sh
			fi
		fi
	fi
fi

