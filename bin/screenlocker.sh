#!/bin/bash

#Requirements: http://www.fmwconcepts.com/imagemagick/videoglitch/index.php
# 	      Imagemagick

scrot -o $HOME/.cache/screen.png

#convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
$HOME/bin/videoglitch.sh -n 20 -j 10 -c blue-yellow $HOME/.cache/screen.png $HOME/.lockscreen.png
echo "done1"
if [[ -f $HOME/.lockscreen.png ]]
then
    # placement x/y
    PX=0
    PY=0
    # lockscreen image info
    R=$(file ~/.config/lock.png | grep -o '[0-9]* x [0-9]*')
    RX=$(echo $R | cut -d' ' -f 1)
    RY=$(echo $R | cut -d' ' -f 3)

    SR=$(xrandr --query | grep ' connected' | sed 's/primary //' | cut -f3 -d' ')
    for RES in $SR
    do
        # monitor position/offset
        SRX=$(echo $RES | cut -d'x' -f 1)                   # x pos
        SRY=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 1)  # y pos
        SROX=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 2) # x offset
        SROY=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 3) # y offset
        PX=$(($SROX + $SRX/2 - $RX/2))
        PY=$(($SROY + $SRY/2 - $RY/2))

        convert $HOME/.lockscreen.png $HOME/.lockscreen.png -geometry +$PX+$PY -composite -matte  $HOME/.cache/screen.png
        echo "done"
    done
fi
# dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop
#i3lock  -I 10 -d -e -u -n -i $HOME/.lockscreen.png
#betterlockscreen -l
