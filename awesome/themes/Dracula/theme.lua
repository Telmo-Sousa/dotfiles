-- Dracula
------------------

local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")

local theme = {}

theme.font          = 'MonaspiceNe Nerd Font Mono 18'

theme.bg_normal     = "#282a36"
theme.bg_focus      = "#6272a4"
theme.bg_urgent     = "#6272a4"
theme.bg_minimize   = "#6272a4"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#f8f8f2"
theme.fg_focus      = "#f8f8f2"
theme.fg_urgent     = "#ff5555"
theme.fg_minimize   = "#bd93f9"

theme.useless_gap   = 7
theme.border_width  = 1
theme.border_normal = "#44475a"
theme.border_focus  = "#6272a4"
theme.border_marked = "#ff79c6"

-- Hotkeys popup
theme.hotkeys_bg = '#282a36'
theme.hotkeys_fg = '#50fa7b'
theme.hotkeys_opacity = '0.9'
theme.hotkeys_border_width = 1
theme.hotkeys_border_color = '#6272a4'
theme.hotkeys_modifiers_fg = '#bd93f9'
theme.hotkeys_label_fg = '#f8f8f2'
theme.hotkeys_font = 'MonaspiceNe Nerd Font Mono 16'
theme.hotkeys_description_font = 'MonaspiceNe Nerd Font Mono 15'
theme.hotkeys_group_margin = 5

-- Wibar
theme.wibar_bg = "#282a36"
theme.wibar_fg = "#f8f8f2"
theme.wibar_border_color = "#6272a4"
theme.wibar_border_width = 1
theme.wibar_height = 25

-- Systray
theme.systray_icon_spacing = 2

-- Apply the Dracula colors to the wibar widgets as needed
theme.taglist_bg_empty = theme.wibar_bg
theme.taglist_fg_empty = "#6272a4"
theme.taglist_bg_occupied = theme.wibar_bg
theme.taglist_fg_occupied = "#f8f8f2" -- color of occupied tags
theme.taglist_bg_urgent = theme.wibar_bg
theme.taglist_fg_urgent = "#ff5555"
theme.taglist_bg_focus = "#44475a"
theme.taglist_fg_focus = "#BD93F9"
theme.taglist_spacing = 0

-- Taglist shape
--theme.taglist_shape = function(cr, width, height)
--    gears.shape.rounded_rect(cr, width, height, 5)
--    gears.shape.powerline(cr, width, height, 5)
--end

-- Tasklist
theme.tasklist_bg_normal = theme.wibar_bg
theme.tasklist_fg_normal = "#6272a4"
theme.tasklist_bg_focus = "#282a36" -- color of tasklist
theme.tasklist_fg_focus = "#f8f8f2" -- color of font
theme.tasklist_disable_task_name = true -- Disable/enable the tasklist client titles
theme.tasklist_disable_icon = true -- disable/enable the tasklist icons, enabling breaks icons

-- Dracula colors for notifications
theme.notification_bg = "#282a36"
theme.notification_fg = "#f8f8f2"
theme.notification_border_color = "#6272a4"
theme.notification_max_width = 200  
theme.notification_max_height = 100
theme.notification_icon_size = 50

-- Wallpaper
theme.wallpaper = '~/.config/awesome/themes/Dracula/mac.jpg'

return theme

-- Background 	    #282a36 	 	Background Color
-- Current Line 	#44475a 	 	Current Line Color
-- Selection 	    #44475a 	 	Selection Color
-- Foreground 	    #f8f8f2 	 	Foreground Color
-- Comment 	        #6272a4 	 	Comment Color
-- Cyan 	        #8be9fd 	 	Cyan Color
-- Green 	        #50fa7b 	 	Green Color
-- Orange 	        #ffb86c 	 	Orange Color
-- Pink 	        #ff79c6 	 	Pink Color
-- Purple 	        #bd93f9 	 	Purple Color
-- Red 	            #ff5555 		Red Color
-- Yellow 	        #f1fa8c 	    Yellow Color
