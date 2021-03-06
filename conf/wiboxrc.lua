local awful = require("awful")
local wibox = require("wibox")
local vicious = require("vicious")
local volume = require("conf.volume")
local naughty = require("naughty")
local gears = require("gears")

mytextclock = wibox.widget.textclock("%d-%m-%y %I:%M  ")

battery0_widget = wibox.widget.textbox()
battery0_widget:set_align("right")


battery1_widget = wibox.widget.textbox()
battery1_widget:set_align("right")
battery_widget = wibox.widget.textbox()
battery_widget:set_align("right")

--net_widget = wibox.widget.textbox()
--net_widget:set_align("right")

fan_widget = wibox.widget.textbox()
fan_widget:set_align("right")

gpu_widget = wibox.widget.textbox()
gpu_widget:set_align("right")

hdd_widget = wibox.widget.textbox()
hdd_widget:set_align("right")

backlight_widget = wibox.widget.textbox()
backlight_widget:set_align("right")


function dir_exists( sPath )
	if type( sPath ) ~= "string" then return false end

	local response = os.execute( "cd " .. sPath .. " > /dev/null 2>&1")
	if response == 0 then
		return true
	end
	return false
end

function directory_exists(path)
	local f  = io.popen("cd " .. path)
	local ff = f:read("*all")
	f:close();
	if (ff:find("No such file")) then
		return false
	else
		return true
	end
end

function fanInfo()
	local fcur = io.popen("cat /proc/acpi/ibm/fan | grep speed: | cut -c9-")
	local cur = fcur:read()
	local fan = "  F("..cur..")  "
	fan_widget:set_markup(fan)
	fcur:close();
end

function backlightInfo()
	local fcur = io.popen("cat /sys/class/backlight/*/brightness")
	local cur = fcur:read()
	local backlight = "  L(N/A)  "
	if cur ~= nil then
		backlight = "  L("..cur..")  "
	end
	backlight_widget:set_markup(backlight)
	fcur:close();
end

function gpuInfo()
	local fcur = io.popen("cat /proc/acpi/bbswitch | cut -c14-")
	local cur = fcur:read()
	if cur == nil then
		local gpu = "  G(N/A)  "
		gpu_widget:set_markup(gpu)
	else
		if cur:match("OFF") then
			cur = "0"
		else
			cur = "1"
		end
		local gpu = "  G("..cur..")  "
		gpu_widget:set_markup(gpu)
	end
	fcur:close();
end

function hddInfo()
	local fcur = io.popen("sudo /sbin/hdparm -C /dev/sdb | grep drive | cut -c19-")
	local cur = fcur:read()
	if cur:match("standby") then
		cur = "0"
	else
		cur = "1"
	end
	local hdd = "  H("..cur..")  "
	hdd_widget:set_markup(hdd)
	fcur:close();
end

