#!/bin/bash
#
# Gives a Dmenu prompt that enables you to unmount usbs.
# It'll list all the mount points inside /mnt and let the user to choose
# If the user selects a novel directory, it will prompt you to create it 
#
# Dependencies: dmenu, notify-send, awk

pgrep -x dmenu && exit
umountable=$(lsblk -lp | grep "part /mnt" | awk '{print $7" ("$4")"}')
[[ "$umountable" = "" ]] && exit 1
chosen=$(echo "$umountable" | dmenu -i -p "Unmount wich drive?" | awk '{print $1}')
[[ "$chosen" = "" ]] && exit 1

doas umount $chosen && notify-send "$chosen unmounted"
