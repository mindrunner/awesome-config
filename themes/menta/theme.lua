--{{{ Main
require("awful.util")

theme = {}

home          = os.getenv("HOME")
config        = awful.util.getdir("config")
shared        = "/usr/share/awesome"
if not awful.util.file_readable(shared .. "/icons/awesome16.png") then
    shared    = "/usr/share/local/awesome"
end
sharedicons   = shared .. "/icons"
sharedthemes  = shared .. "/themes"
themes        = config .. "/themes"
themename     = "/menta"
if not awful.util.file_readable(themes .. themename .. "/theme.lua") then
       themes = sharedthemes
end
themedir      = themes .. themename

if awful.util.file_readable(config .. "/vain/init.lua") then
    theme.useless_gap_width  = "3"
end
--}}}

theme.font          = "Sans 8"

theme.cgreen = "#ACCD8A"
theme.cbgreen = "#ACCD8A"
theme.cdark = "#000000"
theme.cbright = "#FFFFFF"

theme.bg_normal     = theme.cdark
theme.bg_focus      = theme.cdark
theme.bg_urgent     = theme.cgreen

theme.fg_normal     = theme.cbright
theme.fg_focus      = theme.cbright
theme.fg_urgent     = theme.cbright

theme.border_width  = 1
theme.border_normal = theme.cdark
theme.border_focus  = theme.cgreen -- "#7985A3"
theme.border_marked = theme.cbright

-- There are another variables sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- Example:
theme.taglist_fg_focus = theme.cbgreen
theme.tasklist_fg_focus = theme.cbgreen

-- Display the taglist squares
theme.taglist_squares_sel =     themedir .. "/taglist/squarefw.png"
theme.taglist_squares_unsel =     themedir .. "/taglist/squarefw.png"
theme.tasklist_floating_icon =  nil -- sharedthemes .. "/default/tasklist/floatingw.png"

-- Bottom wibox height
theme.wibox_bottom_height = 14
theme.wibox_height = 22

-- Variables set for theming menu
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_bg_focus = theme.cgreen --"#7985A3"
theme.menu_bg_normal = theme.cdark -- "#454545"
theme.menu_border_color = theme.cgreen
theme.menu_border_width = 1
--theme.menu_submenu_icon = sharedthemes .. "/default/submenu.png"
theme.menu_height   = 24
theme.menu_width    = 200
theme.menu_context_height = 20

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--bg_widget    = "#cc0000"

-- Define the image to load
--theme.titlebar_close_button_normal = themedir .. "/titlebar/close_normal.png"
--theme.titlebar_close_button_focus = themedir .. "/titlebar/close_focus.png"
--
--theme.titlebar_ontop_button_normal_inactive = themedir .. "/titlebar/ontop_normal_inactive.png"
--theme.titlebar_ontop_button_focus_inactive = themedir .. "/titlebar/ontop_focus_inactive.png"
--theme.titlebar_ontop_button_normal_active = themedir .. "/titlebar/ontop_normal_active.png"
--theme.titlebar_ontop_button_focus_active = themedir .. "/titlebar/ontop_focus_active.png"

--theme.titlebar_sticky_button_normal_inactive = themedir .. "/titlebar/sticky_normal_inactive.png"
--theme.titlebar_sticky_button_focus_inactive = themedir .. "/titlebar/sticky_focus_inactive.png"
--theme.titlebar_sticky_button_normal_active = themedir .. "/titlebar/sticky_normal_active.png"
--theme.titlebar_sticky_button_focus_active = themedir .. "/titlebar/sticky_focus_active.png"

--theme.titlebar_floating_button_normal_inactive = themedir .. "/titlebar/floating_normal_inactive.png"
--theme.titlebar_floating_button_focus_inactive = themedir .. "/titlebar/floating_focus_inactive.png"
--theme.titlebar_floating_button_normal_active = themedir .. "/titlebar/floating_normal_active.png"
--theme.titlebar_floating_button_focus_active = themedir .. "/titlebar/floating_focus_active.png"

--theme.titlebar_maximized_button_normal_inactive = themedir .. "/titlebar/maximized_normal_inactive.png"
--theme.titlebar_maximized_button_focus_inactive = themedir .. "/titlebar/maximized_focus_inactive.png"
--theme.titlebar_maximized_button_normal_active = themedir .. "/titlebar/maximized_normal_active.png"
--theme.titlebar_maximized_button_focus_active = themedir .. "/titlebar/maximized_focus_active.png"

-- You can use your own layout icons like this:
theme.layout_dwindle =      sharedthemes .. "/default/layouts/dwindlew.png"
theme.layout_fairh =        sharedthemes .. "/default/layouts/fairhw.png"
theme.layout_fairv =        sharedthemes .. "/default/layouts/fairvw.png"
theme.layout_floating =     sharedthemes .. "/default/layouts/floatingw.png"
theme.layout_magnifier =    sharedthemes .. "/default/layouts/magnifierw.png"
theme.layout_max =          sharedthemes .. "/default/layouts/maxw.png"
theme.layout_spiral =       sharedthemes .. "/default/layouts/spiralw.png"
theme.layout_tilebottom =   sharedthemes .. "/default/layouts/tilebottomw.png"
theme.layout_tileleft =     sharedthemes .. "/default/layouts/tileleftw.png"
theme.layout_tile =         sharedthemes .. "/default/layouts/tilew.png"
theme.layout_tiletop =      sharedthemes .. "/default/layouts/tiletopw.png"

--theme.awesome_icon = config .. "/icons/im-aim.png"
--theme.clientmenu_icon = sharedicons .. "/icons/awesome16.png"
--theme.xvkbd_icon = config .. "/icons/keyboard.png"

-- look inside /usr/share/icons/, default: nil (don't use icon theme)
--theme.icon_theme = "Tango"
--theme.icon_theme_size = "32x32"
--theme.default_client_icon = config .. "/icons/float.gif"

return theme


