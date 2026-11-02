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
        grim slurp hyprpaper swaylock playerctl wireplumber brightnessctl neovim zsh
elif command -v pacman >/dev/null 2>&1; then
    "${SUDO[@]}" pacman -Sy --needed --noconfirm \
        hyprland kitty thunar wofi waybar dunst networkmanager-applet \
        grim slurp hyprpaper swaylock playerctl wireplumber brightnessctl neovim zsh
else
    echo "Ошибка: поддерживаются только Debian/Ubuntu (apt) и Arch Linux (pacman)." >&2
    exit 1
fi

install -Dm755 set_wallpaper.sh "${HOME}/.config/hypr/set_wallpaper.sh"
echo "Зависимости успешно установлены."
