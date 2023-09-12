#!/bin/bash
#
# Gives a Dmenu prompt that enables you to mount usbs.
# It'll list all the mount points inside /mnt and let the user to choose
# If the user selects a novel directory, it will prompt you to create it 
#
# Dependencies: dmenu, notify-send, xclip, awk

pgrep -x dmenu && exit
mountable=$(lsblk -lp | grep "part $" | awk '{print $1" ("$4")"}')
pgrep -x dmenu && exit
[[ "$mountable" = "" ]] && exit 1
chosen=$(echo "$mountable" | dmenu -i -p "Mount wich drive?" | awk '{print $1}')
[[ "$chosen" = "" ]] && exit 1
dirs=$(find /mnt -type d -maxdepth 3 2> /dev/null)
mountpoint=$(echo "$dirs" | dmenu -i -p "Type in mount point")
[[ "$mountpoint" = "" ]] && exit 1
if [[ ! -d "$mountpoint" ]]; then 
	mkdiryn=$(echo -e "Yes\nNo" | dmenu -i -p "$mountpoint does not exist. Create it?")
	[[ "$mkdiryn" = Yes ]] && doas mkdir -p "$mountpoint"
fi
doas mount $chosen $mountpoint && notify-send "$chosen mounted to $mountpoint"
echo -n $mountpoint | xclip -selection c
