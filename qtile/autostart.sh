#!/bin/sh
#~/.screenlayout/qtile2.sh
setxkbmap es
~/.screenlayout/config.sh
XINERAMA_SCREEN=0 feh -qrz --bg-fill ~/wallpapers/
DISPLAY=:0 ~/dotfiles/personal/scripts/wallpapers.sh
udiskie -t &
nm-applet &
cbatticon &
copyq &
xset s off &
xset -dpms &
##~/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox --minimize  &
## autocutsel -fork &
## autocutsel -selection PRIMARY -fork &
flameshot &
