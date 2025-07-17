# Qtile keybindings
import subprocess
import os
from libqtile.config import Key

#from libqtile.command import lazy
from libqtile.lazy import lazy
from libqtile.log_utils import logger

mod = "mod4"
home=os.path.expanduser('~')
# terminal="kitty"
terminal="wezterm"
#keys = [Key(key[0], key[1], *key[2:]) for key in [
keys = [
    # ------------ Window Configs ------------

    # Switch between windows in current stack pane
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "Up", lazy.layout.up()),
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "Right", lazy.layout.right()),
    Key([mod], "e", lazy.layout.normalize(), desc="Normalize"),
    Key([mod], "n", lazy.layout.maximize(), desc="Maximize"),

    # Change window sizes (MonadTall)
    # Key([mod, "shift"], "l", lazy.layout.grow_right()),
    # Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    # Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    # Key([mod, "shift"], "h", lazy.layout.shrink()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
    Key([mod, "control"], "j", lazy.layout.grow_down()),
    Key([mod, "control"], "k", lazy.layout.grow_up()),
    Key([mod, "control"], "h", lazy.layout.grow_left()),
    Key([mod, "control"], "l", lazy.layout.grow_right()),

    # Toggle floating
    Key([mod, "shift"], "z", lazy.window.toggle_floating()),

    # Move windows up or down in current stack
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod, "shift"], "Tab", lazy.prev_layout()),

    # Kill window
    Key([mod], "w", lazy.window.kill()),

    # Switch focus of monitors
    Key([mod], "period", lazy.next_screen()),
    Key([mod], "comma", lazy.prev_screen()),

    # Restart Qtile
    Key([mod, "control"], "r", lazy.restart()),

    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod], "r", lazy.spawncmd()),

    # ------------ App Configs ------------

    # Menu
    Key([mod], "m", lazy.spawn("rofi -show drun")),

    # Window Nav
    Key([mod, "shift"], "m", lazy.spawn("rofi -show")),
    Key([mod, "shift"], "e", lazy.spawn("rofi -show emoji")),

    # Browser
    Key([mod, "shift"], "b", lazy.spawn("brave")),

    # File Explorer
    Key([mod,"shift"], "f", lazy.spawn("thunar")),

    # Terminal
    Key([mod], "Return", lazy.spawn(terminal)),

    # Screenshot
    #Key([mod], "s", lazy.spawn("scrot")),
    Key([mod, "shift"], "s", lazy.spawn("flameshot gui")),

    # Screenshot
    Key([mod], "v", lazy.spawn("copyq menu")),
    # ------------ Hardware Configs ------------

    # Volume
    Key([], "XF86AudioLowerVolume", lazy.spawn(
       "pactl set-sink-volume @DEFAULT_SINK@ -5%"
   )),
   Key([], "XF86AudioRaiseVolume", lazy.spawn(
       "pactl set-sink-volume @DEFAULT_SINK@ +5%"
   )),
   Key([], "XF86AudioMute", lazy.spawn(
       "pactl set-sink-mute @DEFAULT_SINK@ toggle"
   )),

    # Brightness
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +10%")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 10%-")),
]
