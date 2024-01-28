-- Importing libraries
local gears = require('gears')
local awful = require('awful')
require('awful.autofocus')
local bling = require('bling')
local beautiful = require('beautiful')
local keys = require('keys')
local wibox = require("wibox")
local hotkeys_popup = require("awful.hotkeys_popup").widget

-- Loading the theme
theme_path = string.format('~/.config/awesome/themes/Gruvbox/theme.lua', os.getenv('HOME'), 'Gruvbox')
beautiful.init(theme_path)

-- Set the wallpaper
local function set_wallpaper(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        if type(wallpaper) == 'function' then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal('property::geometry', set_wallpaper)

for s = 1, screen.count() do
	gears.wallpaper.maximized(beautiful.wallpaper, s, true)
end
-- Layouts
awful.layout.layouts = {
    awful.layout.suit.fair,
    bling.layout.horizontal,
    awful.layout.suit.floating,
    awful.layout.suit.max,
    awful.layout.suit.magnifier,
    awful.layout.suit.tile,
    bling.layout.centered,
    bling.layout.equalarea,
}

awful.screen.connect_for_each_screen(function(s)
    local tagTable = {'1','2','3','4','5','6','7','8','9'}
    awful.tag(tagTable, s, awful.layout.layouts[1])
end)

awful.rules.rules = {
    -- All windows
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = keys.clientkeys,
                     buttons = keys.clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
                   }
    },
}

-- Enable sloppy focus
client.connect_signal('mouse::enter', function(c)
    c:emit_signal('request::activate', 'mouse_enter', {raise = false})
end)

-- Create widgets
local mylauncher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = mymainmenu
})

local mytaglist = awful.widget.taglist {
    screen = awful.screen.focused(),  -- Use 'awful.screen.focused()' to get the current screen
    filter = awful.widget.taglist.filter.all,
    buttons = keys.taglist_buttons
}

local mypromptbox = awful.widget.prompt()

local mytasklist = awful.widget.tasklist {
    screen = awful.screen.focused(),  -- Use 'awful.screen.focused()' to get the current screen
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = keys.tasklist_buttons,
    style = {
        font = beautiful.tasklist_font,
    },
}

-- Create a text clock widget
local clock_widget = wibox.widget.textclock()

-- Create a wibox
local mywibox = awful.wibar({ position = "top", screen = 1 })

-- Add widgets to the wibox
mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        mylauncher,
        mytaglist,
        mypromptbox,
    },
    mytasklist, -- Middle widget
    { -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        wibox.widget.systray(),
        clock_widget,
    },
}

-- Colored borders
client.connect_signal('focus', function(c) c.border_color = beautiful.border_focus end)
client.connect_signal('unfocus', function(c) c.border_color = beautiful.border_normal end)

-- Autostart
awful.spawn.with_shell("picom --config ~/.config/picom/picom.conf")
awful.spawn.with_shell('lxpolkit')
awful.spawn.with_shell('lxqt-policykit')
awful.spawn.with_shell('/home/telmo/.xprofile')
awful.spawn.with_shell('/home/telmo/.xinitrc')
awful.spawn.with_shell("~/.config/awesome/autorun.sh")
