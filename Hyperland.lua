------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/configuring/core/monitors/
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})


---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "kitty"
local fileManager = "Thunar"
local menu        = "wofi"

--------------------------------------------------------------
---- НАДЕЖНЫЙ АВТОЗАПУСК (Напрямую) ----
--------------------------------------------------------------
-- Эти команды будут вызываться гарантированно при каждом парсинге файла

hl.exec_cmd("mkdir -p " .. os.getenv("HOME") .. "/Pictures/Screenshots")
hl.exec_cmd("dunst")
hl.exec_cmd("nm-applet --indicator")

-- Панель перезапускается одной командой
hl.exec_cmd("killall waybar; waybar")

-- Скрипт обоев
hl.exec_cmd("sh " .. os.getenv("HOME") .. "/.config/sway/set_wallpaper.sh")


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/configuring/core/environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")


-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/configuring/core/advanced-configuration/permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in     = 8,  -- gaps inner 8
        gaps_out    = 8,  -- gaps outer 7
        border_size = 2,  -- border pixel 2

        col = {
            active_border   = "rgba(81a1c1ff)",
            inactive_border = "rgba(2e3440ff)",
        },
        layout = "dwindle",
    },

    decoration = {
        rounding = 4, -- Небольшое скругление для темы Nord

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true, -- Выключено для классического плоского вида i3/Sway
        },
        blur = {
            enabled = true,
        }
    }
})
-- Default curves and animations, see https://wiki.hypr.land/configuring/core/animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default springs
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
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/configuring/layouts/master-layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- See https://wiki.hypr.land/configuring/layouts/scrolling-layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
    },
})


----------------
---- LAYERS ----
----------------

hl.config({
    layers = {
        allow_new_top_layers_over_existing_fullscreen = true, -- Set to false to make newly mapped top layers render below existing covering fullscreen window
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        -- xkb_layout "us,ru" и grp:alt_shift_toggle
        kb_layout   = "us,ru",
        kb_options  = "grp:alt_shift_toggle",
        
        follow_mouse = 1,
        touchpad = {
            natural_scroll = false,
        },
    },
})hl.config({
    input = {
        -- xkb_layout "us,ru" и grp:alt_shift_toggle
        kb_layout   = "us,ru",
        kb_options  = "grp:alt_shift_toggle",
        
        follow_mouse = 1,
        touchpad = {
            natural_scroll = false,
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


---------------------
---- KEYBINDINGS ----
---------------------

--------------------------------------------------------------
---- ГОРЯЧИЕ КЛАВИШИ (Binds) ----
--------------------------------------------------------------

-- Запуск программ (Launchers)
hl.bind("SUPER+X", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER+R", hl.dsp.exec_cmd(menu))
hl.bind("SUPER+SHIFT+E", hl.dsp.exec_cmd(fileManager))
hl.bind("SUPER+B", hl.dsp.exec_cmd("xdg-open 'https://'"))
hl.bind("SUPER+N", hl.dsp.exec_cmd("kitty -e nvim"))

-- Блокировка экрана и смена обоев
hl.bind("SUPER+U", hl.dsp.exec_cmd("swaylock -i ~/Pictures/wallpapers/bg.png"))
hl.bind("SUPER+SHIFT+W", hl.dsp.exec_cmd("~/.config/sway/set_wallpaper.sh"))

-- Скриншоты (grim + slurp)
hl.bind("SUPER+SHIFT+P", hl.dsp.exec_cmd('grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%m-%s).png'))
hl.bind("SUPER+P", hl.dsp.exec_cmd('grim ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%m-%s).png'))

-- Закрыть активное окно
hl.bind("SUPER+Q", hl.dsp.window.close())

-- Управление фокусом (Vim-клавиши)
hl.bind("SUPER+J", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER+K", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER+L", hl.dsp.focus({ direction = "up" }))


-- Управление фокусом (Стрелочки)
hl.bind("SUPER+left",  hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER+down",  hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER+up",    hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER+right", hl.dsp.focus({ direction = "right" }))

-- Перемещение окон (Vim-клавиши)
hl.bind("SUPER+SHIFT+J", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER+SHIFT+K", hl.dsp.window.move({ direction = "down" }))
hl.bind("SUPER+SHIFT+L", hl.dsp.window.move({ direction = "up" }))


-- Перемещение окон (Стрелочки)
hl.bind("SUPER+SHIFT+left",  hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER+SHIFT+down",  hl.dsp.window.move({ direction = "down" }))
hl.bind("SUPER+SHIFT+up",    hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER+SHIFT+right", hl.dsp.window.move({ direction = "right" }))




--------------------------------------------------------------
---- ОФИЦИАЛЬНОЕ УПРАВЛЕНИЕ РАБОЧИМИ СТОЛАМИ (1-10) ----
--------------------------------------------------------------

for i = 1, 10 do
    -- Вычисляем клавишу (1-9, для 10 — кнопка 0)
    local key = tostring(i % 10)
    
    -- SUPER + [1-0] — Перейти на рабочий стол
    hl.bind("SUPER+" .. key, hl.dsp.focus({ workspace = i }))
    
    -- SUPER + SHIFT + [1-0] — Переместить окно на рабочий стол
    hl.bind("SUPER+SHIFT+" .. key, hl.dsp.window.move({ workspace = i }))
end





-- Изменение разметки (Layout)
hl.bind("SUPER+H", hl.dsp.layout("preselect l")) 
hl.bind("SUPER+V", hl.dsp.layout("preselect d")) 
hl.bind("SUPER+F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind("SUPER+SHIFT+space", hl.dsp.window.float({ action = "toggle" }))


-- Мультимедиа-клавиши (Звук)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 2%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"))
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

-- Мультимедиа-клавиши (Плеер)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

-- Мультимедиа-клавиши (Яркость)
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("light -A 1"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("light -U 1"))
hl.bind("SUPER+SHIFT+B", hl.dsp.exec_cmd("brightnessctl s +5%"))
hl.bind("SUPER+SHIFT+T", hl.dsp.exec_cmd("brightnessctl s 5%-"))



--------------------------------


local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
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

