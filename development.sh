#!/bin/bash
pomoDaemon
tmux start-server
tmux new-session -s development -n editor -d
tmux send-keys -t development C-m C-m
tmux send-keys -t development 'cd ~/code' C-m
tmux send-keys -t development 'vim' C-m
tmux send-keys -t development ':e .' C-m
#tmux split-window -h -t development
#tmux new-window -n console -t development
tmux select-window -t development:0
tmux attach -t development
