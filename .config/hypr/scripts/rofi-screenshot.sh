#!/bin/bash

# Options to display
option_region="  Region"
option_window="  Window"
option_monitor="  Monitor"

# Rofi command (tweak width/lines as needed)
# Ensure you are using rofi-wayland
chosen=$(echo -e "$option_region\n$option_window\n$option_monitor" | rofi -dmenu -p "Screenshot" -theme-str 'window {width: 12em;} listview {lines: 3;}')

case $chosen in
$option_region)
  # Sleep avoids capturing rofi closing animation
  sleep 0.2
  hyprshot -m region
  ;;
$option_window)
  sleep 0.2
  hyprshot -m window
  ;;
$option_monitor)
  sleep 0.2
  hyprshot -m output
  ;;
esac
