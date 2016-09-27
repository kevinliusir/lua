
local path = string.gsub(ngx.var.thumbnail_dir, "/", "\\")
local originalUri = string.gsub(ngx.var.originalUri, "/", "\\")
local thumbnailimgfile = string.gsub(ngx.var.file, "/", "\\")
local response = os.execute("cd " .. path)

if response ~= 0 then
 	os.execute("md " .. path)  
end


local command = "gm convert " .. ngx.var.image_root .. originalUri .. " -thumbnail " .. "\"" ..  ngx.var.img_width .. "x" .. ngx.var.img_height .. "^" .. "\" " .. " -gravity center -extent " .. ngx.var.img_width .. "x" .. ngx.var.img_height .. " " .. thumbnailimgfile; 
    os.execute(command);  
    ngx.req.set_uri(ngx.var.thumbnail_url..ngx.var.uri.. "." ..ngx.var.img_thumb_fotmat);  