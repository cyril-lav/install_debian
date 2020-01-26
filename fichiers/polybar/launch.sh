# Basic script to kill all old bars and launch new.

# Terminate already running bad instances
killall -q polybar

# Wait until the processes have been shut down
while grep -x polybar >/dev/null; do sleep 1; done

# Multiple screens adaptive
#for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#    MONITOR=$m polybar main_bar &
#done

MONITOR=eDP-1 polybar main_bar &
MONITOR=DP-1 polybar main_bar &