function batteryInfo(adapter)
	spacer = "  "
	local has_bat0 = true
	--local has_bat1 = false
	--has_bat0 = dir_exists("/sys/class/power_supply/"..adapter)
	--has_bat1 = dir_exists("/sys/class/power_supply/BAT1")
	local battery = "N/A"
	local all = ""
	if has_bat0 == false then
		battery0_widget:set_markup(spacer..battery..spacer)
		return
	end
	--if has_bat1 == false then
	--      battery1_widget:set_markup("")
	--end

	local discharging = false

	if has_bat0 then
		local fcur = io.open("/sys/class/power_supply/"..adapter.."/energy_now")
		local fcap = io.open("/sys/class/power_supply/"..adapter.."/energy_full")
		--local fcur = io.open("/sys/class/power_supply/"..adapter.."/charge_now")
		--local fcap = io.open("/sys/class/power_supply/"..adapter.."/charge_full")
		local fsta = io.open("/sys/class/power_supply/"..adapter.."/status")
		local cur = fcur:read()
		local cap = fcap:read()
		local sta = fsta:read()
		discharging = sta:match("Discharging")
		battery = math.floor(cur * 100 / cap)
		local time = nil
		--local ftime = io.popen("upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep time | grep -oE \\-?[0-9]+\\.[0-9]+")
		local ftime = io.popen("/home/le/bin/batcheck 1")
		--local ftime = nil
		if ftime == nil then
		else
			time = ftime:read()
			ftime:close()
		end
		if time == nil then
			time = ""
		end
		if sta:match("Charging") then
			dir = ""
			battery = "  C("..time.."/"..battery..")  "
		elseif sta:match("Discharging") then
			dir = ""

			battery = "  B("..time.."/"..battery..")  "


			--if tonumber(battery) < 25 then
			--  notify-send -u normal "low battery" "$BATTINFO"
			--end
			--if tonumber(battery) < 25 then
			--  notify-send -u critical "low battery" "$BATTINFO"
			--end

		else
			dir = " "
			battery = "  C("..battery..")  "
		end
		battery0_widget:set_markup(battery)

		fcur:close()
		fcap:close()
		fsta:close()
	end

	-- if has_bat1 then
	--   local fcur = io.open("/sys/class/power_supply/BAT1/energy_now")
	--   local fcap = io.open("/sys/class/power_supply/BAT1/energy_full")
	--   local fsta = io.open("/sys/class/power_supply/BAT1/status")
	--   local cur = fcur:read()
	--   local cap = fcap:read()
	--   local sta = fsta:read()
	--   discharging = discharging or sta:match("Discharging")
	--   battery = math.floor(cur * 100 / cap)
	--   local time = nil
	--   --local ftime = io.popen("upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep time | grep -oE \\-?[0-9]+\\.[0-9]+")
	--   local ftime = io.popen("/home/le/bin/batcheck 2")
	--   --local ftime = nil
	--   if ftime == nil then
	--   else
	--       time = ftime:read()
	--       ftime:close()
	--   end
	--   if time == nil then
	--       time = ""
	--   end
	--   if sta:match("Charging") then
	--       dir = ""
	--       battery = "  C("..time.."/"..battery..")  "
	--   elseif sta:match("Discharging") then
	--       dir = ""

	--       battery = "  B("..time.."/"..battery..")  "


	--       --if tonumber(battery) < 25 then
	--       --  notify-send -u normal "low battery" "$BATTINFO"
	--       --end
	--       --if tonumber(battery) < 25 then
	--       --  notify-send -u critical "low battery" "$BATTINFO"
	--       --end

	--   else
	--       dir = " "
	--       battery = "  C("..battery..")  "
	--   end
	--   battery1_widget:set_markup(battery)

	--   fcur:close()
	--   fcap:close()
	--   fsta:close()
	-- end


	-- if discharging and has_bat0 and has_bat1 then
	--     local fpercent = io.popen("/home/le/bin/batcheck 3")
	--     local ftime = io.popen("/home/le/bin/batcheck 4")
	--     local percent = fpercent:read()
	--     local time = ftime:read()

	--     if percent == nil or time == nil then
	--       battery_widget:set_markup("")
	--     else
	--       battery_widget:set_markup("("..time.."/"..percent..")")
	--     end
	-- else
	--     battery_widget:set_markup("")
	-- end

end

--function netInfo()
--  local fnet = io.popen("wicd-cli -i")
--  local net = fnet:read()
--  if net == nil then
--    local res = "N/A"
--  elseif net:match("Not connected") then
--    res = "X"
--  elseif net:match("progress") then
--    res = "P"
--  else
--    net = fnet:read()
--    if net:match("Wireless") then
--      local fspeed = io.popen("/sbin/iwconfig wlp3s0 |grep \"Bit Rate\"")
--      local fqual = io.popen("/sbin/iwconfig wlp3s0 |grep \"Link Quality\"")
--      local speed = fspeed:read("*all")
--      local qual = fqual:read("*all")
--      local q = tonumber(string.match(qual, "%d+"))
--      local r = tonumber(string.sub(string.match(qual, "/%d+"), 2))
--      local s = string.match(speed, "%d+")
--      local linkqual = q/r*100
--      res = "W("..math.floor(linkqual).."/"..s..")"
--      fspeed:close();
--      fqual:close();
--    else
--      local fspeed = io.popen("/usr/sbin/ethtool enp0s25 |grep Speed:")
--      local speed = fspeed:read("*all")
--      --print(speed)
--      local s = string.match(speed, "%d+")
--      res = "L("..s..")"
--      fspeed:close();
--    end
--  end
--  fnet:close()
--  --print(res)
--  --net_widget:set_markup("  "..res)
--end

battery_timer = gears.timer({timeout = 10})
battery_timer:connect_signal("timeout", function()
	batteryInfo("BAT1")
	--fanInfo()
	--  gpuInfo()
	--hddInfo()
	--backlightInfo()
	--netInfo()
end)
battery_timer:start()

-- battery warning
local function trim(s)
	return s:find'^%s*$' and '' or s:match'^%s*(.*%S)'
end

