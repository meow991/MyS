#!/bin/sh
maim | xclip -selection clipbourd -t image/png 
xclip -selection clipboard -target image/png -out > ~/Photos/screenshots/last_screenshot.png
