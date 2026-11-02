#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

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
        grim slurp hyprpaper swaylock playerctl pavucontrol wireplumber brightnessctl neovim zsh
elif command -v pacman >/dev/null 2>&1; then
    "${SUDO[@]}" pacman -Sy --needed --noconfirm \
        hyprland kitty thunar wofi waybar dunst networkmanager-applet \
        grim slurp hyprpaper swaylock playerctl pavucontrol wireplumber brightnessctl neovim zsh
else
    echo "Ошибка: поддерживаются только Debian/Ubuntu (apt) и Arch Linux (pacman)." >&2
    exit 1
fi

install -Dm755 "${script_dir}/set_wallpaper.sh" "${HOME}/.config/hypr/set_wallpaper.sh"
install -Dm644 "${script_dir}/Hyperland.lua" "${HOME}/.config/hypr/Hyperland.lua"
install -Dm644 "${script_dir}/modules/profile.lua" "${HOME}/.config/hypr/modules/profile.lua"
install -Dm644 "${script_dir}/modules/theme.lua" "${HOME}/.config/hypr/modules/theme.lua"
install -Dm644 "${script_dir}/modules/autostart.lua" "${HOME}/.config/hypr/modules/autostart.lua"
install -Dm644 "${script_dir}/config/waybar/config" "${HOME}/.config/waybar/config"
install -Dm644 "${script_dir}/config/waybar/style.css" "${HOME}/.config/waybar/style.css"
install -Dm644 "${script_dir}/config/wofi/style.css" "${HOME}/.config/wofi/style.css"
install -Dm644 "${script_dir}/config/kitty/kitty.conf" "${HOME}/.config/kitty/kitty.conf"
install -Dm644 "${script_dir}/config/kitty/current-theme.conf" "${HOME}/.config/kitty/current-theme.conf"
echo "Зависимости успешно установлены."
