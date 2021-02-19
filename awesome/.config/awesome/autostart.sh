# /bin/bash/

# All commands that need to start when the system boots up

redshift -c $HOME/.config/redshift.conf
picom --config  $HOME/.config/picom.conf
nm-applet
eval "$(ssh-agent -s)"
ssh-add s
nitrogen --restore
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
volumeicon