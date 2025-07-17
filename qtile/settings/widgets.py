
import subprocess
from libqtile import widget, lazy
from .theme import colors
import os

def get_volume():
    try:
        output = subprocess.check_output("amixer get Master", shell=True).decode()
        for line in output.splitlines():
            if "%" in line:
                percent = line.split("[")[1].split("%")[0]
                muted = "off" in line
                icon = "🔇" if muted else "🔊"
                return f"{icon} {percent}%"
    except Exception:
        return "🔊 ??"

volume_widget = widget.GenPollText(
    update_interval=2,
    func=get_volume,
    markup=False,
    fontsize=14,             # mismo tamaño que los demás
    lineheight=1.1,          # ajuste vertical fino
    padding=6,               # alineación horizontal
    padding_y=4,             # centrado vertical
    foreground=colors["pink"],
    background=colors["background"],
    mouse_callbacks={
        "Button1": lambda: subprocess.Popen(["pavucontrol"]),
        "Button4": lambda: subprocess.Popen(["amixer", "-q", "set", "Master", "5%+"]),
        "Button5": lambda: subprocess.Popen(["amixer", "-q", "set", "Master", "5%-"]),
    }
)

def base(fg='foreground', bg='background'):
    return {
        'foreground': colors[fg],
        'background': colors[bg]
    }

def separator():
    return widget.Sep(**base(), linewidth=0, padding=6)

def icon(fg='foreground', bg='background', fontsize=17, text="?"):
    return widget.TextBox(
        **base(fg, bg),
        fontsize=fontsize,
        text=text,
        padding=3
    )

def workspaces():
    return [
        widget.GroupBox(
            **base(fg='green2', bg='background'),
            font='Caskaydia Cove Nerd Font',
            fontsize=18,
            margin_y=3,
            margin_x=0,
            padding_y=8,
            padding_x=6,
            borderwidth=1,
            active=colors['red'],
            inactive=colors['green2'],
            rounded=False,
            highlight_method='block',
            urgent_alert_method='block',
            urgent_border=colors['red'],
            this_current_screen_border=colors['comment'],
            this_screen_border=colors['red'],
            disable_drag=True,
        ),
    ]

primary_widgets = [
    *workspaces(),
    widget.Spacer(),
    icon(text="", fg='cyan'),
    widget.CPU(format="{load_percent}%", **base(fg='cyan')),
    icon(text="", fg='yellow'),
    widget.Memory(format="{MemUsed:.0f}{mm}", measure_mem='G', **base(fg='yellow')),
    icon(text="", fg='orange'),
    widget.Net(format="{down}↓↑{up}", **base(fg='orange')),
    icon(text="", fg='red'),
    widget.ThermalSensor(tag_sensor="Package id 0", format="{temp}°C", **base(fg='red')),
    volume_widget,
    icon(text="󰘬", fg='purple'),
    widget.CurrentLayoutIcon(scale=0.6, **base(fg='purple')),
    widget.CurrentLayout(padding=5, **base(fg='purple')),
    icon(text="", fg='green2'),
    widget.Clock(format="%d/%m %H:%M", **base(fg='green')),
    widget.Systray(padding=5),
]

secondary_widgets = [
    *workspaces(),
    widget.Spacer(),
    icon(text="󰘬", fg='purple'),
    widget.CurrentLayoutIcon(scale=0.6, **base(fg='purple')),
    widget.CurrentLayout(padding=4, **base(fg='purple')),
    icon(text="", fg='green'),
    widget.Clock(format="%d/%m %H:%M", **base(fg='green')),
]

widget_defaults = {
    'font': 'Caskaydia Cove Nerd Font Bold',
    'fontsize': 14,
    'padding': 1,
}
extension_defaults = widget_defaults.copy()
