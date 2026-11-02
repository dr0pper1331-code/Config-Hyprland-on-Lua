local name = os.getenv("HYPRLAND_PROFILE") or "default"

local profiles = {
    default = {
        terminal = "kitty",
        file_manager = "Thunar",
        menu = "wofi",
        natural_scroll = false,
        monitor_scale = "auto",
    },
    laptop = {
        terminal = "kitty",
        file_manager = "Thunar",
        menu = "wofi",
        natural_scroll = true,
        monitor_scale = "auto",
    },
    desktop = {
        terminal = "kitty",
        file_manager = "Thunar",
        menu = "wofi",
        natural_scroll = false,
        monitor_scale = "auto",
    },
}

local profile = profiles[name] or profiles.default
profile.name = profiles[name] and name or "default"
profile.monitor = os.getenv("HYPRLAND_MONITOR") or ""

return profile
