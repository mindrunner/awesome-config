local awful = require("awful")

globalkeys = awful.util.table.join(globalkeys,
awful.key({ }, "XF86MonBrightnessDown", function () awful.util.spawn("xbacklight -dec 10") end),
awful.key({ }, "XF86MonBrightnessUp", function () awful.util.spawn("xbacklight -inc 10") end),
awful.key({ }, "XF86KbdBrightnessUp", function () awful.util.spawn("kbdlight up") end),
awful.key({ }, "XF86KbdBrightnessDown", function () awful.util.spawn("kbdlight down") end),
awful.key({ }, "XF86AudioRaiseVolume", function () awful.util.spawn("pamixer -i 1") end),
awful.key({ }, "XF86AudioLowerVolume", function () awful.util.spawn("pamixer -d 1") end),
awful.key({ }, "XF86AudioMute", function () awful.util.spawn("pamixer --toggle-mute") end),
awful.key({ }, "XF86AudioMicMute", function () awful.util.spawn("pamixer --toggle-mute") end),
awful.key({ }, "XF86Launch1", function () awful.util.spawn("systemctl suspend") end),
awful.key({ }, "XF86PowerOff", function () mymainmenu:show({keygrabber=true}) end),
awful.key({ }, "XF86Display", function () awful.util.spawn("/home/le/bin/xconfig") end),
awful.key({ }, "XF86ScreenSaver", function () awful.util.spawn("/home/le/bin/lock") end),


--CHANGE KEYBOARD LAYOUT
--awful.key({ modkey,           }, "Shift_R", function () kbdcfg.switch() end),
--PROMPT EXECUTE
awful.key({ modkey }, "q",  function () mypromptbox[mouse.screen]:run() end),
awful.key({ }, "Print", function () awful.util.spawn("scrot -e 'mv $f /mnt/hdd/drive/lu/pic/screenshots/ 2>/dev/null'") end),
awful.key({ "Mod1" }, "Print", function () awful.util.spawn("scrot -s -e 'mv $f /mnt/hdd/drive/lu/pic/screenshots/ 2>/dev/null'") end),
awful.key({ "Mod1" }, "l", function () awful.util.spawn("/home/le/bin/lock") end),
awful.key({ modkey }, "e", function () awful.util.spawn("/home/le/bin/fm") end),
awful.key({ modkey }, "r", function () awful.util.spawn("gmrun") end),
awful.key({ modkey, "Shift" }, "r", function () awful.util.spawn("xkill") end),
awful.key({ modkey }, "s", function () awful.util.spawn("/home/le/bin/xconfig") end),
awful.key({ modkey, }, ".", function () awful.screen.focus_relative( 1) end),
awful.key({ modkey, }, ",", function () awful.screen.focus_relative(-1) end),
awful.key({ modkey }, "b", function () mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible end),

awful.key({ "Control" }, "F8", function () awful.util.spawn("xbacklight -dec 5 -time 0") end),
awful.key({"Control" }, "F9", function () awful.util.spawn("xbacklight -inc 5 -time 0") end),

awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
awful.key({ modkey,           }, "space", function () awful.layout.inc(1) end),
awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1) end),


awful.key({ modkey,           }, "t",
function (c) 
  --c.ontop = not c.ontop 
  c.floating = not c.floating
end),

--MOD+TAB -- instead of switching to last client, rotate trough all clients
awful.key({ modkey }, "Tab",
function ()
  awful.client.focus.byidx(1)
  if client.focus then
    client.focus:raise()
  end
end)
)
--
---- CLIENT KEYS (work on current clients-windows)
clientkeys = awful.util.table.join(clientkeys,
--KILL active client
awful.key({ modkey }, "c", function (c) c:kill() end),

awful.key({ modkey, "Shift"   }, ",",
function (c)
  local curidx = awful.tag.getidx()
  if curidx == 1 then
    awful.client.movetotag(tags[client.focus.screen][9])
  else
    awful.client.movetotag(tags[client.focus.screen][curidx - 1])
  end
end),
awful.key({ modkey, "Shift"   }, ".",
function (c)
  local curidx = awful.tag.getidx()
  if curidx == 9 then
    awful.client.movetotag(tags[client.focus.screen][1])
  else
    awful.client.movetotag(tags[client.focus.screen][curidx + 1])
  end
end)

)




