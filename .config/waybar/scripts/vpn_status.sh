#!/bin/bash

# GET CURRENT ACTIVE VPN
ACTIVE_VPN=$(nmcli -t -f TYPE,NAME connection show --active | grep '^vpn:' | cut -d: -f2 | head -n1)

# -----------------------------------------------------------------------------
# TOGGLE LOGIC (Left Click)
# -----------------------------------------------------------------------------
if [ "$1" == "toggle" ]; then
  if [ -n "$ACTIVE_VPN" ]; then
    # If connected, turn it off immediately
    nmcli connection down "$ACTIVE_VPN"
    notify-send "VPN" "Disconnected from $ACTIVE_VPN"
  else
    # If disconnected, trigger the menu selection
    "$0" menu
  fi
  exit
fi

# -----------------------------------------------------------------------------
# MENU LOGIC (Right Click or Connect)
# -----------------------------------------------------------------------------
if [ "$1" == "menu" ]; then
  # List all VPN connections configured in NetworkManager
  # -t: terse, -f: fields, grep: only VPNs, cut: get name
  VPNS=$(nmcli -t -f TYPE,NAME connection show | grep '^vpn:' | cut -d: -f2)

  # If no VPNs configured, warn user
  if [ -z "$VPNS" ]; then
    notify-send "VPN" "No VPN connections found in NetworkManager."
    exit
  fi

  # Show Rofi Menu
  CHOSEN_VPN=$(echo "$VPNS" | rofi -dmenu -p " Connect to VPN" -lines 5)

  if [ -n "$CHOSEN_VPN" ]; then
    # If user picked a VPN, connect to it
    notify-send "VPN" "Connecting to $CHOSEN_VPN..."

    if nmcli connection up "$CHOSEN_VPN"; then
      notify-send "VPN" "Successfully connected to $CHOSEN_VPN"
    else
      notify-send "VPN" "Failed to connect to $CHOSEN_VPN"
    fi
  fi
  exit
fi

# -----------------------------------------------------------------------------
# STATUS LOGIC (For Waybar Display)
# -----------------------------------------------------------------------------
if [ -n "$ACTIVE_VPN" ]; then
  echo "{\"text\": \" $ACTIVE_VPN\", \"tooltip\": \"Connected to: $ACTIVE_VPN\", \"class\": \"connected\"}"
else
  echo "{\"text\": \" Off\", \"tooltip\": \"Click to Connect\", \"class\": \"disconnected\"}"
fi
