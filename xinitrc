IM_MODULE=ibus
export QT_IM_MODULE=ibus
export GTK_IM_MODULE=$IM_MODULE
export TERM=mlterm
export LANG=ja_JP.utf-8
eval `dircolors ~/.dir_colors`
#uim-xim &
ibus-daemon --xim -d
export XMODIFIERS="@im=ibus"

wicd-gtk &
setxkbmap -layout us -model us
xmodmap ~/.Xmodmap
xset b off
sleep 1; xset s 1800

#. ~/.fehbg

xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 8 1
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 8 2

skype &
#(sleep 5 && pidgin) &

#wmclock &
#wmcpu &
#wmbattery &

#uim-toolbar-gtk3-systray &
sleep 5

exec xmonad &
fbpid=$!
{
    xcompmgr &
}
wait $fbpid
