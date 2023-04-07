-- Inspired by https://github.com/rxyhn/yoru/blob/main/config/awesome/configuration/keys.lua
local awful = require("awful")
local gears = require("gears")
-- local hotkeys_popup = require("awful.hotkeys_popup")
-- local beautiful = require("beautiful")
-- local dpi = beautiful.xresources.apply_dpi
-- local naughty = require("naughty")
-- local decorations = require("ui.decorations")
-- local bling = require("modules.bling")
-- local playerctl_daemon = require("signal.playerctl")
-- local machi = require("modules.layout-machi")
-- local helpers = require("helpers")
-- local apps = require("configuration.apps")
local client = client
--- Make key easier to call
--- ~~~~~~~~~~~~~~~~~~~~~~~
local mod = "Mod4"
-- local alt = "Mod1"
-- local ctrl = "Control"
local shift = "Shift"

-- Client key bindings
--
-- Default
local default_clientkeys = gears.table.join(
                               awful.key({mod}, "f", function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end, {description = "toggle fullscreen", group = "client"}),
                               awful.key({mod, "Control"}, "space",
                                         awful.client.floating.toggle, {
        description = "toggle floating",
        group = "client"
    }), awful.key({mod, "Control"}, "Return",
                  function(c) c:swap(awful.client.getmaster()) end,
                  {description = "move to master", group = "client"}),
                               awful.key({mod}, "o",
                                         function(c) c:move_to_screen() end, {
        description = "move to screen",
        group = "client"
    }), awful.key({mod}, "t", function(c) c.ontop = not c.ontop end,
                  {description = "toggle keep on top", group = "client"}),
                               awful.key({mod}, "n", function(c)
        -- The client currently has the input focus, so it cannot be
        -- minimized, since minimized clients can't have the focus.
        c.minimized = true
    end, {description = "minimize", group = "client"}),
                               awful.key({mod}, "m", function(c)
        c.maximized = not c.maximized
        c:raise()
    end, {description = "(un)maximize", group = "client"}),
                               awful.key({mod, "Control"}, "m", function(c)
        c.maximized_vertical = not c.maximized_vertical
        c:raise()
    end, {description = "(un)maximize vertically", group = "client"}),
                               awful.key({mod, shift}, "m", function(c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:raise()
    end, {description = "(un)maximize horizontally", group = "client"}))

-- Custom

local custom_clientkeys = gears.table.join(
                              awful.key({mod}, "q", function(c) c:kill() end, {
        description = "close",
        group = "client"
    }))

client.connect_signal("manage", function()
    local c = client.focus
    c:keys(gears.table.join(default_clientkeys, custom_clientkeys))
end)
