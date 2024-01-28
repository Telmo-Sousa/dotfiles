-- Gruvbox
------------------

local theme = {}

theme.font          = 'MonaspiceNe Nerd Font Mono 16'

theme.bg_normal     = "#EDEBEC"
theme.bg_focus      = "#4c8daf"
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

-- Wallpaper
theme.wallpaper = '~/.config/awesome/themes/Gruvbox/wallpaper.png'

return theme
