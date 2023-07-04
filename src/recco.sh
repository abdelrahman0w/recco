#!/bin/bash

DIR=/usr/local/bin/recco-dir
ARGS=$@

source $DIR/config/consts.sh
source $DIR/config/deps.sh

check_ffmpeg
check_tmux
check_vis

if [ "$IS_VIS" = true ] && [ "$IS_TMUX" = true ]; then
    tmux new-session -s recorder -d

    tmux split-window -h
    tmux select-pane -t 1
    tmux split-window -v
    tmux split-window -v

    tmux select-pane -t 1
    tmux rename-window "time"
    tmux send-keys "sh $DIR/config/timer.sh" C-m

    tmux select-pane -t 2
    tmux rename-window "mic-audio"
    tmux send-keys "vis -c $MIC_CONFIG" C-m

    tmux select-pane -t 3
    tmux rename-window "device-audio"
    tmux send-keys "vis -c $DEVICE_CONFIG" C-m

    tmux select-pane -t 0
    tmux rename-window "recorder"
    tmux send-keys "sh $DIR/config/recorder.sh $ARGS; tmux kill-session -t recorder" C-m

    tmux attach-session -t recorder

    exit 0
fi

if [ "$IS_TMUX" = true ]; then
    tmux new-session -s recorder -d

    tmux split-window -h
    tmux select-pane -t 1

    tmux select-pane -t 1
    tmux rename-window "time"
    tmux send-keys "sh $DIR/config/timer.sh" C-m

    tmux select-pane -t 0
    tmux rename-window "recorder"
    tmux send-keys "sh $DIR/config/recorder.sh $ARGS; tmux kill-session -t recorder" C-m

    tmux attach-session -t recorder

    exit 0
fi
