#!/bin/bash

DIR=/usr/local/bin/recco-dir
MIC_CONFIG=$DIR/config/vis/mic
DEVICE_CONFIG=$DIR/config/vis/device

ROWS=`tput lines`
COLS=`tput cols`

FORMAT='Recording Time: HH:MM:SS'

CENTER_ROW=$((ROWS / 2))
CENTER_COL=$(( (COLS - ${#FORMAT}) / 2 ))

BOLD='\e[1m'
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
PURPLE='\e[35m'
CYAN='\e[36m'
RESET='\e[0m'
