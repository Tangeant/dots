#!/bin/bash
cat "$HOME/.config/sxhkd/common-keys" | awk '/^[a-z]/ && last {print $0,"\t",last} {last=""} /^#/{last=$0}' | column -t -s $'\t' | rofi -dmenu -i -no-show-icons -width 1000 -lines 15
