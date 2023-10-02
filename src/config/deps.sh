#!/bin/bash

IS_TMUX=true
IS_VIS=true

function check_ffmpeg() {
    if ! command -v ffmpeg &> /dev/null
    then
        echo -e "${RED}ffmpeg could not be found!${RESET}"
        echo -e "please install ffmpeg to use the tool!"

        exit 1
    fi
}

function check_tmux() {
    if ! command -v tmux &> /dev/null
    then
        IS_TMUX=false
        echo -e "${YELLOW}tmux could not be found!${RESET}"
        echo -e "will only run the recorder"
        read -n 1 -s -r -p "Press any key to continue..."
        echo ""
    fi
}

function check_vis() {
    if ! command -v vis &> /dev/null
    then
        IS_VIS=false
        echo -e "${YELLOW}vis could not be found!${RESET}"
        echo -e "there will be no audio visualization!"
        read -n 1 -s -r -p "Press any key to continue..."
        echo ""
    fi
}
