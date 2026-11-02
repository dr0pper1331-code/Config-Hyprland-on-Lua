local home = assert(os.getenv("HOME"), "Переменная HOME не задана")
local config_dir = os.getenv("HYPRLAND_CONFIG_DIR") or home .. "/.config/hypr"
local profile = dofile(config_dir .. "/modules/profile.lua")
local theme = dofile(config_dir .. "/modules/theme.lua")
local start_services = dofile(config_dir .. "/modules/autostart.lua")

----------------
-- МОНИТОРЫ   --
----------------

-- Настройка монитора: https://wiki.hypr.land/configuring/core/monitors/
-- Можно задать имя конкретного монитора через HYPRLAND_MONITOR.
hl.monitor({
    output   = profile.monitor,
    mode     = "preferred",
    position = "auto",
    scale    = profile.monitor_scale,
})


-----------------------
-- ПРИЛОЖЕНИЯ         --
-----------------------

-- Программы, запускаемые горячими клавишами.
local terminal    = profile.terminal
local fileManager = profile.file_manager
local menu        = profile.menu

-----------------------------------
-- АВТОЗАПУСК СИСТЕМНЫХ СЕРВИСОВ --
-----------------------------------
-- Команды выполняются при каждом чтении конфигурации.

start_services(home, config_dir)


--------------------------------
-- ПЕРЕМЕННЫЕ ОКРУЖЕНИЯ        --
--------------------------------

-- Документация: https://wiki.hypr.land/configuring/core/environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")


------------------------
-- РАЗРЕШЕНИЯ         --
------------------------

-- Документация: https://wiki.hypr.land/configuring/core/advanced-configuration/permissions/
-- Изменения требуют перезапуска hyprland и не применяются во время работы.

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
-- ВНЕШНИЙ ВИД        --
-----------------------

hl.config({
    general = {
        gaps_in     = 8,  -- Внутренние отступы.
        gaps_out    = 8,  -- Внешние отступы.
        border_size = 2,  -- Толщина границы.

        col = {
            active_border   = {
                colors = { theme.active_border, theme.accent },
                angle = 45,
            },
            inactive_border = theme.inactive_border,
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 10,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
        },
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.17,
            special = true,
        },
        dim_special = 0.4,
        glow = {
            enabled = true,
            range = 10,
            render_power = 3,
            color = {
                colors = { theme.active_border, theme.accent },
                angle = 45,
            },
            color_inactive = "rgba(00000000)",
        },
    }
})
-- Кривые и анимации: https://wiki.hypr.land/configuring/core/animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Пружинная анимация для окон.
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 238.1191, damping = 24.21279333 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })


hl.config({
    dwindle = {
        preserve_split = true, -- Сохранять направление разделения окон.
    },
})

-- Раскладка Master: https://wiki.hypr.land/configuring/layouts/master-layout/
hl.config({
    master = {
        new_status = "master",
    },
})

-- Прокручиваемая раскладка: https://wiki.hypr.land/configuring/layouts/scrolling-layout/
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

----------------
-- РАЗНОЕ      --
----------------

hl.config({
    misc = {
        force_default_wallpaper = -1,   -- Не показывать встроенные обои hyprland.
        disable_hyprland_logo   = true, -- Не показывать логотип на фоне запуска.
        disable_splash_rendering = true,
    },
})
hl.workspace_rule({ workspace = "s[true]", gaps_out = 30 })


----------------
-- СЛОИ         --
----------------

hl.config({
    layers = {
        allow_new_top_layers_over_existing_fullscreen = true, -- Новые верхние слои отображаются поверх полноэкранных окон.
    },
})


----------------
-- ВВОД         --
----------------

