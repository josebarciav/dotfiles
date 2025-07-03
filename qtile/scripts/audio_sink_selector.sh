#!/bin/bash

# Obtener lista de sinks con descripción
choices=$(pactl list short sinks | cut -f2)

# Mostrar en rofi y guardar la elección
selected=$(echo "$choices" | rofi -dmenu -p "Seleccionar salida de audio")

# Si seleccionó algo, establecerlo como predeterminado
if [ -n "$selected" ]; then
    pactl set-default-sink "$selected"
    # Mover los streams activos al nuevo sink
    for input in $(pactl list short sink-inputs | cut -f1); do
        pactl move-sink-input "$input" "$selected"
    done
fi
