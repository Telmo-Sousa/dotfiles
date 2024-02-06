-- Importing libraries 
local gears = require('gears')
local awful = require('awful')
require('awful.autofocus')
local bling = require('bling')
local beautiful = require('beautiful')
local keys = require('keys')
local wibox = require("wibox")
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup").widget

-- Loading the theme
theme_path = string.format('~/.config/awesome/themes/Dracula/theme.lua', os.getenv('HOME'), 'Dracula')
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
    awful.layout.suit.fair, --1, everything proportional
    awful.layout.suit.floating, --2, self explanatory
    awful.layout.suit.max, --3, independently big windows
    awful.layout.suit.magnifier, --4, one centered
    awful.layout.suit.tile, --5, one big the rest are small
    bling.layout.centered, --6, divided vertically
}

awful.screen.connect_for_each_screen(function(s)
    local tagTable = {' 1 ',' 2 ',' 3 ',' 4 ',' 5 ',' 6 ',' 7 ',' 8 ',' 9 '}
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

-- Set the default icon size for notifications
naughty.config.defaults['icon_size'] = 50

-- Sample notification on startup
naughty.notify({
    title = "AwesomeWM Started",
    text = "Welcome to AwesomeWM!",
    timeout = 5,
    position = "top_right",
})

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
    screen = awful.screen.focused(),
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = keys.tasklist_buttons,
    style = {
        font = beautiful.tasklist_font,
        --  font = "MonaspiceNe Nerd Font Mono 15",
    },
}

-- Create a text clock widget
local clock_widget = wibox.widget.textclock()
--clock_widget.font = "MonaspiceNe Nerd Font Mono 15" 

-- Function to create the context menu items (you need to define this function)
function create_context_menu_items()
    -- Implement this function to return the menu items
    return {
        { "Lock", function() awful.spawn.with_shell("betterlockscreen -l blur") end },
        { "Shutdown", function() awful.spawn.with_shell("poweroff") end },
        { "Reboot", function() awful.spawn.with_shell("reboot") end },
    }
end

-- Function to create the context menu
function create_context_menu()
    return awful.menu({
        items = create_context_menu_items(),  -- Use the function to get menu items
    })
end

-- Create a button that triggers the context menu
local context_menu_button = awful.widget.button({ image = "/home/telmo/.config/awesome/images/dracula.png" })
local context_menu = nil  -- Variable to track the currently open menu

context_menu_button:connect_signal("button::press", function(_, _, _, button)
    if button == 3 then  -- Right click (M2 button)
        -- Close the existing menu if it's open
        if context_menu then
            context_menu:hide()
            context_menu = nil
            return
        end

        local menu_items = create_context_menu_items()

        -- Menu theme (assuming beautiful object is properly defined)
        local menu_theme = {
            bg_normal = beautiful.wibar_bg,
            fg_normal = beautiful.wibar_fg,
            border_color = beautiful.wibar_border_color,
            border_width = beautiful.wibar_border_width,
            submenu_icon = "/home/telmo/.config/awesome/images/dracula.png",
            height = 15,
            width = 75,
            font = beautiful.hotkeys_font,
           -- Gruvbox
           -- bg_focus = "#504945",
           -- fg_focus = "#fb4934",
           -- Dracula colors 
            bg_focus = "#BD93F9",
            fg_focus = "#f8f8f2",
        }

        context_menu = awful.menu({
            items = menu_items,
            theme = menu_theme,
            on_hide = function() context_menu = nil end,
        })

        context_menu:toggle()
    end
end)

-- Create a wibox
local mywibox = awful.wibar({ position = "bottom", screen = 1 })

-- Set the desired offset values
local x_offset = 0
local y_offset = 7

-- Set the position with offsets
mywibox.x = x_offset
mywibox.y = mywibox.screen.geometry.height - mywibox.height - y_offset 

-- Add widgets to the wibox
mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
        context_menu_button,
        layout = wibox.layout.fixed.horizontal,
        mylauncher,
        mytaglist,
        --mypromptbox,
    },
    -- this centers the tasklist
    --expand = "none", 
    mytasklist, -- Middle widget
    { -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        --wibox.widget.systray(),
        clock_widget,
    },
}

-- Colored borders
client.connect_signal('focus', function(c) c.border_color = beautiful.border_focus end)
client.connect_signal('unfocus', function(c) c.border_color = beautiful.border_normal end)

-- Autostart
awful.spawn.with_shell("picom --config ~/.config/picom/picom.conf")
awful.spawn.with_shell('lxpolkit')
awful.spawn.with_shell('lxsession')
awful.spawn.with_shell('lxqt-policykit')
awful.spawn.with_shell('/home/telmo/.xprofile')
awful.spawn.with_shell('/home/telmo/.xinitrc')
awful.spawn.with_shell("~/.config/awesome/autorun.sh")
