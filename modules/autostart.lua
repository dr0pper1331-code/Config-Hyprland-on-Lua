return function(home)
    hl.exec_cmd("mkdir -p " .. home .. "/Pictures/Screenshots")
    hl.exec_cmd("pgrep -x dunst >/dev/null 2>&1 || dunst")
    hl.exec_cmd("pgrep -x nm-applet >/dev/null 2>&1 || nm-applet --indicator")
    hl.exec_cmd("pgrep -x waybar >/dev/null 2>&1 || waybar")
    hl.exec_cmd("bash " .. home .. "/.config/hypr/set_wallpaper.sh")
end
