#!/bin/bash

DIR=/usr/local/bin/recco-dir

source $DIR/config/consts.sh

function hide_cursor() {
    tput civis
}

function reset_terminal() {
    tput clear
    tput cnorm
    tput sgr0
    exit
}

function start_timer() {
    trap reset_terminal INT TERM
    tput clear

    hide_cursor

    start_time=$(date +%s)
    while true; do
        tput cup $CENTER_ROW $CENTER_COL
        current_time=$(date +%s)
        elapsed_time=$(($current_time - $start_time))
        echo -ne "${BLUE} Recording Time:${RESET}${BOLD} $(date -u -d @${elapsed_time} +"%T")${RESET}\r"
        sleep 1
    done

    reset_terminal
}

start_timer
