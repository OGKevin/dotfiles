local awful = require("awful")
local helpers = require("helpers")

local function autostart_apps()
    --- Compositor
    helpers.run.check_if_running("picom", nil,
                                 function() awful.spawn("picom", false) end)
    --- Polkit Agent
    helpers.run.run_once_ps("lxpolkit", "/usr/bin/lxpolkit")
    --- 1password
    helpers.run.run_once_ps("1password", "/usr/sbin/1password --silent")
end

autostart_apps()
