local awful = require("awful")
local wibox = require("wibox")
local vicious = require("vicious")
local volume = require("conf.volume")
local naughty = require("naughty")

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock("%d-%m-%y %I:%M  ")
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
  local fan = " F("..cur..")"
  fan_widget:set_markup(fan)
  fcur:close();
end


function gpuInfo()
  local fcur = io.popen("cat /proc/acpi/bbswitch | cut -c14-")
  local cur = fcur:read()
  if cur:match("OFF") then
    cur = "0"
  else
    cur = "1"
  end
  local gpu = " G("..cur..")  "
  gpu_widget:set_markup(gpu)
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
  local test = directory_exists("/sys/class/power_supply/"..adapter)
  local battery = "N/A"
  if test == false then
    battery_widget:set_markup(spacer..battery..spacer)
    return
  end
  local fcur = io.open("/sys/class/power_supply/"..adapter.."/energy_now")
  local fcap = io.open("/sys/class/power_supply/"..adapter.."/energy_full")
  local fsta = io.open("/sys/class/power_supply/"..adapter.."/status")
  local cur = fcur:read()
  local cap = fcap:read()
  local sta = fsta:read()
  battery = math.floor(cur * 100 / cap)
  local time = nil
  --local ftime = io.popen("upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep time | grep -oE \\-?[0-9]+\\.[0-9]+")
  local ftime = io.popen("/home/le/bin/batcheck")
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
    battery = "C("..time.."/"..battery..")"
  elseif sta:match("Discharging") then
    dir = ""

      battery = "B("..time.."/"..battery..")"


    --if tonumber(battery) < 25 then
    --  notify-send -u normal "low battery" "$BATTINFO"
    --end
  
  
    --if tonumber(battery) < 25 then
    --  notify-send -u critical "low battery" "$BATTINFO" 
    --end

  else
    dir = " "
    battery = "C("..battery..")"
  end
  battery_widget:set_markup(spacer..dir..battery..dir..spacer)
  print(battery)
  fcur:close()
  fcap:close()
  fsta:close()
end

function netInfo()
  local fnet = io.popen("wicd-cli -i")
  local net = fnet:read()
  if net == nil then
    local res = "N/A"
  elseif net:match("Not connected") then
    res = "X"
  elseif net:match("progress") then
    res = "P"
  else
    net = fnet:read()
    if net:match("Wireless") then
      local fspeed = io.popen("/sbin/iwconfig wlp3s0 |grep \"Bit Rate\"")
      local fqual = io.popen("/sbin/iwconfig wlp3s0 |grep \"Link Quality\"")
      local speed = fspeed:read("*all")
      local qual = fqual:read("*all")
      local q = tonumber(string.match(qual, "%d+"))
      local r = tonumber(string.sub(string.match(qual, "/%d+"), 2))
      local s = string.match(speed, "%d+")
      local linkqual = q/r*100
      res = "W("..math.floor(linkqual).."/"..s..")"
      fspeed:close();
      fqual:close();
    else
      local fspeed = io.popen("/usr/sbin/ethtool enp0s25 |grep Speed:")
      local speed = fspeed:read("*all")
      --print(speed)
      local s = string.match(speed, "%d+")
      res = "L("..s..")"
      fspeed:close();
    end
  end
  fnet:close()
  --print(res)
  --net_widget:set_markup("  "..res)
end

battery_timer = timer({timeout = 5})
battery_timer:connect_signal("timeout", function()
  batteryInfo("BAT0")
end)
battery_timer:start()

--net_timer = timer({timeout = 1})
--net_timer:connect_signal("timeout", function()
--netInfo()
--end)
--net_timer:start()

fan_timer = timer({timeout = 5})
fan_timer:connect_signal("timeout", function()
  fanInfo()
end)
fan_timer:start()


gpu_timer = timer({timeout = 10})
gpu_timer:connect_signal("timeout", function()
  gpuInfo()
end)
gpu_timer:start()

hdd_timer = timer({timeout = 10})
hdd_timer:connect_signal("timeout", function()
  hddInfo()
end)
hdd_timer:start()

-- battery warning
local function trim(s)
  return s:find'^%s*$' and '' or s:match'^%s*(.*%S)'
end

local function bat_notification()
  local f_capacity = assert(io.open("/sys/class/power_supply/BAT0/capacity", "r"))
  local f_status = assert(io.open("/sys/class/power_supply/BAT0/status", "r"))
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
    awful.util.spawn("systemctl suspend");
  end
end

battimer = timer({timeout = 15})
battimer:connect_signal("timeout", bat_notification)
battimer:start()

-- end here for battery warning


-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
awful.button({ }, 1, awful.tag.viewonly),
awful.button({ modkey }, 1, awful.client.movetotag),
awful.button({ }, 3, awful.tag.viewtoggle),
awful.button({ modkey }, 3, awful.client.toggletag),
awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
)
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
awful.button({ }, 1, function (c)
  if c == client.focus then
    c.minimized = true
  else
    -- Without this, the following
    -- :isvisible() makes no sense
    c.minimized = false
    if not c:isvisible() then
      awful.tag.viewonly(c:tags()[1])
    end
    -- This will also un-minimize
    -- the client, if needed
    client.focus = c
    c:raise()
  end
end),
awful.button({ }, 3, function ()
  if instance then
    instance:hide()
    instance = nil
  else
    instance = awful.menu.clients({ width=250 })
  end
end),
awful.button({ }, 4, function ()
  awful.client.focus.byidx(1)
  if client.focus then client.focus:raise() end
end),
awful.button({ }, 5, function ()
  awful.client.focus.byidx(-1)
  if client.focus then client.focus:raise() end
end))

for s = 1, screen.count() do
  -- Create a promptbox for each screen
  mypromptbox[s] = awful.widget.prompt()
  -- Create an imagebox widget which will contains an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  mylayoutbox[s] = awful.widget.layoutbox(s)
  mylayoutbox[s]:buttons(awful.util.table.join(
  awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
  awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
  awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
  awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
  -- Create a taglist widget
  mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

  -- Create a tasklist widget
  mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

  -- Create the wibox
  mywibox[s] = awful.wibox({ position = "bottom", height="12", screen = s })

  -- Widgets that are aligned to the left
  local left_layout = wibox.layout.fixed.horizontal()
  -- left_layout:add(mylauncher)
  left_layout:add(mytaglist[s])
  left_layout:add(mypromptbox[s])

  -- Widgets that are aligned to the right
  local right_layout = wibox.layout.fixed.horizontal()
  if s == 1 then right_layout:add(wibox.widget.systray()) end
  right_layout:add(hdd_widget)
  right_layout:add(gpu_widget)
  right_layout:add(fan_widget)
  --right_layout:add(net_widget)
  right_layout:add(battery_widget)
  right_layout:add(volume_widget)
  right_layout:add(mytextclock)
  right_layout:add(mylayoutbox[s])

  -- Now bring it all together (with the tasklist in the middle)
  local layout = wibox.layout.align.horizontal()
  layout:set_left(left_layout)
  layout:set_middle(mytasklist[s])
  layout:set_right(right_layout)

  mywibox[s]:set_widget(layout)
end
