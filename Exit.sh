#!/bin/sh

Choice=$(echo "Shutdown\nReboot\nExit" | dmenu -i -p "Choose action: ") 

[ $Choice = "Shutdown" ] && doas poweroff
[ $Choice = "Reboot"   ] && doas reboot
[ $Choice = "Exit"     ] && pkill dwm

