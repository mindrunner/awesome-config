local awful = require("awful")
local menubar = require("menubar")

layouttimer = timer({ timeout = 0.01 })
layouttimer:connect_signal("timeout", function()
  c = awful.mouse.client_under_pointer(screen)
  if c then
    client.focus = c
    c:raise()
  end
  layouttimer:stop()
end)

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(globalbinds,
    awful.key({ modkey,           }, "Left",   function() awful.tag.viewprev()
                                                          layouttimer:start()
                                                          end      ),
    awful.key({ modkey,           }, "Right",  function() awful.tag.viewnext()
                                                          layouttimer:start()
                                                          end      ),
    awful.key({ modkey,           }, "Escape", function() awful.tag.history.restore()
                                                          layouttimer:start()
                                                          end      ),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
--    awful.key({ modkey,           }, "Tab",
--        function ()
--            awful.client.focus.history.previous()
--            if client.focus then
--                client.focus:raise()
--            end
--        end),
    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),


    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end)
)

clientkeys = awful.util.table.join(clientkeys,
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)


-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i+1]
                        if tag then
                           awful.tag.viewonly(tag)
                           layouttimer:start()
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i+1]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[i+1]
                      if client.focus and tag then
                          awful.client.movetotag(tag)
                     end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[i+1]
                      if client.focus and tag then
                          awful.client.toggletag(tag)
                      end
                  end))
end


-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.

local np_map = { 19, 20, 21,22,118,119 }
for i = 1, 6 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. np_map[i],
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i+10]
                        if tag then
                           awful.tag.viewonly(tag)
                           layouttimer:start()
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. np_map[i],
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i+10]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. np_map[i],
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[i+10]
                      if client.focus and tag then
                          awful.client.movetotag(tag)
                     end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. np_map[i],
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[i+10]
                      if client.focus and tag then
                          awful.client.toggletag(tag)
                      end
                  end))
end

    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. 49,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[1]
                        if tag then
                           awful.tag.viewonly(tag)
                           layouttimer:start()
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. 49,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[1]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. 49,
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[1]
                      if client.focus and tag then
                          awful.client.movetotag(tag)
                     end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. 49,
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[1]
                      if client.focus and tag then
                          awful.client.toggletag(tag)
                      end
                  end))


clientbuttons = awful.util.table.join(clientbuttons,
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

