-- by xiba#5806 @ 1/17/2022
-- give credit please, idc if u use it i just dont like being discredited <3
local watermark = {name = "watermark", accent = Color3.fromRGB(207, 89, 201), visible = true}
local client_info = loadstring(game:HttpGet("https://raw.githubusercontent.com/ao-0/Yun/main/client_info.lua"))()
-- // main
local Box = Drawing.new("Square")
Box.Transparency = 1
Box.Size = Vector2.new(246,30)
Box.Position = Vector2.new(10,10)
Box.Filled = true
Box.Visible = true
Box.Thickness = 0
Box.Color = Color3.fromRGB(20, 20, 20)

local Box2 = Drawing.new("Square")
Box2.Transparency = 1
Box2.Size = Vector2.new(240,24)
Box2.Position = Vector2.new(13,13)
Box2.Filled = true
Box2.Visible = true
Box2.Thickness = 9
Box2.Color = Color3.fromRGB(33, 33, 33)

local Box3 = Drawing.new("Square")
Box3.Transparency = 1
Box3.Size = Vector2.new(238, 1)
Box3.Position = Vector2.new(14,14)
Box3.Filled = true
Box3.Visible = true
Box3.Thickness = 0
Box3.Color = watermark.accent or Color3.fromRGB(120, 60, 210)

local text = Drawing.new("Text")
text.Transparency = 1
text.Position = Vector2.new(14,17)
text.Font = Drawing.Fonts.Plex
text.Size = 16
text.Visible = true
text.Center = false
text.Color = Color3.fromRGB(255,255,255)
text.Text = " "..watermark.name.." | 0 FPS"

client_info.fps_changed(function(fps)
    text.Text = " "..watermark.name.." | " .. fps .. " FPS "
    Box.Size = Vector2.new(text.TextBounds.X + 10, 30)
    Box2.Size = Vector2.new(Box.Size.X - 6, 24)
    Box3.Size = Vector2.new(Box2.Size.X - 2, 1)
    Box3.Color = watermark.accent or Color3.fromRGB(120, 60, 210)
    text.Visible = watermark.visible
    Box.Visible = watermark.visible
    Box2.Visible = watermark.visible
    Box3.Visible = watermark.visible
end)
return watermark