local function bat_notification()
	local f_capacity = assert(io.open("/sys/class/power_supply/BAT1/capacity", "r"))
	local f_status = assert(io.open("/sys/class/power_supply/BAT1/status", "r"))
	local bat_capacity = tonumber(f_capacity:read("*all"))
	local bat_status = trim(f_status:read("*all"))

	if (bat_capacity <= 10 and bat_status == "Discharging") then
		naughty.notify({ title      = "Battery Warning"
		, text       = "Battery low! " .. bat_capacity .."%" .. " left!"
		, fg="#ffffff"
		, bg="#C91C1C"
		, timeout    = 15
		, position   = "bottom_right"
	})
end
if (bat_capacity <= 5 and bat_status == "Discharging") then
	awful.spawn("systemctl suspend");
end
end

battimer = gears.timer({timeout = 15})
battimer:connect_signal("timeout", bat_notification)
battimer:start()

-- end here for battery warning


-- Create a wibox for each screen and add it
--mywibox = {}
--mypromptbox = {}
--mylayoutbox = {}
--mytaglist = {}
--mytaglist.buttons = awful.util.table.join(
--awful.button({ }, 1, awful.tag.viewonly),
--awful.button({ modkey }, 1, awful.client.movetotag),
--awful.button({ }, 3, awful.tag.viewtoggle),
--awful.button({ modkey }, 3, awful.client.toggletag),
--awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
--awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
--)
--mytasklist = {}
--mytasklist.buttons = awful.util.table.join(
--awful.button({ }, 1, function (c)
--	if c == client.focus then
--		c.minimized = true
--	else
--		-- Without this, the following
--		-- :isvisible() makes no sense
--		c.minimized = false
--		if not c:isvisible() then
--			awful.tag.viewonly(c:tags()[1])
--		end
--		-- This will also un-minimize
--		-- the client, if needed
--		client.focus = c
--		c:raise()
--	end
--end),
--awful.button({ }, 3, function ()
--	if instance then
--		instance:hide()
--		instance = nil
--	else
--		instance = awful.menu.clients({ width=250 })
--	end
--end),
--awful.button({ }, 4, function ()
--	awful.client.focus.byidx(1)
--	if client.focus then client.focus:raise() end
--end),
--awful.button({ }, 5, function ()
--	awful.client.focus.byidx(-1)
--	if client.focus then client.focus:raise() end
--end))
--
--
--
--


local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end


local taglist_buttons = awful.util.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, client_menu_toggle_fn()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))











-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()
 
-- {{{ Battery state text
-- Initialize widget
--batterywidget = wibox.widget.textbox()
--batterywidget.border_width = 5
--bat_clo = battery.batclosure("BAT0")
--batterywidget:set_text(bat_clo())
--battimer = timer({ timeout = 30 })
--battimer:connect_signal("timeout", function() batterywidget:set_text(bat_clo()) end)
--battimer:start()
-- }}}
 
-- {{{ Volume
-- Initialize widget
 
 
volumewidget = wibox.widget {
    {
        max_value     = 100,
        value         = 0,
        background_color = '#222222',
        color = { type = "linear", from = { 0, 0 }, to = { 20, 0 }, stops = { { 0, "#46FF31" }, { 0.5, "#FBFF0B" }, { 1, "#FF0000" } }},
        widget        = wibox.widget.progressbar,
    },
    forced_height = 20,
    forced_width  = 15,
    direction     = 'east',
    layout        = wibox.container.rotate,
    buttons       = awful.util.table.join(
        awful.button({ }, 4,
                function ()
                        awful.util.spawn_with_shell("amixer set Master playback 1%+ -M")
                        vicious.force({volumewidget})
                end),
        awful.button({ }, 5,
                function ()
                        awful.util.spawn_with_shell("amixer set Master playback 1%- -M")
                        vicious.force({volumewidget})
                end)
    )
}
 
volume_text = awful.tooltip({objects = {volumewidget},})
 
vicious.register(volumewidget, vicious.widgets.volume,
        function (widget, args)
            if args[2] == "♫" then -- Sound is ON
                   widget.widget:set_value(args[1])
                   volume_text:set_text(args[1] .. "%")
                   return args[1]
            else
                   widget.widget:set_value(0)
                   volume_text:set_text("Mute")
                   return 0
            end
        end, 5, "Master"
)
-- }}}
 
