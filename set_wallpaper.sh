#!/usr/bin/env bash

set -euo pipefail

wallpaper_dir="${WALLPAPER_DIR:-${HOME}/Pictures/wallpapers}"
state_dir="${XDG_RUNTIME_DIR:-/tmp}"
pid_file="${state_dir}/config-hyprland-swaybg.pid"

if ! command -v swaybg >/dev/null 2>&1; then
    printf 'Ошибка: swaybg не установлен.\n' >&2
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

if [[ -s "${pid_file}" ]]; then
    old_pid="$(<"${pid_file}")"
    if [[ "${old_pid}" =~ ^[0-9]+$ ]] && kill -0 "${old_pid}" 2>/dev/null; then
        kill "${old_pid}"
        for _ in {1..20}; do
            kill -0 "${old_pid}" 2>/dev/null || break
            sleep 0.05
        done
    fi
fi

wallpaper="${wallpapers[RANDOM % ${#wallpapers[@]}]}"
swaybg -m fill -i "${wallpaper}" &
printf '%s\n' "$!" > "${pid_file}"
