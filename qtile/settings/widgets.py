from libqtile import widget, qtile
from .theme import colors
import os
import subprocess

def base(fg='text', bg='dark'):
    return {
        'foreground': colors[fg],
        'background': colors[bg]
    }

def separator():
    return widget.Sep(**base(), linewidth=0, padding=5)

def icon(fg='text', bg='dark', fontsize=16, text="?"):
    return widget.TextBox(
        **base(fg, bg),
        fontsize=fontsize,
        text=text,
        padding=3
    )

def powerline(fg="light", bg="dark"):
    return widget.TextBox(
        **base(fg, bg),
        text="",
        fontsize=37,
        padding=-2
    )

def workspaces():
    return [
        separator(),
        widget.GroupBox(
            **base(fg='light'),
            font='UbuntuMono Nerd Font',
            fontsize=19,
            margin_y=3,
            margin_x=0,
            padding_y=8,
            padding_x=5,
            borderwidth=1,
            active=colors['active'],
            inactive=colors['inactive'],
            rounded=False,
            highlight_method='block',
            urgent_alert_method='block',
            urgent_border=colors['urgent'],
            this_current_screen_border=colors['focus'],
            this_screen_border=colors['grey'],
            other_current_screen_border=colors['dark'],
            other_screen_border=colors['dark'],
            disable_drag=True
        ),
        separator(),
        widget.WindowName(**base(fg='focus'), fontsize=14, padding=5),
        separator(),
    ]

def audio_output_widget(bg="color5"):
    def get_volume_status():
        try:
            out = subprocess.check_output(["pactl", "get-sink-mute", "@DEFAULT_SINK@"]).decode()
            muted = "yes" in out
            if muted:
                return "🔇 Muted"

            vol = subprocess.check_output(["pactl", "get-sink-volume", "@DEFAULT_SINK@"]).decode()
            percent = int(vol.split("/")[-2].strip().replace('%', ''))
            if percent < 30:
                icon = "🔈"
            elif percent < 70:
                icon = "🔉"
            else:
                icon = "🔊"
            sink = subprocess.check_output(["pactl", "info"]).decode()
            sink_name = next((line.split(":")[1].strip() for line in sink.splitlines() if "Default Sink:" in line), "")
            return f"{icon} {sink_name}"
        except Exception:
            return "🔇 Error"

    return widget.GenPollText(
        **base(bg=bg),
        update_interval=3,
        func=get_volume_status,
        mouse_callbacks={
            "Button1": lambda: qtile.cmd_spawn("~/.config/qtile/scripts/audio_sink_selector.sh")
        },
    )

primary_widgets = [
    *workspaces(),

    separator(),

    powerline('color4', 'dark'),
    icon(bg="color4", text=' '),
    widget.CheckUpdates(
        background=colors['color4'],
        colour_have_updates=colors['text'],
        colour_no_updates=colors['text'],
        no_update_string='0',
        display_format='{updates}',
        update_interval=1800,
        custom_command='checkupdates',
    ),

    powerline('color3', 'color4'),
    icon(bg="color3", text=' '),
    widget.Net(**base(bg='color3')),

    powerline('color6', 'color3'),
    icon(bg="color6", text=' '),
    widget.CPU(**base(bg='color6'), format='{load_percent}%'),

    powerline('color5', 'color6'),
    icon(bg="color5", text=' '),
    widget.Memory(**base(bg='color5'), format='{MemUsed:.0f}{mm} / {MemTotal:.0f}{mm}'),

    powerline('color2', 'color5'),
    icon(bg="color2", text=' '),
    widget.DF(**base(bg='color2'), format='{uf}{m} / {s}', visible_on_warn=False),

    powerline('color1', 'color2'),
    icon(bg="color1", fontsize=17, text=' '),
    widget.Clock(**base(bg='color1'), format='%d/%m/%Y - %H:%M '),

    powerline('color5', 'color1'),
    audio_output_widget(bg='color5'),

    powerline('dark', 'color5'),
    widget.CurrentLayoutIcon(**base(bg='dark'), scale=0.65),
    widget.CurrentLayout(**base(bg='dark'), padding=5),

    widget.Systray(background=colors['dark'], padding=5),
]

secondary_widgets = [
    *workspaces(),

    separator(),

    powerline('color4', 'dark'),
    icon(bg="color4", text=' '),
    widget.CheckUpdates(
        background=colors['color4'],
        colour_have_updates=colors['text'],
        colour_no_updates=colors['text'],
        no_update_string='0',
        display_format='{updates}',
        update_interval=1800,
        custom_command='checkupdates',
    ),

    powerline('color3', 'color4'),
    icon(bg="color3", text=' '),
    widget.Net(**base(bg='color3')),

    powerline('color6', 'color3'),
    icon(bg="color6", text=' '),
    widget.CPU(**base(bg='color6'), format='{load_percent}%'),

    powerline('color5', 'color6'),
    icon(bg="color5", text=' '),
    widget.Memory(**base(bg='color5'), format='{MemUsed:.0f}{mm} / {MemTotal:.0f}{mm}'),

    powerline('color2', 'color5'),
    icon(bg="color2", text=' '),
    widget.DF(**base(bg='color2'), format='{uf}{m} / {s}', visible_on_warn=False),

    powerline('color1', 'color2'),
    icon(bg="color1", fontsize=17, text=' '),
    widget.Clock(**base(bg='color1'), format='%d/%m/%Y - %H:%M '),

    powerline('color5', 'color1'),
    audio_output_widget(bg='color5'),

    powerline('dark', 'color5'),
    widget.CurrentLayoutIcon(**base(bg='dark'), scale=0.65),
    widget.CurrentLayout(**base(bg='dark'), padding=5),
]

widget_defaults = {
    'font': 'UbuntuMono Nerd Font Bold',
    'fontsize': 14,
    'padding': 1,
}
extension_defaults = widget_defaults.copy()
