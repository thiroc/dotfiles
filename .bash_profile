#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start ssh-agent in background
eval "$(ssh-agent -s)" &> /dev/null
ssh-add ~/.ssh/id_rsa &> /dev/null

