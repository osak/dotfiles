IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export GTK_IM_MODULE=$IM_MODULE
export TERM=urxvt
export LANG=en_US.UTF8
eval `dircolors ~/.dir_colors`
#uim-xim &
ibus-daemon --xim -d
export XMODIFIERS="@im=fcitx"

wicd-gtk &
setxkbmap -layout us -model us
xmodmap ~/.Xmodmap
xset b off
sleep 1; xset s 1800

#. ~/.fehbg

xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 8 1
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 8 2

#(sleep 5 && pidgin) &

#wmclock &
#wmcpu &
#wmbattery &

#uim-toolbar-gtk3-systray &
sleep 5

exec xmonad &
sakura &
fbpid=$!
{
    xcompmgr &
}
wait $fbpid
