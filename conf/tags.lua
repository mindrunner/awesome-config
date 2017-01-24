local awful = require("awful")
--local tyrannical = require("tyrannical")


-- LAYOUTS
--layouts = { awful.layout.suit.floating, awful.layout.suit.tile,
--  --    awful.layout.suit.tile.left,
--  awful.layout.suit.tile.bottom,
--  --    awful.layout.suit.tile.top,
--  awful.layout.suit.fair,
--  --    awful.layout.suit.fair.horizontal, awful.layout.suit.spiral,
--  --    awful.layout.suit.spiral.dwindle,
--  awful.layout.suit.max,
--  --    awful.layout.suit.max.fullscreen, awful.layout.suit.magnifier
--}
--
--
--
--awful.screen.connect_for_each_screen(function(s)
--	
--  tags = { names  = { "[0]","[1]", "[2]", "[3]", "[4]", "[5]", "[6]", "[7]", "[8]", "[9]", "[A]", "[B]", "[C]", "[D]", "[E]", "[F]"},
--  layout = {  layouts[2],layouts[2], layouts[2], layouts[5], layouts[2], layouts[2], layouts[2], layouts[2], layouts[4], layouts[2] , layouts[2], layouts[2], layouts[2], layouts[2], layouts[2], layouts[2]} }
--	awful.tag(tags.names,tags.layout)
--
--	end)
--
--
---- TAGS (aka screens) two options, for single or dual display
--tags = {} if screen.count() == 1 then
--  tags1_1 = { names  = { "[0]","[1]", "[2]", "[3]", "[4]", "[5]", "[6]", "[7]", "[8]", "[9]", "[A]", "[B]", "[C]", "[D]", "[E]", "[F]"},
--  layout = {  layouts[2],layouts[2], layouts[2], layouts[5], layouts[2], layouts[2], layouts[2], layouts[2], layouts[4], layouts[2] , layouts[2], layouts[2], layouts[2], layouts[2], layouts[2], layouts[2]} }
--  tags[1] = awful.tag(tags1_1.names, 1, tags1_1.layout) elseif screen.count() == 2 then
--
--  tags2_1 = { names  = { "[0]","[1]", "[2]", "[3]", "[4]", "[5]", "[6]", "[7]",
--  "[8]", "[9]", "[A]", "[B]", "[C]", "[D]", "[E]", "[F]"}, layout = { layouts[2],
--    layouts[2], layouts[2], layouts[5], layouts[2], layouts[2], layouts[2],
--    layouts[2], layouts[2], layouts[2] , layouts[2], layouts[2], layouts[2],
--    layouts[2], layouts[2], layouts[2]} }
--
--  tags2_2 = { names  = {"[0]", "[1]", "[2]", "[3]", "[4]", "[5]", "[6]", "[7]",
--  "[8]", "[9]", "[A]", "[B]", "[C]", "[D]", "[E]", "[F]"}, layout = { layouts[2],
--    layouts[2], layouts[2], layouts[5], layouts[2], layouts[2], layouts[2],
--    layouts[2], layouts[2], layouts[2] , layouts[2], layouts[2], layouts[2],
--    layouts[2], layouts[2], layouts[2]} }
--
--  tags[1] = awful.tag(tags2_1.names, 1, tags2_1.layout)
--  tags[2] = awful.tag(tags2_2.names, 2, tags2_2.layout) else
--
--  tags3_1 = { names  = { "[0]","[1]", "[2]", "[3]", "[4]", "[5]", "[6]", "[7]",
--  "[8]", "[9]", "[A]", "[B]", "[C]", "[D]", "[E]", "[F]"}, layout = { layouts[2],
--    layouts[2], layouts[2], layouts[5], layouts[2], layouts[2], layouts[2],
--    layouts[2], layouts[2], layouts[2] , layouts[2], layouts[2], layouts[2],
--    layouts[2], layouts[2], layouts[2]} }
--
--  tags3_2 = { names  = {"[0]", "[1]", "[2]", "[3]", "[4]", "[5]", "[6]", "[7]",
--  "[8]", "[9]", "[A]", "[B]", "[C]", "[D]", "[E]", "[F]"}, layout = { layouts[2],
--    layouts[2], layouts[2], layouts[5], layouts[2], layouts[2], layouts[2],
--    layouts[2], layouts[2], layouts[2] , layouts[2], layouts[2], layouts[2],
--    layouts[2], layouts[2], layouts[2]} }
--
--  tags3_3 = { names  = {"[0]", "[1]", "[2]", "[3]", "[4]", "[5]", "[6]", "[7]",
--  "[8]", "[9]", "[A]", "[B]", "[C]", "[D]", "[E]", "[F]"}, layout = { layouts[2],
--    layouts[2], layouts[2], layouts[5], layouts[2], layouts[2], layouts[2],
--    layouts[2], layouts[2], layouts[2] , layouts[2], layouts[2], layouts[2],
--    layouts[2], layouts[2], layouts[2]} }
--
--  tags[1] = awful.tag(tags3_1.names, 1, tags3_1.layout)
--  tags[2] = awful.tag(tags3_2.names, 2, tags3_2.layout)
--  tags[3] = awful.tag(tags3_3.names, 3, tags3_3.layout) end
----- }}}


-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
--screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    --set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({"[0]", "[1]", "[2]", "[3]", "[4]", "[5]", "[6]", "[7]", "[8]", "[9]" }, s, awful.layout.layouts[2])
end)



