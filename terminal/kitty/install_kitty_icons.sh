#!/bin/bash
set -eu
kitty_dir="${XDG_CONFIG_HOME:-"${HOME}"/.config}/kitty"
cp kitty.app-128.png "${kitty_dir}/"
cp kitty.app.png "${kitty_dir}/"
