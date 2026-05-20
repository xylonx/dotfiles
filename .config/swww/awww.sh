#!/usr/bin/env bash

# Start awww
WALLPAPERS_DIR=$HOME/.config/wallpapers/current
WALLPAPER=$(find "$WALLPAPERS_DIR" -type f | shuf -n 1)
awww img "$WALLPAPER"
