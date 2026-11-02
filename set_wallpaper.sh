#!/usr/bin/env bash

set -euo pipefail

wallpaper_dir="${WALLPAPER_DIR:-${HOME}/Pictures/wallpapers}"

if [[ -z "${WAYLAND_DISPLAY:-}" || -z "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]]; then
    printf 'Ошибка: скрипт нужно запускать внутри активной сессии Hyprland.\n' >&2
    exit 1
fi

if ! command -v hyprctl >/dev/null 2>&1 || ! command -v hyprpaper >/dev/null 2>&1; then
    printf 'Ошибка: установите hyprctl и hyprpaper.\n' >&2
    exit 1
fi

mapfile -d '' wallpapers < <(
    find "${wallpaper_dir}" -maxdepth 1 -type f \
        \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) \
        -print0
)

if ((${#wallpapers[@]} == 0)); then
    printf 'Ошибка: в каталоге %s нет изображений.\n' "${wallpaper_dir}" >&2
    exit 1
fi

if ! hyprctl hyprpaper listloaded >/dev/null 2>&1; then
    hyprpaper >/tmp/hyprpaper.log 2>&1 &
fi

wallpaper="${wallpapers[RANDOM % ${#wallpapers[@]}]}"

for _ in {1..20}; do
    if hyprctl hyprpaper listloaded >/dev/null 2>&1; then
        break
    fi
    sleep 0.05
done

if ! hyprctl hyprpaper listloaded >/dev/null 2>&1; then
    printf 'Ошибка: hyprpaper не отвечает.\n' >&2
    [[ -s /tmp/hyprpaper.log ]] && cat /tmp/hyprpaper.log >&2
    exit 1
fi

if ! hyprctl hyprpaper wallpaper ",${wallpaper},cover"; then
    printf 'Ошибка: Hyprpaper не применил файл %s.\n' "${wallpaper}" >&2
    exit 1
fi
