local awful = require("awful")
local helpers = require("helpers")

local function autostart_apps()
	--- Compositor
	helpers.run.check_if_running("picom", nil,
		function() awful.spawn("picom", false) end)
	--- Polkit Agent
	helpers.run.run_once_ps("lxpolkit", "/usr/bin/lxpolkit")
end

autostart_apps()
