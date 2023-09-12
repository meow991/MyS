#!/bin/sh

arg=$1 
[ $arg = "up"     ] && amixer set Master 5dB+
[ $arg = "down"   ] && amixer set Master 5dB-
[ $arg = "toggle" ] && amixer set Master toggle


