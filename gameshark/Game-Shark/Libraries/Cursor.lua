repeat wait() until Utility

local RunService = game:GetService("RunService")
local TweenService = game.TweenService
local UserInputService = game.UserInputService
local Camera = workspace.Camera
local NewRGB = Color3.fromRGB
local NewVector = Vector2.new
local DrawObj = Drawing.new

Utility:Notify({
    Title = "GameShark",
    Description = "Cursor Loaded.",
    Time = 10,
})

local Cursor = {
    Enabled = false,
    Gap = 2,
    Size = 10,
    Thickness = 1,
    Lines = 4,
    SpinEnabled = true,
    SpinSpeed = 10,
    Position = "Screen",
    Color = Utility:FromRGBA(255, 255, 255, 1),
    Outline = Utility:FromRGBA(0, 0, 0, 1),
    Drawings = {},
}

for i = 1, 30 do
    local obj_outline = Utility:NewDrawing("Line")
    local obj = Utility:NewDrawing("Line")

    Cursor.Drawings[#Cursor.Drawings + 1] = {obj, obj_outline}
end

local Angle = 0
local Position = NewVector(0, 0)

Utility:Connect(RunService.RenderStepped, function()
    Angle += Cursor.SpinSpeed
    
    for _,v in pairs(Cursor.Drawings) do
        if v[1].Visible then
            v[1].Visible = false
            v[2].Visible = false
        end
    end
    
    if Cursor.Enabled then
        Cursor.Lines = math.clamp(Cursor.Lines, 1, 30)
        if Cursor.Position:lower() == "screen" then
            Position = Camera.ViewportSize / 2
        else
            Position = UserInputService:GetMouseLocation()
        end

        Position = Position - Vector2.new(1, 1)

        for i = 1, Cursor.Lines do
            local ObjectTable = Cursor.Drawings[i]
            local Line = ObjectTable[1]
            local Outline = ObjectTable[2]

            Line.Color = Cursor.Color
            Line.Transparency = Cursor.Color.a
            Line.Thickness = Cursor.Thickness
            Line.Visible = true

            Outline.Color = Cursor.Outline
            Outline.Transparency = Cursor.Outline.a
            Outline.Thickness = Cursor.Thickness + 2
            Outline.Visible = true
            Outline.ZIndex = -1

            local AnglePosition = Cursor.SpinEnabled and Angle + (i * (360 / Cursor.Lines)) or i * (360 / Cursor.Lines)
            local AddX = i % 6 == 2 and 0 or 0
            local AddY = i % 6 == 3 and 0 or 0

            Line.From = Position + NewVector((Cursor.Gap - AddX) * math.cos(math.rad(AnglePosition)), (Cursor.Gap - AddY) * math.sin(math.rad(AnglePosition)))
            Line.To = Position + NewVector(((Cursor.Gap) + Cursor.Size) * math.cos(math.rad(AnglePosition)), (Cursor.Gap + Cursor.Size) * math.sin(math.rad(AnglePosition)))
        
            Outline.From = Position + NewVector(((Cursor.Gap - AddX) - 1) * math.cos(math.rad(AnglePosition)), ((Cursor.Gap - AddY) - 1) * math.sin(math.rad(AnglePosition)))
            Outline.To = Position + NewVector((Cursor.Gap + Cursor.Size + 1) * math.cos(math.rad(AnglePosition)), (Cursor.Gap + Cursor.Size + 1) * math.sin(math.rad(AnglePosition)))
        end
    end
end)

return Cursor