-- {{{ CPU load
-- Create CPU load widget
cpubar = awful.widget.graph()
cpubar.border_width = 5
cpubar:set_width(40)
cpubar:set_background_color("#222222")
cpubar:set_color({ type = "linear", from = { 0, 0 }, to = { 0, 20 }, stops = { { 0, "#FF0000" }, { 0.5, "#391BFA" }, { 1, "#391BFA" } }})
 
cpubar_t = awful.tooltip({ objects = { cpubar }, })
--vicious.register(cpubar, vicious.widgets.cpu, "$1")
 
vicious.register(cpubar, vicious.widgets.cpu,
                    function (widget, args)
                        local p = io.popen("ps aux --sort=-pcpu | head -6 | awk '{ proc=\"\" \n for(i = 11; i <= NF; i++) proc = proc $i \" \" \n printf \"\\n%-10s %-6s %-6s %-30s\",$1,$2,$3,substr(proc, 0, 30)}'")
                        local o = p:read("*all")
                        p:close()
                        o = string.gsub(o, "<", "{")
                        o = string.gsub(o, ">", "}")
                        cpubar_t:set_text(string.format("CPU Usage %s%%%s", args[1], o))
                        return args[1]
                    end)
-- }}}
 
-- {{{ RAM usage
-- RAM usage widget
 
memwidget = wibox.widget {
    {
        max_value     = 100,
        value         = 0,
        background_color = '#222222',
        color = { type = "linear", from = { 0, 0 }, to = { 15, 0 }, stops = { { 0, "#AECF96" }, { 0.5, "#88A175" }, { 1, "#FF5656" } }},
        widget        = wibox.widget.progressbar,
    },
    forced_height = 20,
    forced_width  = 10,
    direction     = 'east',
    layout        = wibox.container.rotate,
}
 
-- RAM usage tooltip
memwidget_t = awful.tooltip({ objects = { memwidget },})
 
vicious.cache(vicious.widgets.mem)
vicious.register(memwidget, vicious.widgets.mem,
                function (widget, args)
                    local p = io.popen("ps -eo user,pid,rss,args --sort=-rss | head -11 | awk '{hr[1024*1024]=\"GB\"; hr[1024]=\"MB\"; h=0; for (x=1024*1024*1024; x>=1024; x/=1024) { if ($3>=x) { h=x; break } } { proc=\"\"; for(i = 4; i <= NF; i++) proc = proc $i \" \" } { if(NR != 1) { printf (\"\\n%-10s %-6s %-6.2f%s %-30s\", $1, $2, $3/h, hr[h], substr(proc, 0, 30)) } else { printf (\"\\n%-10s %-6s %s %-30s\", $1, $2, \"SIZE    \", substr(proc, 0, 30)) }}}'")
                    local o = p:read("*all")
                    p:close()
                    memwidget_t:set_text(string.format("RAM: %sMB / %sMB%s", args[2], args[3], o))
                    widget.widget:set_value(args[1])
                    return args[1]
                 end, 6)
                 --update every 6 seconds
-- }}}









awful.screen.connect_for_each_screen(function(s)
    s.mypromptbox = awful.widget.prompt()
	    
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "bottom", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            memwidget,
            cpubar,
            volumewidget,
            wibox.widget.systray(),
	        battery0_widget,
	        volume_widget,
            mytextclock,
            s.mylayoutbox,
        },
    }


--	-- Widgets that are aligned to the left
--	local left_layout = wibox.layout.fixed.horizontal()
--	-- left_layout:add(mylauncher)
--	left_layout:add(mytaglist[s])
--	left_layout:add(mypromptbox[s])
--
--	-- Widgets that are aligned to the right
--	local right_layout = wibox.layout.fixed.horizontal()
--	local systray = wibox.widget.systray()
--	--systray:set_base_size(10)
--	right_layout:add(systray) 
--	--  right_layout:add(hdd_widget)
--	--right_layout:add(gpu_widget)
--	--right_layout:add(fan_widget)
--	-- right_layout:add(backlight_widget)
--	--right_layout:add(net_widget)
--	right_layout:add(battery0_widget)
--	--right_layout:add(battery1_widget)
--	--right_layout:add(battery_widget)
--	right_layout:add(volume_widget)
--	right_layout:add(mytextclock)
--	right_layout:add(mylayoutbox[s])
--
--	-- Now bring it all together (with the tasklist in the middle)
--	local layout = wibox.layout.align.horizontal()
--	layout:set_left(left_layout)
--	layout:set_middle(mytasklist[s])
--	layout:set_right(right_layout)
--
--	mywibox[s]:set_widget(layout)
end)
