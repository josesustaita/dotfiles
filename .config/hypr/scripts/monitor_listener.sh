#!/bin/bash

# Function to run your existing manager
update_power() {
  # Adding a small delay to ensure Hyprland updates the monitor list first
  sleep 2
  ~/.config/hypr/scripts/battery_manager.sh
}

# Run once on startup
update_power

# Listen to Hyprland socket for monitor events
socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do
  if [[ $line == "monitoradded>>"* ]] || [[ $line == "monitorremoved>>"* ]]; then
    update_power
  fi
done
