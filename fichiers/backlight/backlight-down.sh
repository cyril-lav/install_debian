#!/bin/zsh

BACKLIGHT_LEVEL=`cat backlight_level`

BACKLIGHT_LEVEL=$(($BACKLIGHT_LEVEL - 0.1)) 

echo $BACKLIGHT_LEVEL>backlight_level

xrandr --output eDP-1 --brightness $BACKLIGHT_LEVEL