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
local theme = "gentoo"
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
