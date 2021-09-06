#!/bin/bash

# Terminate already running bar instances
# killall -q polybar

# Wait until the processes have been shut down
# while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
#polybar laptop &

sleep .5

if [[ ! `pgrep -x polybar` ]]; then
    if [[ $CONFIGURATION = 'work-office' ]]; then
	    polybar laptop &
	    polybar top4k &
    elif [[ $CONFIGURATION = 'laptop-only' ]]; then
	    polybar laptop &
    elif [[ $CONFIGURATION = 'home-den' ]]; then
	    polybar laptop &
	    polybar top1k &
    elif [[ $CONFIGURATION = 'home-office' ]]; then
	    polybar laptop &
	    polybar top2k &
    fi
else
	pkill -USR1 polybar
fi
