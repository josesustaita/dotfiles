#!/bin/bash
# If the Studio Display (DP-1) is connected, stop the laptop from sleeping
if hyprctl monitors | grep -q "DP-1"; then
  systemd-inhibit --what=handle-lid-switch --who="Hyprland" --why="Clamshell Mode" --mode=block sleep 1d &
fi
