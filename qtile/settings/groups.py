
from libqtile.config import Key, Group
from libqtile.lazy import lazy
from .keys import mod, keys

icons = [
    "  ",
    " ",
    "  ",
    "  ",
    "  ",
    "  ",
    "  ",
    "  ",
    "   "
]

groups = [Group(icon) for icon in icons]

for i, group in enumerate(groups):
    key = str(i + 1)
    keys.extend([
        Key([mod], key, lazy.group[group.name].toscreen()),
        Key([mod, "shift"], key, lazy.window.togroup(group.name))
    ])
