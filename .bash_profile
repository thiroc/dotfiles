#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start ssh-agent in background
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
