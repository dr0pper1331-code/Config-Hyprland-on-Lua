#!/usr/bin/env bash

set -euo pipefail

if [[ "${EUID}" -eq 0 ]]; then
    SUDO=()
elif command -v sudo >/dev/null 2>&1; then
    SUDO=(sudo)
else
    echo "Ошибка: для установки нужен root или sudo." >&2
    exit 1
fi

if command -v apt-get >/dev/null 2>&1; then
    "${SUDO[@]}" apt-get update
    "${SUDO[@]}" apt-get install -y \
        hyprland kitty thunar wofi waybar dunst network-manager-gnome \
        grim slurp swaylock playerctl wireplumber brightnessctl neovim
elif command -v pacman >/dev/null 2>&1; then
    "${SUDO[@]}" pacman -Sy --needed --noconfirm \
        hyprland kitty thunar wofi waybar dunst networkmanager-applet \
        grim slurp swaylock playerctl wireplumber brightnessctl neovim
else
    echo "Ошибка: поддерживаются только Debian/Ubuntu (apt) и Arch Linux (pacman)." >&2
    exit 1
fi

echo "Зависимости успешно установлены."
