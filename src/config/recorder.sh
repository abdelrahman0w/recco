#!/bin/bash

DIR=/usr/local/bin/recco-dir

source $DIR/config/consts.sh

output_file_name="screen-record-$(date +%Y-%m-%d-%H-%M-%S)"
output_format="mp4"
frame_rate=30
record_microphone=false
record_device_audio=false
audio_codec="aac"
video_codec="libx264"
video_bitrate="1000k"
audio_bitrate="128k"

function usage() {
    echo "Usage:"
    echo "  recco [options]"
    echo ""
    echo "Options:"
    echo "  -n <NAME>         The name of the output file (Default: screen-record-%Y-%m-%d-%H-%M-%S)"
    echo "  -f <FORMAT>       The format of the output file (Defualt: MP4)"
    echo "  -r <FRAMES>       Frame rate (Default: 30)"
    echo "  -m                Capture mic audio"
    echo "  -d                Capture device audio"
    echo "  -c <CODEC>        Audio codec (Defualt: aac)"
    exit 1
}

function init_recorder() {
    clear
    tput cup 0 0
}

function recorder_info() {
    echo -e "${BLUE}[${RESET}TRACE${BLUE}]${YELLOW} Output File Name:${RESET} $output_file_name.$output_format${RESET}"
    echo -e "${BLUE}[${RESET}TRACE${BLUE}]${YELLOW} Frame Rate:${RESET} $frame_rate${RESET}"
    echo -e "${BLUE}[${RESET}TRACE${BLUE}]${YELLOW} Record Microphone:${RESET} $record_microphone${RESET}"
    echo -e "${BLUE}[${RESET}TRACE${BLUE}]${YELLOW} Record Device Audio:${RESET} $record_device_audio${RESET}"
    echo -e "${BLUE}[${RESET}TRACE${BLUE}]${YELLOW} Audio Codec:${RESET} $audio_codec${RESET}"
    echo -e "${BLUE}[${RESET}TRACE${BLUE}]${YELLOW} Video Codec:${RESET} $video_codec${RESET}"
    echo -e "${BLUE}[${RESET}TRACE${BLUE}]${YELLOW} Video Bitrate:${RESET} $video_bitrate${RESET}"
    echo -e "${BLUE}[${RESET}TRACE${BLUE}]${YELLOW} Audio Bitrate:${RESET} $audio_bitrate${RESET}"
    echo -e "${BLUE}[${RESET}TRACE${BLUE}]${YELLOW} Audio Input:${RESET} ${audio_input:3}"
    echo ""
    echo -e "${BLUE}[${RESET}INFO ${BLUE}]${GREEN} Starting Recording...${RESET}"
    echo -e "${BLUE}[${RESET}INFO ${BLUE}]${RESET} Press Ctrl+C When Done${RESET}"
}

function record() {
    ffmpeg -hide_banner -loglevel error \
        -f x11grab \
        -r $frame_rate \
        -s $(xdpyinfo | grep dimensions | awk '{print $2;}') \
        -i :0.0 $audio_input \
        -c:v $video_codec \
        -b:v $video_bitrate \
        -c:a $audio_codec \
        -b:a $audio_bitrate \
        $output_file_name.$output_format
}

function start_recorder() {
    init_recorder
    recorder_info
    record

    echo -e "${BLUE}[${RESET}INFO ${BLUE}]${YELLOW} Saved Recording to:${RESET} $(pwd)/$output_file_name.$output_format"
    echo -e "${BLUE}[${RESET}INFO ${BLUE}]${GREEN} Recording Finished!${RESET}"
}

while getopts "n:f:r:c:md" opt; do
    case $opt in
        n) output_file_name="$OPTARG";;
        f) output_format="$OPTARG";;
        r) frame_rate="$OPTARG";;
        m) record_microphone=true;;
        d) record_device_audio=true;;
        c) audio_codec="$OPTARG";;
        :) usage;;
        \?) usage;;
    esac
done

if [ "$record_microphone" = true ]; then
    echo -e "${BLUE}[${RESET}TRACE${BLUE}]${YELLOW} Microphone:${RESET} $(pactl list short sources | grep -i input | awk '{print $2;}' | tail -n 1)"
    audio_input+="-f pulse -ac 2 -i $(pactl list short sources | grep -i input | awk '{print $2;}' | tail -n 1) "
fi

if [ "$record_device_audio" = true ]; then
    echo -e "${BLUE}[${RESET}TRACE${BLUE}]${YELLOW} Audio Device:${RESET} $(pactl list short sources | grep -i output | awk '{print $2;}' | tail -n 1)"
    audio_input+="-f pulse -ac 2 -i $(pactl list short sources | grep -i output | awk '{print $2;}' | tail -n 1) "
fi

start_recorder
