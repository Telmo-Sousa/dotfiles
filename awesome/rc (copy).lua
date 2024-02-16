-- Importing libraries 
local gears = require('gears')
local awful = require('awful')
require('awful.autofocus')
local bling = require('bling')
local beautiful = require('beautiful')
local keys = require('keys')
local wibox = require("wibox")
local naughty = require("naughty")

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

-- taglist with Dracula colors and adjusted powerline shape thickness
--local mytaglist = awful.widget.taglist {
--    screen = awful.screen.focused(),
--    filter = awful.widget.taglist.filter.all,
--    style = {
--        shape = function(cr, width, height)
--            gears.shape.powerline(cr, width, height, 8)  -- thickness 
--        end
--    },
--    buttons = keys.taglist_buttons
--}

-- Taglist
local mytaglist = awful.widget.taglist {
    screen = awful.screen.focused(),  -- Use 'awful.screen.focused()' to get the current screen
    filter = awful.widget.taglist.filter.all,
    buttons = keys.taglist_buttons
}

local mypromptbox = awful.widget.prompt()

-- Previous tasklist without icons
--local mytasklist = awful.widget.tasklist {
--    screen = awful.screen.focused(),
--    filter = awful.widget.tasklist.filter.currenttags,
--    buttons = keys.tasklist_buttons,
--    style = {
--        font = beautiful.tasklist_font,
--    },
----}

local icon_paths = {
    firefoxdeveloperedition = "/home/telmo/.config/awesome/icons/png/firefox-developer-icon.png",
    Alacritty = "/home/telmo/.config/awesome/icons/png/alacritty.png",
    discord = "/home/telmo/.config/awesome/icons/png/discord.png",
    zoom = "/home/telmo/.config/awesome/icons/png/Zoom.png",
    Spotify = "/home/telmo/.config/awesome/icons/png/spotify.png",
    Pavucontrol = "/home/telmo/.config/awesome/icons/png/pavucontrol.png",
    Lxappearance = "/home/telmo/.config/awesome/icons/png/lxappearance.png",
    ["nvidia-settings"] = "/home/telmo/.config/awesome/icons/png/nvidia.png",
    Steam = "/home/telmo/.config/awesome/icons/png/steam.png",
    Nemo = "/home/telmo/.config/awesome/icons/png/nemo.png",
    qbittorrent = "/home/telmo/.config/awesome/icons/png/qbittorrent.png",
    mpv = "/home/telmo/.config/awesome/icons/png/mpv.png",
    FileZilla = "/home/telmo/.config/awesome/icons/png/filezilla.png",
}

local mytasklist = awful.widget.tasklist {
    screen = awful.screen.focused(),
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = keys.tasklist_buttons,
    style = {
        font = beautiful.tasklist_font,
    },
    widget_template = {
        {
            {
                {
                    {
                        {
                            id = 'icon_role',
                            widget = wibox.widget.imagebox,
                        },
                        margins = 2,
                        widget = wibox.container.margin,
                    },
                    {
                        id = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left = 10,
                right = 10,
                widget = wibox.container.margin,
            },
            widget = wibox.container.background,
        },
        create_callback = function(self, c, index, objects)
            local icon_path = icon_paths[c.class]

            -- Set the custom icon if available
            if icon_path then
                self:get_children_by_id('icon_role')[1].image = gears.surface(icon_path)
            else
                -- Use default icon for other clients
                self:get_children_by_id('icon_role')[1].image = c.icon
            end
        end,
        layout = wibox.layout.align.vertical,
    },
}

-- Create a text clock widget
local clock_widget = wibox.widget.textclock()

-- Function to create the context menu items (you need to define this function)
function create_context_menu_items()
    return {
        { "Lock", function() awful.spawn.with_shell("betterlockscreen -l blur") end },
        { "Shutdown", function() awful.spawn.with_shell("poweroff") end },
        { "Reboot", function() awful.spawn.with_shell("reboot") end },
    }
end

-- Function to create the context menu
function create_context_menu()
    return awful.menu({
        items = create_context_menu_items(),
    })
end

-- Create a button that triggers the context menu
local context_menu_button = awful.widget.button({ image = "/home/telmo/.config/awesome/images/dracula.png" })
local context_menu = nil

context_menu_button:connect_signal("button::press", function(_, _, _, button)
    if button == 3 then  -- Right click (M2 button)
        if context_menu then
            context_menu:hide()
            context_menu = nil
            return
        end

        local menu_items = create_context_menu_items()

        local menu_theme = {
            bg_normal = beautiful.wibar_bg,
            fg_normal = beautiful.wibar_fg,
            border_color = beautiful.wibar_border_color,
            border_width = beautiful.wibar_border_width,
            submenu_icon = "/home/telmo/.config/awesome/images/dracula.png",
            height = 15,
            width = 75,
            font = beautiful.hotkeys_font,
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

-- Function to update the volume widget
local function update_volume(widget)
    awful.spawn.easy_async("sh -c 'pactl list sinks | grep \"^[[:space:]]Volume:\" | head -n 1 | sed -e \"s,.* \\([0-9][0-9]*\\)%.*,\\1,\"'", function(stdout)
        -- Extract the volume percentage from the pactl output
        local volume = tonumber(stdout or "0")

        -- Update the widget text
        widget.text = volume .. "%"
    end)
end

-- Volume widget
local volume_widget = wibox.widget.textbox()
update_volume(volume_widget)

-- Update the volume widget every 0.1 seconds
awful.widget.watch("sh -c 'pactl list sinks | grep \"^[[:space:]]Volume:\" | head -n 1 | sed -e \"s,.* \\([0-9][0-9]*\\)%.*,\\1,\"'", 0.1, function(widget, stdout)
    update_volume(widget)
end, volume_widget)

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
    {
        context_menu_button,
        layout = wibox.layout.fixed.horizontal,
        mylauncher,
        mytaglist,
    },
    expand = "none",
    mytasklist,
    {
        layout = wibox.layout.fixed.horizontal,
        volume_widget,
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
