local awful = require("awful")
local beautiful = require("beautiful")
local menubar = require("menubar")

-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { --{ "awesome", myawesomemenu, beautiful.awesome_icon },
                                    --{ "terminal", terminal },
                                    { "lock", "/home/le/bin/lock" },
                                    { "suspend", "systemctl suspend" },
                                    { "reboot", "/home/le/bin/reboot" },
                                    { "halt", "/home/le/bin/poweroff" },
                                  }
                        }
)
mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

