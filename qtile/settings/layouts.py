from libqtile import layout
from libqtile.config import Match
from .theme import colors

# Layouts and layout rules


layout_conf = {
    'border_focus': colors['focus'],       # Borde ventana activa
    'border_normal': colors['background'], # Borde ventana inactiva
    'border_width': 2,
    'margin': 8
}

layouts = [
    layout.Max(),
    layout.MonadTall(**layout_conf),
    layout.MonadWide(**layout_conf),
    layout.MonadThreeCol(**layout_conf),

    layout.Bsp(**layout_conf),
    layout.Matrix(columns=2, **layout_conf),
#    layout.RatioTile(**layout_conf),
#    layout.Columns(),
#    layout.Tile(),
#    layout.TreeTab(),
#    layout.VerticalTile(),
#    layout.Zoomy(),
]

floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class='confirmreset'),
        Match(wm_class='makebranch'),
        Match(wm_class='maketag'),
        Match(wm_class='ssh-askpass'),
        Match(title='branchdialog'),
        Match(title='pinentry'),
    ],
    #    border_focus=colors["color4"][0]
)