#!/usr/bin/env bash  
# set-all-windows-alpha.sh
low_alpha=${1:-0.8}

# Get all window addresses
addresses=$(hyprctl clients | grep -oP 'Window \K[0-9a-f]+')

# Check if all windows are opaque (1.0)
all_opaque=true
for addr in $addresses; do
    current=$(hyprctl clients | grep -A20 "Window $addr" | grep -oP 'alpha: \K[0-9.]+')
    # Check if current is NOT 1.0 (allowing for floating point precision)
    if ! echo "$current 1.0" | awk '{exit ($1 >= 0.99 && $1 <= 1.01) ? 0 : 1}'; then
        all_opaque=false
        break
    fi
done

if [ "$all_opaque" = true ]; then
    # All are opaque, set to low alpha
    for addr in $addresses; do
        hyprctl dispatch setprop address:0x$addr alpha $low_alpha
    done
else
    # Not all opaque, set all to opaque
    for addr in $addresses; do
        hyprctl dispatch setprop address:0x$addr alpha 1.0
    done
fi
