
local new = require('resty/shorturl/main')
local url = "https://github.com/selboo"

ngx.say("url:      " .. url)
ngx.say("shorturl: " .. new.short(url))


