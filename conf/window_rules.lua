local awful = require("awful")
local beautiful = require("beautiful")

---{{{ Rules
awful.rules.rules = {
	-- All clients will match this rule.
	{ rule = { },
	properties = { border_width = beautiful.border_width,
	border_color = beautiful.border_normal,
	size_hints_honor = false,
	focus = awful.client.focus.filter,
	raise = false,
	keys = clientkeys,
	buttons = clientbuttons,
	screen = awful.screen.preferred,
	placement = awful.placement.no_overlap+awful.placement.no_offscreen
} }
--    {
--        rule = { instance = "termtag1", class ="URxvt" },
--        properties= { tag = tags[1][1] },
--    },
--    {
--        rule = { instance = "termtag2", class ="URxvt" },
--        properties= { tag = tags[1][2] },
--    },
--    {
--        rule = { instance = "systag", class ="URxvt" },
--        properties= { tag = tags[1][14] },
--    },
--    {
--        rule = { class = "Firefox"},
--        properties= { tag = tags[1][5] },
--    },
--    {
--        rule = { class = "chromium-browser-chromium"},
--        properties= { tag = tags[1][3] },
--    },
--    {
--        rule = { class = "vivaldi-snapshot"},
--        properties= { tag = tags[1][5] },
--    },
--    {
--        rule = { class = "Telegram" },
--        properties = { tag = tags[1][15],
--        callback   = awful.client.setslave },
--    },
--    {
--        rule = { class = "Pidgin" },
--        properties = { tag = tags[1][15],
--        callback   = awful.client.setslave },
--    },
--    {
--        rule = { class = "Skype" },
--        properties = { tag = tags[1][9],
--        callback   = awful.client.setslave },
--    },
--    {
--        rule = { class = "Hexchat" },
--        properties = { tag = tags[1][16],
--        callback   = awful.client.setslave },
--    },
--    {
--        rule = { instance = "plugin-container" },
--        properties = { floating = true }
--    },
--    {
--        rule = { class = "Wine" },
--        properties = { border_width = 0, floating = true }
--    },
--    {
--        rule = { instance = "crx_knipolnnllmklapflnccelgolnpehhpl" },
--        properties = { floating = true },
--        --callback = function(c)
--        --    -- Show to titlebar else you may not know who you're talking with.
--        --    awful.titlebar.add(c, { modkey = modkey })
--        --end
--    },
}
-- }}}
