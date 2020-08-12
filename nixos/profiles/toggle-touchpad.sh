
# Detect device id of the touchpad
tid=$(xinput list | grep -i touchpad | grep -o id=[0-9]* | grep -o [0-9]*)
# Detect state of the touchpad (1: Enabled, 0: Disabled)
tstate=$(xinput list-props $tid | grep -i enabled | grep -o [0-1]$)

# Conditionally disable/enable touchpad and display notification
if [ $tstate == "1" ]; then
  notify-send "Toggle touchpad: On -> Off" -t 1000
  xinput --disable $tid
elif [ $tstate == "0" ]; then
  notify-send "Toggle touchpad: Off -> On" -t 1000
  xinput --enable $tid
fi

