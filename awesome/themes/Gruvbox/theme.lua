local theme = {}

theme.font          = 'MonaspiceNe Nerd Font Mono 16'

theme.bg_normal     = "#EDEBEC"
theme.bg_focus      = "#4c8daf" -- this color is blue
theme.bg_urgent     = "#4c8daf"
theme.bg_minimize   = "#4c8daf"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#EDEBEC"
theme.fg_focus      = "#4c8daf"
theme.fg_urgent     = "#5E9DAE"
theme.fg_minimize   = "#327B8E"

theme.useless_gap   = 7
theme.border_width  = 1
theme.border_normal = "#665c54"
theme.border_focus  = "#dfbf8e"
theme.border_marked = "#5E9DAE"

-- Hotkeys popup
theme.hotkeys_bg = '#282828'
theme.hotkeys_fg = '#a9b665'
theme.hotkeys_opacity = '0.9'
theme.hotkeys_border_width = 1
theme.hotkeys_border_color = '#dfbf8e'
theme.hotkeys_modifiers_fg = '#7daea3'
theme.hotkeys_label_fg = '#665c54'
theme.hotkeys_font = 'MonaspiceNe Nerd Font Mono 14'
theme.hotkeys_description_font = 'MonaspiceNe Nerd Font Mono 14'
theme.hotkeys_group_margin = 5
theme.wibar_bg = "#282828"
theme.wibar_fg = "#ebdbb2"
theme.wibar_border_color = "#665c54"
theme.wibar_border_width = 0
theme.wibar_height = 25

-- Apply the Gruvbox colors to the wibar widgets as needed
theme.taglist_bg_empty = theme.wibar_bg
theme.taglist_fg_empty = "#928374"
theme.taglist_bg_occupied = theme.wibar_bg
theme.taglist_fg_occupied = "#ebdbb2" -- color of occupied tags
theme.taglist_bg_urgent = theme.wibar_bg
theme.taglist_fg_urgent = "#fb4934"
theme.taglist_bg_focus = "#665c54"
theme.taglist_fg_focus = "#ebdbb2"

theme.tasklist_bg_normal = theme.wibar_bg
theme.tasklist_fg_normal = "#928374"
theme.tasklist_bg_focus = "#504945" -- color of tasklist
theme.tasklist_fg_focus = "#ebdbb2" -- color of font
theme.tasklist_disable_icon = true

-- Custom notification colors
theme.notification_bg = "#282828"
theme.notification_fg = "#ebdbb2"
theme.notification_border_color = "#4c8daf"
theme.notification_max_width = 200  
theme.notification_max_height = 100  

function create_notification(title, text)
    naughty.notify({
        title = title,
        text = text,
        timeout = 5,
        position = "top_right",
        bg = theme.notification_bg,
        fg = theme.notification_fg,
        width = theme.notification_max_width,
        height = theme.notification_max_height,
        icon = nil,
    })
end

-- Create context menu items with custom colors
function create_context_menu_items()
    return {
        { "Lock", function() awful.spawn.with_shell("betterlockscreen -l blur") end, theme.wibar_fg, theme.wibar_bg },
        { "Shutdown", function() awful.spawn.with_shell("poweroff") end, theme.wibar_fg, theme.wibar_bg },
        { "Reboot", function() awful.spawn.with_shell("reboot") end, theme.wibar_fg, theme.wibar_bg },
    }
end

-- Wallpaper
theme.wallpaper = '~/.config/awesome/themes/Gruvbox/wallpaper.png'

return theme
