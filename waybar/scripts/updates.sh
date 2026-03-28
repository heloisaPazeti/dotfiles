#!/bin/bash

CACHE_FILE="/tmp/waybar_updates.cache"

# Se o cache tem menos de 1 hora, usa ele
if [ -f "$CACHE_FILE" ] && [ $(( $(date +%s) - $(date +%s -r "$CACHE_FILE") )) -lt 3600 ]; then
    cat "$CACHE_FILE"
    exit 0
fi

# Busca os updates
PACMAN_UPDATES=$(checkupdates 2>/dev/null | wc -l)
AUR_UPDATES=$(yay -Qua 2>/dev/null | wc -l)

TOTAL=$((PACMAN_UPDATES + AUR_UPDATES))

if [ "$TOTAL" -eq 0 ]; then
    OUTPUT='{"text": " 0", "tooltip": "Sistema atualizado!", "class": "updated"}'
else
    OUTPUT="{\"text\": \" $TOTAL\", \"tooltip\": \"Pacman: $PACMAN_UPDATES | AUR: $AUR_UPDATES\", \"class\": \"outdated\"}"
fi

# Salva no cache e exibe
echo "$OUTPUT" | tee "$CACHE_FILE"
