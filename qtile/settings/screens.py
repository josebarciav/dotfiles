
from libqtile.config import Screen
from libqtile import bar
from .widgets import primary_widgets, secondary_widgets
from .theme import colors

def status_bar(widgets):
    return bar.Bar(
        widgets,
        26,
        opacity=1.0,
        background=colors['background'],  # fondo uniforme
    )

import subprocess

def count_monitors():
    try:
        output = subprocess.check_output("xrandr --query | grep ' connected'", shell=True)
        return len(output.decode().splitlines())
    except Exception:
        return 1

monitors = count_monitors()

if monitors >= 2:
    screens = [
        Screen(top=status_bar(secondary_widgets)),
        Screen(top=status_bar(primary_widgets))
    ]
else:
    screens = [
        Screen(top=status_bar(primary_widgets))
    ]
