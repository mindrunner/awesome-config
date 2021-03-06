local wibox = require("wibox")
local awful = require("awful")

volume_widget = wibox.widget.textbox()
volume_widget:set_align("right")

function update_volume(widget)
   local fd = io.popen("pamixer --get-volume")
   local status = fd:read()
   fd:close()

   local fd2 = io.popen("pamixer --get-mute")
   local mute = fd2:read()
   fd2:close()

   if string.find(mute, "true", 1, true) then
       volume = "M("..status..")  "
    else
       volume = "V("..status..")  "
    end

--       local volume = -1
--       local vol = -1
--
--
--   if tonumber(string.match(status, "(%d?%d?%d)%%")) == nil then
--                volume = "V("..vol..")"
--              widget:set_markup(volume.."  ")
--                      return
--       else
--               volume = tonumber(string.match(status, "(%d?%d?%d)%%")) / 100
--               vol = tonumber(string.match(status, "(%d?%d?%d)%%"))
--       end
--   -- volume = string.format("% 3d", volume)
--
--   status = string.match(status, "%[(o[^%]]*)%]")
--
--   -- starting colour
--   local sr, sg, sb = 0x3F, 0x3F, 0x3F
--   -- ending colour
--   local er, eg, eb = 0xDC, 0xDC, 0xCC
--
--       local overmax = false
--
--       if volume > 1 then
--               volume = 1
--               overmax = true
--       end
--
--
--   local ir = volume * (er - sr) + sr
--   local ig = volume * (eg - sg) + sg
--   local ib = volume * (eb - sb) + sb
--   interpol_colour = string.format("%.2x%.2x%.2x", ir, ig, ib)
--   if string.find(status, "on", 1, true) then
--               if overmax then
--       volume = " <span color='red' background='#" .. interpol_colour .. "'> O </span>"
--               else
--       volume = " <span background='#" .. interpol_colour .. "'>   </span>"
--               end
--               volume = "  V("..vol..")  "
--   else
--       volume = " <span color='red' background='#" .. interpol_colour .. "'> X </span>"
--         volume = "  M("..vol..")  "
--   end




   widget:set_markup(volume)
end

update_volume(volume_widget)

mytimer = timer({ timeout = 1 })
mytimer:connect_signal("timeout", function () update_volume(volume_widget) end)
mytimer:start()

