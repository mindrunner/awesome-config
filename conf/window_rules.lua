local awful = require("awful")
local beautiful = require("beautiful")

-- {{{ Rules
awful.rules.rules = {
  -- All clients will match this rule.
  { rule = { },
  properties = { border_width = beautiful.border_width,
  border_color = beautiful.border_normal,
  size_hints_honor = false,
  focus = awful.client.focus.filter,
  keys = clientkeys,
  buttons = clientbuttons } },
  {
    rule = { instance = "termtag", class ="URxvt" },
    properties= { tag = tags[1][2] },
  },
  {
    rule = { class = "Firefox"},
    properties= { tag = tags[1][5] },
  },
  {
    rule = { class = "Chromium"},
    properties= { tag = tags[1][3] },
  },
  {
    rule = { class = "Telegram" },
    properties = { tag = tags[1][15],
    callback   = awful.client.setslave },
  },
  {
    rule = { class = "Pidgin" },
    properties = { tag = tags[1][15],
    callback   = awful.client.setslave },
  },
  {
    rule = { class = "Skype" },
    properties = { tag = tags[1][9],
    callback   = awful.client.setslave },
  },
  {
    rule = { class = "Hexchat" },
    properties = { tag = tags[1][16],
    callback   = awful.client.setslave },
  },
  --{
  --        rule = { instance = "exe" },
  --        properties = { floating = true }
  --},
  {
    rule = { instance = "plugin-container" },
    properties = { floating = true }
  },
  --{
  --        rule = { class = "gimp" },
  --        properties = { floating = true }
  --},
  { 
    rule = { class = "Wine" },
    properties = { border_width = 0, floating = true }
  },
}
-- }}}


