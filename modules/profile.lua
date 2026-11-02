local function hostname()
    local file = io.open("/etc/hostname", "r")
    if not file then
        return ""
    end
    local value = file:read("*l") or ""
    file:close()
    return value
end

local host_profiles = {
    [""] = "default",
}

local name = os.getenv("HYPRLAND_PROFILE") or host_profiles[hostname()] or "default"

local profiles = {
    default = {
        terminal = "kitty",
        file_manager = "Thunar",
        menu = "wofi",
        browser = "firefox",
        quick_apps = { "firefox", "kitty", "Thunar", "wofi" },
        natural_scroll = false,
        monitor_scale = "auto",
        numlock = true,
    },
    laptop = {
        terminal = "kitty",
        file_manager = "Thunar",
        menu = "wofi",
        browser = "firefox",
        quick_apps = { "firefox", "kitty", "Thunar", "wofi" },
        natural_scroll = true,
        monitor_scale = "auto",
        numlock = true,
    },
    desktop = {
        terminal = "kitty",
        file_manager = "Thunar",
        menu = "wofi",
        browser = "firefox",
        quick_apps = { "firefox", "kitty", "Thunar", "wofi" },
        natural_scroll = false,
        monitor_scale = "auto",
        numlock = true,
    },
}

local profile = profiles[name] or profiles.default
profile.name = profiles[name] and name or "default"
profile.monitor = os.getenv("HYPRLAND_MONITOR") or ""

return profile
