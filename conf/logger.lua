local naughty = require("naughty")

ilog = lognotify{
   logs = {
        syslog    = { file = "/var/log/messages", ignore = { "Changing fan level" },
        },
   -- Delay between checking in seconds. Default: 1
   interval = 1,
   -- Time in seconds after which popup expires. Set 0 for no timeout. Default: 0
   naughty_timeout = 15
}

ilog:start()
