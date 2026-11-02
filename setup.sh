#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
config_home="${HOME}/.config"
hypr_dir="${HYPRLAND_CONFIG_DIR:-${config_home}/hypr}"
profile="${HYPRLAND_PROFILE:-default}"

usage() {
    cat <<'EOF'
Использование: ./setup.sh [--install|--check|--reload]

  --install  установить зависимости и разложить все конфиги (по умолчанию)
  --check    проверить файлы, команды и установленные конфиги
  --reload   перечитать конфигурацию Hyprland
EOF
}

failures=0
require_command() {
    if command -v "$1" >/dev/null 2>&1; then
        printf '  OK  %s\n' "$1"
    else
        printf '  ERR %s не найден\n' "$1"
        failures=$((failures + 1))
    fi
}

require_file() {
    if [[ -f "$1" ]]; then
        printf '  OK  %s\n' "$1"
    else
        printf '  ERR отсутствует %s\n' "$1"
        failures=$((failures + 1))
    fi
}

check_files() {
    printf '%s\n' 'Проверка файлов:'
    local file
    for file in \
        Hyperland.lua \
        set_wallpaper.sh \
        modules/profile.lua \
        modules/theme.lua \
        modules/autostart.lua \
        config/waybar/config \
        config/waybar/style.css \
        config/wofi/style.css \
        config/kitty/kitty.conf \
        config/kitty/current-theme.conf; do
        require_file "${script_dir}/${file}"
    done

    if command -v luac >/dev/null 2>&1; then
        luac -p "${script_dir}/Hyperland.lua" "${script_dir}"/modules/*.lua
        printf '%s\n' '  OK  Lua-синтаксис'
    else
        printf '%s\n' '  WARN luac не найден, Lua-проверка пропущена'
    fi

    bash -n "${script_dir}/setup.sh" "${script_dir}/install-dependencies.sh" \
        "${script_dir}/set_wallpaper.sh"
    printf '%s\n' '  OK  Bash-синтаксис'

    if command -v python3 >/dev/null 2>&1; then
        python3 - "${script_dir}/config/waybar/config" <<'PY'
import json
import re
import sys
from pathlib import Path

text = Path(sys.argv[1]).read_text(encoding="utf-8")
json.loads(re.sub(r"//[^\n]*", "", text))
PY
        printf '%s\n' '  OK  Waybar JSONC'
    else
        printf '%s\n' '  WARN python3 не найден, Waybar-проверка пропущена'
    fi
}

check_commands() {
    printf '%s\n' 'Проверка команд:'
    for command in bash hyprctl hyprpaper kitty thunar wofi waybar dunst \
        grim slurp swaylock playerctl pavucontrol brightnessctl nvim; do
        require_command "${command}"
    done
}

install_packages() {
    local sudo_cmd=()
    if [[ "${EUID}" -ne 0 ]]; then
        command -v sudo >/dev/null 2>&1 || {
            printf '%s\n' 'Ошибка: нужен root или sudo.' >&2
            return 1
        }
        sudo_cmd=(sudo)
    fi

    if command -v apt-get >/dev/null 2>&1; then
        "${sudo_cmd[@]}" apt-get update
        "${sudo_cmd[@]}" apt-get install -y \
            bash hyprland kitty thunar wofi waybar dunst network-manager-gnome \
            grim slurp hyprpaper swaylock playerctl pavucontrol wireplumber \
            brightnessctl neovim zsh
    elif command -v pacman >/dev/null 2>&1; then
        local packages=(
            bash hyprland kitty thunar wofi waybar dunst
            grim slurp hyprpaper swaylock playerctl pavucontrol wireplumber
            brightnessctl neovim zsh
        )
        if pacman -Si network-manager-applet >/dev/null 2>&1; then
            packages+=(network-manager-applet)
        else
            printf '%s\n' 'Предупреждение: network-manager-applet недоступен, пропускаю.'
        fi
        "${sudo_cmd[@]}" pacman -Sy --needed --noconfirm \
            "${packages[@]}"
    else
        printf '%s\n' 'Ошибка: поддерживаются apt-get и pacman.' >&2
        return 1
    fi
}

install_configs() {
    install -Dm755 "${script_dir}/set_wallpaper.sh" \
        "${hypr_dir}/set_wallpaper.sh"
    install -Dm644 "${script_dir}/Hyperland.lua" \
        "${hypr_dir}/Hyperland.lua"
    for file in profile.lua theme.lua autostart.lua; do
        install -Dm644 "${script_dir}/modules/${file}" \
            "${hypr_dir}/modules/${file}"
    done
    install -Dm644 "${script_dir}/config/waybar/config" \
        "${config_home}/waybar/config"
    install -Dm644 "${script_dir}/config/waybar/style.css" \
        "${config_home}/waybar/style.css"
    install -Dm644 "${script_dir}/config/wofi/style.css" \
        "${config_home}/wofi/style.css"
    install -Dm644 "${script_dir}/config/kitty/kitty.conf" \
        "${config_home}/kitty/kitty.conf"
    install -Dm644 "${script_dir}/config/kitty/current-theme.conf" \
        "${config_home}/kitty/current-theme.conf"
    mkdir -p "${HOME}/Pictures/wallpapers" "${HOME}/Pictures/Screenshots"
}

check_installed_configs() {
    printf '%s\n' 'Проверка установленных конфигов:'
    require_file "${hypr_dir}/Hyperland.lua"
    require_file "${hypr_dir}/set_wallpaper.sh"
    require_file "${hypr_dir}/modules/profile.lua"
    require_file "${hypr_dir}/modules/theme.lua"
    require_file "${hypr_dir}/modules/autostart.lua"
    require_file "${config_home}/waybar/config"
    require_file "${config_home}/waybar/style.css"
    require_file "${config_home}/wofi/style.css"
    require_file "${config_home}/kitty/kitty.conf"
    require_file "${config_home}/kitty/current-theme.conf"
    printf '  INFO профиль: %s\n' "${profile}"
}

check_all() {
    check_files
    check_commands
    check_installed_configs
    if [[ -z "${WAYLAND_DISPLAY:-}" || -z "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]]; then
        printf '%s\n' '  WARN активная сессия Hyprland не обнаружена'
    else
        printf '%s\n' '  OK  активная сессия Hyprland'
    fi
    ((failures == 0)) || {
        printf 'Проверка завершена: ошибок %d.\n' "${failures}" >&2
        return 1
    }
    printf '%s\n' 'Проверка завершена успешно.'
}

mode="${1:---install}"
case "${mode}" in
    --install)
        check_files
        install_packages
        install_configs
        check_installed_configs
        printf '%s\n' 'Установка завершена. Добавьте изображения в ~/Pictures/wallpapers.'
        ;;
    --check)
        check_all
        ;;
    --reload)
        require_command hyprctl
        hyprctl reload
        ;;
    --help|-h)
        usage
        ;;
    *)
        usage >&2
        exit 2
        ;;
esac
