# RECCO

- [RECCO](#recco)
  - [Description](#description)
  - [Dependencies](#dependencies)
  - [Installation](#installation)
  - [Usage](#usage)

## Description

A simple screen recording tool written in bash. RECCO uses [FFmpeg](https://github.com/FFmpeg/FFmpeg) to record, [tmux](https://github.com/tmux/tmux) to monitor the recording, [cli-visualizer](https://github.com/dpayne/cli-visualizer) to visualize audio.

## Dependencies

- [FFmpeg](https://github.com/FFmpeg/FFmpeg)
- [tmux](https://github.com/tmux/tmux) (Optional)
- [cli-visualizer](https://github.com/dpayne/cli-visualizer) (Optional)

## Installation

1. Clone this repo

    ```shell
    git clone https://github.com/Abdelrahman0W/recco.git
    ```
1. Change directory

    ```shell
    cd recco
    ```
1. Install using `make`

    ```shell
    make install
    ```

## Usage

1. Basic Usage

    > This will record the screen without capturing mic and device audio

    ```shell
    recco
    ```
1. Available Args

    ```
    -n <NAME>         The name of the output file (Default: screen-record-%Y-%m-%d-%H-%M-%S)
    -f <FORMAT>       The format of the output file (Defualt: MP4)
    -r <FRAMES>       Frame rate (Default: 30)
    -m <true|false>   Capture mic audio
    -d<true|false>    Capture device audio
    -c <CODEC>        Audio codec (Defualt: aac)
    ```
