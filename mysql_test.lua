local mysql = require "resty.mysql"
local db, err = mysql:new()

if not db then
        ngx.say("failed to instantiate mysql: ", err)
        return
end

db:set_timeout(1000)

local ok, err, errno, sqlstate = db:connect{
        host = "192.168.1.145",
        port = 3308,
        database = "mysql",
        user = "root",
        password="123456",
        max_packet_size = 1024 * 1024
}

if not ok then
        ngx.say("failed to connect: ", err, ": ", errno, " ", sqlstate)
        return
end


res, err, errno, sqlstate = db:query("select name from test where id=1")
if not res then
        ngx.say("bad result ", err, ": ", errno, ": ", sqlstate, ".")
        return
end


local cjson = require "cjson"
ngx.var.b = res[1]["name"]
if ngx.var.b == "kevin" then
       return ngx.redirect("/bar");
end
