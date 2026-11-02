#!/usr/bin/env bash

set -euo pipefail

wallpaper_dir="${WALLPAPER_DIR:-${HOME}/Pictures/wallpapers}"

if ! command -v hyprctl >/dev/null 2>&1 || ! command -v hyprpaper >/dev/null 2>&1; then
    printf 'Ошибка: нужны hyprctl и hyprpaper.\n' >&2
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

if ! pgrep -x hyprpaper >/dev/null 2>&1; then
    hyprpaper >/dev/null 2>&1 &
fi

wallpaper="${wallpapers[RANDOM % ${#wallpapers[@]}]}"

for _ in {1..20}; do
    hyprctl hyprpaper listloaded >/dev/null 2>&1 && break
    sleep 0.05
done

hyprctl hyprpaper unload all
hyprctl hyprpaper preload "${wallpaper}"
hyprctl hyprpaper wallpaper ",${wallpaper}"
