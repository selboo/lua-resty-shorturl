# lua-resty-shorturl

# test

```

# cat test.lua
local new = require('resty/shorturl/main')
local url = "https://github.com/selboo"

ngx.say("url:      " .. url)
ngx.say("shorturl: " .. new.short(url))

# resty test.lua
url:      https://github.com/selboo
shorturl: Gr6xlW

```