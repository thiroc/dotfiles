#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set up PS1, with git branch suffix in the applicable directories
PS1='\[\033[1;30m\][\[\033[0;32m\]\u@\h \W\[\033[1;30m\]]\[\033[0;32m\]\$\[\033[0m\] '
GIT_SCRIPT=$HOME/bin/scripts/git-prompt.sh
if [ -f $GIT_SCRIPT  ]
then
	source $GIT_SCRIPT
	PS1+='$(__git_ps1 " (%s)")\[\e[0m\] ' # Adds suffix to PS1 showing git branch
fi

export PS1=$PS1
export EDITOR="vim"
export VISUAL="vim"
export BROWSER="w3m"
export GBROWSER="firefox"
export XDG_CONFIG_HOME="$HOME/.config"
export TMUXP_CONFIGDIR=$XDG_CONFIG_HOME/tmuxp

# Function for tmux alias, that starts new session named after the current dir
function tmn() {
	tmux new-session -As "${PWD}"
}
export -f tmn

## Set keyboard layout
setxkbmap -layout us -variant intl -option "caps:swapescape"

# ALIASES
alias dt='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias ls='ls --color=auto'
alias mut='neomutt -F $HOME/.config/mutt/muttrc'
alias ncm='ncmpcpp'
alias nsb='newsboat'
alias rai='rainbowstream'
alias ran='ranger'
alias tma='tmux attach-session'
alias tae='task proj:estudos'
alias tap='task proj:pessoal'
alias tat='task proj:trabalho'

# Definitions for fzf/rgrep below
if type rg &> /dev/null; then
	export FZF_DEFAULT_COMMAND='rg --files'
	export FZF_DEFAULT_OPTS='--height 50% --border'
fi

# Host-specific configs
if [[ "$HOSTNAME" == "ABELHA2626" ]] # Autotrac host
then
	# setup gdb compiled for arm target with UCC bin
	export PROJUCC=$HOME/projetos/SDP_UCC
	alias guc='$PROJUCC/tools.buildroot/output/build/host-gdb-8.2.1/gdb/gdb $PROJUCC/ucc/App/UCC/arm-bin/UCC'
	
	export PATH=$PATH:/opt/toolchain/host/bin
	TMOUT=0 # unset timeout for terminal

	xprop -name 'urxvt' -format _MOTIF_WM_HINTS 32c -set _MOTIF_WM_HINTS 2
	dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:swapescape']"

else # Home host

	# The next line updates PATH for the Google Cloud SDK.
	if [ -f '/home/thiroc/caos/google-cloud-sdk/path.bash.inc' ]; then . '/home/thiroc/caos/google-cloud-sdk/path.bash.inc'; fi

	# The next line enables shell command completion for gcloud.
	if [ -f '/home/thiroc/caos/google-cloud-sdk/completion.bash.inc' ]; then . '/home/thiroc/caos/google-cloud-sdk/completion.bash.inc'; fi

fi
