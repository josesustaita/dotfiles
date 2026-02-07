#!/bin/bash

# Check how many monitors are connected
# 'eDP-1' is usually your laptop screen. Adjust if yours is different (check 'hyprctl monitors')
MONITOR_COUNT=$(hyprctl monitors -j | jq '. | length')

if [ "$MONITOR_COUNT" -le 1 ]; then
    # Only the internal screen is detected (or nothing), so suspend
    systemctl suspend
else
    # External monitor detected, just disable the laptop screen
    hyprctl keyword monitor "eDP-1, disable"
fi
