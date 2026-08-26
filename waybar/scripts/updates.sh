#!/bin/bash

# Testa internet
if ! curl -s --max-time 3 https://archlinux.org >/dev/null; then
    echo '{"text": "", "tooltip": "Offline :(", "class": "offline"}'
    exit 0
fi

# Verifica updates do pacman + AUR (se tiver yay/paru)
PACMAN_UPDATES=$(checkupdates 2>/dev/null | wc -l)

AUR_UPDATES=$(yay -Qua 2>/dev/null | wc -l)

TOTAL=$((PACMAN_UPDATES + AUR_UPDATES))

if [ "$TOTAL" -gt 15 ]; then
    echo "{\"text\": \" $TOTAL\", \"tooltip\": \"Pacman: $PACMAN_UPDATES  AUR: $AUR_UPDATES\", \"class\": \"outdated\"}"
else
    echo "{\"text\": \" $TOTAL\", \"tooltip\": \"Pacman: $PACMAN_UPDATES  AUR: $AUR_UPDATES\", \"class\": \"updated\"}"
fi
