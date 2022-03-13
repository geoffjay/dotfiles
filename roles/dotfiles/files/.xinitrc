#!/bin/bash

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/Xresources
sysmodmap=/etc/X11/Xmodmap

if [[ -f $sysresources ]]; then
    xrdb -merge $sysresources
fi

if [[ -f $sysmodmap ]]; then
    xmodmap $sysmodmap
fi

if [[ -f $userresources ]]; then
    xrdb -merge $userresources
fi

if [[ -f $usermodmap ]]; then
    xmodmap $usermodmap
fi

# load system settings
if [[ -d /etc/X11/xinit/xinitrc.d ]]; then
    for file in /etc/X11/xinit/xinitrc.d/?*.sh; do
        [ -x "$file" ] && . "$file"
    done
    unset file
fi

if [[ -f /usr/bin/dunst ]]; then
    dunst -config "$HOME/.config/dunst/dunstrc" &
fi

if [[ "$(echo $TERMINAL)" == "/usr/bin/urxvt" ]]; then
    if [[ -f /usr/bin/urxvt256cd ]]; then
        urxvt256cd -q -o -f &
    elif [[ -f /usr/bin/urxvtd ]]; then
        urxvtd -q -o -f &
    fi
fi

# bell-free
if [[ -f /usr/bin/xset ]]; then
    xset -b
fi

if [[ -f /usr/bin/picom ]]; then
    picom --config "$HOME/.config/picom/config" --daemon
fi

if [[ -f /usr/bin/redshift ]]; then
    redshift &
fi

#if [[ -f /usr/bin/conky ]]; then
#    conky -d -o -c $HOME/.config/conky/qlocktwo.conky
#    conky -d -o -c $HOME/.config/conky/clock
#    conky -d -o -c $HOME/.config/conky/proc
#fi

if [[ $WM = 'sway' ]]; then
    # start sway
    if [[ -f /usr/bin/sway ]]; then
        exec sway -V >> $HOME/.config/sway/sway.log 2>&1
    fi
elif [[ $WM = 'i3' ]]; then
    # start i3
    if [[ -f /usr/bin/i3 ]]; then
        exec i3 -V >> $HOME/.config/i3/i3.log 2>&1
    fi
fi
