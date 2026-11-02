return function(home, config_dir)
    hl.on("hyprland.start", function()
        hl.exec_cmd("mkdir -p " .. home .. "/Pictures/Screenshots")
        hl.exec_cmd("pgrep -x dunst >/dev/null 2>&1 || dunst")
        hl.exec_cmd("if command -v nm-applet >/dev/null 2>&1; then pgrep -x nm-applet >/dev/null 2>&1 || nm-applet --indicator; fi")
        hl.exec_cmd("pgrep -x waybar >/dev/null 2>&1 || waybar")
        hl.exec_cmd("if find " .. home .. "/Pictures/wallpapers -maxdepth 1 -type f \\( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \\) -print -quit | grep -q .; then bash " .. config_dir .. "/set_wallpaper.sh; fi")
    end)
end
