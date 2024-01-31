--     ___                                        
--    /   |_      _____  _________  ________  ___ 
--   / /| | | /| / / _ \/ ___/ __ \/ __  __ \/ _ \
--  / ___ | |/ |/ /  __(__  ) /_/ / / / / / /  __/
-- /_/  |_|__/|__/\___/____/\____/_/ /_/ /_/\___/ 

-------------------------------------------------------

-- Importing libraries
local gears = require('gears')
local awful = require('awful')
local lain = require('lain')
local hotkeys_popup = require("awful.hotkeys_popup").widget

-- Variables
local keys = {}

metakey = 'Mod4'
tags = 9
terminal = 'alacritty'
editor = 'vim'
editor_launch = editor

-- Keybindings
keys.globalkeys = gears.table.join(

    -- Awesome
    awful.key({metakey, 'Control'}, 'r', awesome.restart,
        {description = 'Reload awesome', group = 'Awesome'}),
    awful.key({metakey}, 'Tab', function () awful.layout.inc(1) end,
        {description = 'Next layout', group = 'Awesome'}),
    awful.key({metakey, 'Shift'}, 'Tab', function () awful.layout.inc(-1) end,
        {description = 'Previous layout', group = 'Awesome'}),
    awful.key({metakey}, 'Escape', awful.tag.history.restore,
        {description='Return to last tag', group='Custom Tags'}),
    awful.key({metakey, 'Shift'   }, 'q', awesome.quit,
        {description = 'Quit awesome', group = 'Awesome'}),
    awful.key({ metakey }, 's', function()
        local timestamp = os.date("%Y%m%d%H%M%S")
        local filename = '/home/telmo/Screenshots/screen_' .. timestamp .. '.png'
    os.execute('import -window root ' .. filename) end,
    { description = "Screenshot", group = 'Awesome' }),
awful.key({ metakey }, 'g', function()
    local timestamp = os.date("%Y%m%d%H%M%S")
    local filename = '/home/telmo/Screenshots/region_' .. timestamp .. '.png'
os.execute('import ' .. filename) end,
{ description = "Screenshot", group = 'Awesome' }),
    awful.key({metakey}, 'l', function() os.execute('betterlockscreen -l blur') end,
        {description = 'Lockscreen', group = 'Awesome'}),
    awful.key({ metakey  }, 'h', function() hotkeys_popup.show_help(nil, awful.screen.focused()) end,
        { description='Show Hotkeys', group='Awesome'  }),


    -- Window management
    awful.key({'Mod1',}, 'Tab', function() awful.client.focus.byidx(1) end,
        {description = 'Switch between windows', group = 'Window Management'}),
    awful.key({metakey}, 'Right', function () awful.tag.incmwfact(0.03) end,
        {description = 'Increase master width factor', group = 'Window Management'}),
    awful.key({metakey}, 'Left', function () awful.tag.incmwfact(-0.03) end,
        {description = 'Decrease master width factor', group = 'Window Management'}),
    awful.key({metakey, 'Control' }, '+', function () lain.util.useless_gaps_resize(1) end,
        {description = 'increment useless gaps', group = 'Window Management'}),
    awful.key({metakey, 'Control' }, '-', function () lain.util.useless_gaps_resize(-1) end,
        {description = 'decrement useless gaps', group = 'Window Management'}),

    -- Applications
    awful.key({metakey}, 'Return', function() awful.util.spawn(terminal) end,
        {description='Alacritty', group='Applications'}),
    awful.key({metakey}, 'k', function() awful.util.spawn(editor_launch) end,
        {description='Vim', group='Applications'}),
    awful.key({metakey}, 'r', function() awful.util.spawn('rofi -show run') end,
        {description='Rofi', group='Applications'}),
    awful.key({metakey}, 'w', function() awful.util.spawn('rofi -show window') end,
        {description='Rofi', group='Applications'}),  
    awful.key({metakey}, 'd', function() awful.util.spawn('rofi -show drun') end,
        {description='Rofi', group='Applications'}),                  
    awful.key({metakey}, 'f', function() awful.util.spawn('firefox-developer-edition') end,
        {description='Firefox', group='Applications'}),
    awful.key({metakey}, 'n', function() awful.util.spawn('nemo') end,
        {description='Nemo', group='Applications'}),
    awful.key({metakey}, 'v', function() awful.util.spawn('pavucontrol') end,
        {description='Pavucontrol', group='Applications'})
    )

keys.clientkeys = gears.table.join(
    awful.key({metakey}, 'q', function(c) c:kill() end,
        {description = 'Close', group = 'Window Management'}),
    awful.key({metakey,},'space', function(c) c.fullscreen = not c.fullscreen; c:raise() end,
        {description = 'Toggle Fullscreen', group = 'Window Management'}),
    awful.key({metakey, 'shift'}, 'space', function() awful.client.floating.toggle() end,
        {description = 'Toggle Floating', group = 'Window Management'})
    )

-- Mouse controls
keys.clientbuttons = gears.table.join(
    awful.button({}, 1, function(c) client.focus = c end),

    -- Meta + left click to move window
    awful.button({metakey}, 1, function() awful.mouse.client.move() end),

    -- Meta + middle click to kill window
    awful.button({metakey}, 2, function(c) c:kill() end),

    -- Meta + right click to resize window
    awful.button({metakey}, 3, function() awful.mouse.client.resize() end)
    )

for i = 1, tags do
    keys.globalkeys = gears.table.join(keys.globalkeys,
        -- View tag
        awful.key({metakey}, '#'..i + 9,
            function ()
                local tag = awful.screen.focused().tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            {description = 'View tag #'..i, group = 'Change Tags'}),


        -- Move window to tag
        awful.key({metakey, 'Shift'}, '#'..i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {description = 'Move focused window to tag #'..i, group = 'Custom Tags'}),

        -- ALSA volume control
        awful.key({}, 'XF86AudioRaiseVolume', function () awful.util.spawn('amixer -D pulse sset Master 2%+', false) end),
        --{description = 'increase volume', group = 'Volume'}),
        awful.key({}, 'XF86AudioLowerVolume', function () awful.util.spawn('amixer -D pulse sset Master 2%-', false) end),
        --{description = 'Decrease volume', group = 'Volume'}),
        awful.key({}, 'XF86AudioMute', function () awful.util.spawn('amixer -D pulse sset Master toggle', false) end),
        --{description = 'Mute', group = 'Volume'}),

        -- Toggle tag display.
        awful.key({metakey, 'Control'}, '#'..i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
        {description = 'Toggle tag #' .. i, group = 'Custom Tags'}))
end

-- Set globalkeys
root.keys(keys.globalkeys)

return keys