hl.config({
    input = {
        -- Раскладки US/RU с переключением по Alt+Shift.
        kb_layout   = "us,ru",
        kb_options  = "grp:alt_shift_toggle",
        
        follow_mouse = 1,
        numlock_by_default = profile.numlock,
        touchpad = {
            natural_scroll = profile.natural_scroll,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})


hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


-----------------------
-- ГОРЯЧИЕ КЛАВИШИ    --
-----------------------

-----------------------------
-- ГРУППЫ ГОРЯЧИХ КЛАВИШ --
-----------------------------

-- Запуск приложений.
hl.bind("SUPER+X", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER+R", hl.dsp.exec_cmd(menu))
hl.bind("SUPER+SHIFT+E", hl.dsp.exec_cmd(fileManager))
hl.bind("SUPER+B", hl.dsp.exec_cmd("xdg-open 'https://'"))
hl.bind("SUPER+N", hl.dsp.exec_cmd("kitty -e nvim"))
hl.bind("SUPER+F1", hl.dsp.exec_cmd(profile.quick_apps[1]))
hl.bind("SUPER+F2", hl.dsp.exec_cmd(profile.quick_apps[2]))
hl.bind("SUPER+F3", hl.dsp.exec_cmd(profile.quick_apps[3]))
hl.bind("SUPER+F4", hl.dsp.exec_cmd(profile.quick_apps[4]))

-- Блокировка экрана и смена обоев.
hl.bind("SUPER+U", hl.dsp.exec_cmd("swaylock -f -i " .. home .. "/Pictures/wallpapers/bg.png"))
hl.bind("SUPER+SHIFT+W", hl.dsp.exec_cmd("bash " .. config_dir .. "/set_wallpaper.sh"))

-- Снимки экрана: полный экран и выбранная область.
hl.bind("SUPER+SHIFT+P", hl.dsp.exec_cmd('grim -g "$(slurp)" ' .. home .. '/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%m-%s).png'))
hl.bind("SUPER+P", hl.dsp.exec_cmd('grim ' .. home .. '/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%m-%s).png'))

-- Закрыть активное окно.
hl.bind("SUPER+Q", hl.dsp.window.close())

-- Перемещение фокуса клавишами Vim.
hl.bind("SUPER+J", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER+K", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER+L", hl.dsp.focus({ direction = "up" }))


-- Перемещение фокуса стрелками.
hl.bind("SUPER+left",  hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER+down",  hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER+up",    hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER+right", hl.dsp.focus({ direction = "right" }))

-- Перемещение окон клавишами Vim.
hl.bind("SUPER+SHIFT+J", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER+SHIFT+K", hl.dsp.window.move({ direction = "down" }))
hl.bind("SUPER+SHIFT+L", hl.dsp.window.move({ direction = "up" }))


-- Перемещение окон стрелками.
hl.bind("SUPER+SHIFT+left",  hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER+SHIFT+down",  hl.dsp.window.move({ direction = "down" }))
hl.bind("SUPER+SHIFT+up",    hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER+SHIFT+right", hl.dsp.window.move({ direction = "right" }))

-- Навигация между существующими рабочими пространствами.
hl.bind("SUPER+mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER+mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER+CTRL+left", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER+CTRL+right", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER+CTRL+SHIFT+left", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind("SUPER+CTRL+SHIFT+right", hl.dsp.window.move({ workspace = "e+1" }))




---------------------------------------
-- РАБОЧИЕ ПРОСТРАНСТВА: 1–10         --
---------------------------------------

for i = 1, 10 do
    -- Для рабочего пространства 10 используется клавиша 0.
    local key = tostring(i % 10)
    
    -- Super + [1-0]: перейти в рабочее пространство.
    hl.bind("SUPER+" .. key, hl.dsp.focus({ workspace = i }))
    
    -- Super + Shift + [1-0]: переместить окно в рабочее пространство.
    hl.bind("SUPER+SHIFT+" .. key, hl.dsp.window.move({ workspace = i }))
end





-- Управление раскладкой окон.
hl.bind("SUPER+H", hl.dsp.layout("preselect l")) 
hl.bind("SUPER+V", hl.dsp.layout("preselect d")) 
hl.bind("SUPER+F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind("SUPER+SHIFT+space", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER+O", hl.dsp.window.pseudo())
hl.bind("SUPER+S", hl.dsp.exec_cmd("hyprctl dispatch togglespecialworkspace magic"))
hl.bind("SUPER+SHIFT+S", hl.dsp.exec_cmd("hyprctl dispatch movetoworkspace special:magic"))


-- Управление громкостью.
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 2%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"))
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

-- Управление медиаплеером.
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

-- Управление яркостью.
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s +1%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 1%-"))
hl.bind("SUPER+SHIFT+B", hl.dsp.exec_cmd("brightnessctl s +5%"))
hl.bind("SUPER+SHIFT+T", hl.dsp.exec_cmd("brightnessctl s 5%-"))



--------------------------------
-- ПРАВИЛА ОКОН               --
--------------------------------


local suppressMaximizeRule = hl.window_rule({
    -- Игнорировать запросы разворачивания от всех приложений.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Исправить проблемы перетаскивания окон XWayland.
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})
