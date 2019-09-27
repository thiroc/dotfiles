#!/bin/bash

SID="pessoal"

tmux new -d -s $SID

tmux rename-window -t $SID ncmpcpp
tmux send-keys -t $SID 'ncm' C-m

tmux new-window -t $SID
tmux rename-window -t $SID newsboat
tmux send-keys -t $SID 'nsb' C-m

tmux select-window -t $SID:1
