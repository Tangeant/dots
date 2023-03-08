#!/bin/bash
if pgrep -x "picom" > /dev/null
then
	killall picom
else
	picom -b --config ~/.config/berry/picom.conf
fi
