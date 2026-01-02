#!/usr/bin/env bash

# Start swww
WALLPAPERS_DIR=$HOME/.config/wallpapers/current
WALLPAPER=$(find "$WALLPAPERS_DIR" -type f | shuf -n 1)
swww img "$WALLPAPER"
