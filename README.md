# Config-Hyprland-on-Lua
Nord style Hyprland on Lua
work doed google ai and work
# Config-Hyprland-on-Lua

Моя конфигурация [Hyprland](https://hyprland.org/) на Lua в стиле Nord.

## Возможности

- Nord-тема с прозрачностью, скруглениями и анимациями
- Раскладки клавиатуры `us,ru`
- Автозапуск Waybar, Dunst и NetworkManager Applet
- Горячие клавиши для запуска приложений
- Скриншоты через Grim и Slurp
- Управление громкостью, яркостью и медиаплеером
- Жесты тачпада и переключение рабочих пространств

## Зависимости

Необходимы:

- Hyprland с поддержкой Lua-конфигурации
- Kitty
- Thunar
- Wofi
- Waybar
- Dunst
- NetworkManager Applet
- Grim и Slurp
- Swaylock
- Playerctl
- WirePlumber (`wpctl`)
- Brightnessctl или Light
- Neovim

## Установка

1. Склонируйте репозиторий:

   ```bash
   git clone https://github.com/dr0pper1331-code/Config-Hyprland-on-Lua.git
   cd Config-Hyprland-on-Lua
   Сначала посмотрю текущий README и структуру проекта, чтобы предложить текст, соответствующий конфигурации.

"Read" failed
Completed with input: {
  "path": "/home/codespace/.vscode-remote/data/agentSessionData/7b96ad5b-d29b-49ff-a449-14acad-14ac449b56775/attachments/1c4b3e29-e07a-460d-987a-2f571a695b49/file_README.md"
}
Tool execution failed: Path does not exist

Find files matching `*`

Find files matching `**/*`

Read 
Completed with input: {
  "path": "/workspaces/Config-Hyprland-on-Lua/README.md"
}

Read 
Completed with input: {
  "path": "/workspaces/Config-Hyprland-on-Lua/Hyperland.lua"
}

Read , lines 1 to 220
Completed with input: {
  "path": "/workspaces/Config-Hyprland-on-Lua/Hyperland.lua",
  "view_range": [
    1,
    220
  ]
}

Search for `hl\.bind|hl\.exec|waybar|wofi|kitty|Thunar|dunst|nm-applet|set_wallpaper|scre...`

Search for `^#|https?://|install|config|lua`

В `README.md` можно вписать описание, установку и зависимости:

```markdown
# Config-Hyprland-on-Lua

Моя конфигурация [Hyprland](https://hyprland.org/) на Lua в стиле Nord.

## Возможности

- Nord-тема с прозрачностью, скруглениями и анимациями
- Раскладки клавиатуры `us,ru`
- Автозапуск Waybar, Dunst и NetworkManager Applet
- Горячие клавиши для запуска приложений
- Скриншоты через Grim и Slurp
- Управление громкостью, яркостью и медиаплеером
- Жесты тачпада и переключение рабочих пространств

## Зависимости

Необходимы:

- Hyprland с поддержкой Lua-конфигурации
- Kitty
- Thunar
- Wofi
- Waybar
- Dunst
- NetworkManager Applet
- Grim и Slurp
- Swaylock
- Playerctl
- WirePlumber (`wpctl`)
- Brightnessctl или Light
- Neovim

## Установка

1. Склонируйте репозиторий:

   ```bash
   git clone https://github.com/dr0pper1331-code/Config-Hyprland-on-Lua.git
   cd Config-Hyprland-on-Lua
   ```

2. Скопируйте конфигурацию в каталог конфигурации Hyprland/Lua.

3. Проверьте и измените в `Hyperland.lua`:

   - имя монитора;
   - используемый терминал;
   - файловый менеджер;
   - меню приложений;
   - путь к скрипту обоев;
   - путь к изображению для Swaylock.

4. Перезапустите Hyprland.

## Основные горячие клавиши

| Комбинация | Действие |
|---|---|
| `Super + X` | Открыть терминал |
| `Super + R` | Открыть меню приложений |
| `Super + Shift + E` | Открыть файловый менеджер |
| `Super + Q` | Закрыть окно |
| `Super + F` | Полноэкранный режим |
| `Super + Shift + Space` | Переключить плавающее окно |
| `Super + P` | Сделать скриншот экрана |
| `Super + Shift + P` | Сделать скриншот выбранной области |
| `Super + U` | Заблокировать экран |
| `Super + 1..0` | Переключить рабочее пространство |

## Примечание

Конфигурация рассчитана на Wayland и требует адаптации путей и названий устройств под конкретную систему.
```

Также стоит переименовать `Hyperland.lua` в `Hyprland.lua`, чтобы название соответствовало Hyprland.