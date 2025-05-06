#!/usr/bin/env bash

set -xe

sudo apt update
sudo apt install trash-cli htop vim vim-gtk glow tmux ghostty
sudo apt upgrade trash-cli htop vim vim-gtk glow tmux ghostty
eval "$(wget -O- https://get.x-cmd.com)"
x install lla
x install yazi
x install gotop
