-- AWESOME CONFIG
-- Author: Lukas Elsner (awesome@mindrunner.de)
-- Description: Awesome config, tested on Gentoo's awesome 3.5.5

-- Standard awesome library
local gears = require("gears")
awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

naughty.config.defaults.timeout          = 5
naughty.config.defaults.screen           = 1
naughty.config.defaults.position         = "top_right"
naughty.config.defaults.margin           = 10
naughty.config.defaults.height           = 80
naughty.config.defaults.width            = 300
naughty.config.defaults.gap              = 1
naughty.config.defaults.ontop            = true
naughty.config.defaults.font             = beautiful.font or "Verdana 12"
naughty.config.defaults.icon             = nil
naughty.config.defaults.icon_size        = 32
naughty.config.defaults.fg               = beautiful.fg_focus or '#ffffff'
naughty.config.defaults.bg               = beautiful.bg_focus or '#535d6c'
naughty.config.presets.border_color      = beautiful.border_focus or '#535d6c'
naughty.config.defaults.border_width     = 5
naughty.config.defaults.hover_timeout    = nil

-- EXTENSIONS (functions etc)
--local mykb  = require("myrc.kb_layout") -- change keyboard layout
local myro  = require("conf.run_once")  -- run app as long it's not running already
local myerr = require("conf.error")     -- error reporting

-- VARIABLES
terminal = "urxvt"
editor = "vim"
editor_cmd = terminal .. " -e " .. editor
configpath="/home/"..os.getenv("USER").."/.config/awesome/"

-- THEME
-- default theme
beautiful.init("/usr/share/awesome/themes/default/theme.lua")

-- CUSTOM THEMES - pick name from themes/
local theme = "paper"
beautiful.init(configpath .. "/themes/" .. theme ..  "/theme.lua")


-- Default modkey (DEFAULT Mod4 = WinKey)
modkey = "Mod4"

-- TAGS (screens) && LAYOUTS
require("conf.tags")

-- MENUS (menubar, etc)
require("conf.menus")

-- Default wibox stuff (gentoo config)
require("conf.wiboxrc")

-- Key && mouse bindings
require("conf.binds")
require("conf.custom_binds")
root.keys(globalkeys) -- this actually sets the keys

-- WINDOW RULES
-- rules per app (placement, floating, etc)
require("conf.window_rules")

-- SIGNALs function to execute when a new client appears.
require("conf.signals")

-- STARTUP apps
require("conf.startup")

local oldspawn = awful.util.spawn
awful.util.spawn = function (s)
  oldspawn(s, false)
end
