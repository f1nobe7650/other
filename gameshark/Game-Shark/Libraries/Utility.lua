local Utility = {
    Connections = {},
    Objects = {},
    Drawings = {},
    ScreenGui = Instance.new("ScreenGui", game.CoreGui),
    Images = {
        Warning = "rbxassetid://14164618653",
        Error = "rbxassetid://14164633817",
        Info =  "rbxassetid://14164634879",
    },
    BindToRenderSteps = {},
}

local Players = game.Players
local LocalPlayer = Players.LocalPlayer
local UserInputService = game.UserInputService
local RunService = game.RunService
local NewRGB = Color3.fromRGB
local NewHSV = Color3.fromHSV
local NewInst = Instance.new
local NewVector = Vector2.new
local NewUdim2 = UDim2.new
local NewObj = Instance.new
local NewDraw = Drawing.new

function Utility:NewObject(type, prop, tbl)
    prop = prop or {}

    local obj = NewObj(type)

    for _,v in pairs(prop) do
        obj[_] = v
    end

    if tbl then
        table.insert(tbl, obj)
    end

    table.insert(Utility.Objects, obj)

    if obj:IsA("TextLabel") then
        obj.RichText = true
    end

    return obj
end

function Utility:NewDrawing(type, prop, tbl)
    prop = prop or {}

    local obj = NewDraw(type)

    for _,v in pairs(prop) do
        obj[_] = v
    end

    if tbl then
        table.insert(tbl, obj)
    end

    table.insert(Utility.Drawings, obj)

    return obj
end

function Utility:Default(tbl, default)
	for _,v in pairs(default) do
		if tbl[_] == nil then
			tbl[_] = v
		end
	end
end

Utility.NotificationHolder = Utility:NewObject("Frame", {
    Parent = Utility.ScreenGui,
    Size = NewUdim2(1, 0, 1, 0),
    Position = NewUdim2(0, 20, 0, 80),
    BackgroundTransparency = 1,
    AutomaticSize = Enum.AutomaticSize.Y,
    Visible = false,
})

Utility:NewObject("UIListLayout", {
    Parent = Utility.NotificationHolder,
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0, 6),
})

function Utility:BindToRenderStep(name, enum, callback)
    RunService:BindToRenderStep(name, enum, callback)

    Utility.BindToRenderSteps[name] = name
end 

function Utility:Notify(cfg)
    cfg = cfg or {}

    Utility:Default(cfg, {
        Title = "This is a test log.",
        Description = "",
        Type = "Info",
        Time = 5,
    })

    local Notification = {}

    local Holder = Utility:NewObject("Frame", {
        Parent = Utility.NotificationHolder,
        Size = NewUdim2(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
    })

    Utility:NewObject("UIListLayout", {
        Parent = Holder,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 6),
    })

    local TitleTextHolder = Utility:NewObject("Frame", {
        Name = "TitleTextHolder",
        Parent = Holder,
        BackgroundTransparency = 1.000,
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 0),
    })

    Utility:NewObject("UIListLayout", {
        Parent = TitleTextHolder,
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 6),
    })

    local ImageLabel = Utility:NewObject("ImageLabel", {
        Parent = TitleTextHolder,
        BackgroundTransparency = 1.000,
        Size = UDim2.new(0, 30, 0, 30),
        Image = cfg.Type:lower() == "warning" and Utility.Images.Warning or cfg.Type:lower() == "error" and Utility.Images.Error or cfg.Type:lower() == "info" and Utility.Images.Info or "",
        ImageColor3 = cfg.Type:lower() == "warning" and Color3.fromRGB(255, 255, 0) or cfg.Type:lower() == "error" and Color3.fromRGB(140, 0, 0) or cfg.Type:lower() == "info" and Color3.fromRGB(177, 177, 177) or Color3.fromRGB(255, 255, 255),
    })

    local TitleDescriptionHolder = Utility:NewObject("Frame", {
        Name = "TitleDescriptionHolder",
        Parent = TitleTextHolder,
        BackgroundTransparency = 1.000,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 0),
    })

    Utility:NewObject("UIListLayout", {
        Parent = TitleDescriptionHolder,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 6),
    })

    local TitleText = Utility:NewObject("TextLabel", {
        Name = "TitleText",
        Parent = TitleDescriptionHolder,
        BackgroundTransparency = 1.000,
        Size = UDim2.new(1, 0, 0, 30),
        Font = Enum.Font.GothamBold,
        Text = cfg.Title,
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextSize = 12.000,
        TextStrokeTransparency = 0.500,
        TextWrapped = true,
        AutomaticSize = Enum.AutomaticSize.Y,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    Utility:NewObject("UIPadding", {
        Parent = TitleText,
        PaddingLeft = UDim.new(0, 6),
        PaddingRight = UDim.new(0, 6),   
    })

    local DescriptionText = Utility:NewObject("TextLabel", {
        Name = "DescriptionText",
        Parent = TitleDescriptionHolder,
        BackgroundTransparency = 1.000,
        Size = UDim2.new(1, 0, 0, 0),
        Font = Enum.Font.Gotham,
        Text = cfg.Description,
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextSize = 12.000,
        TextStrokeTransparency = 0.500,
        TextWrapped = true,
        AutomaticSize = Enum.AutomaticSize.Y,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,     
    })

    Utility:NewObject("UIPadding", {
        Parent = DescriptionText,
        PaddingLeft = UDim.new(0, 6),
        PaddingTop = UDim.new(0, -4),   
    })

    task.spawn(function()
        wait(cfg.Time)

        Holder:Remove()
    end)

    return Notification
end

function Utility:GetTextBounds(text, font, size)
	local obj = NewInst("TextLabel")
	obj.TextSize = size
	obj.FontFace = font
    obj.FontFace.Weight = Enum.FontWeight.Regular
	obj.Text = text
	obj.Parent = Library.ScreenGui
	obj.Visible = false

	local TextBounds = obj.TextBounds

	obj:Destroy()

	return TextBounds
end

function Utility:ConvertUdim2(udim)
	return NewVector(udim.X.Offset, udim.Y.Offset)
end

function Utility:ConvertVector2(vector2)
	return NewUdim2(0, vector2.X, 0, vector2.Y)
end

function Utility:FromHex(hex)
    local R, G, B = string.match(hex, "^#?(%w%w)(%w%w)(%w%w)$")
    return Color3.fromRGB(tonumber(R, 16), tonumber(G, 16), tonumber(B, 16))
end

function Utility:ToHex(color)
    return string.format("#%02X%02X%02X", color.R * 0xFF, color.G * 0xFF, color.B * 0xFF)
end

function Utility:Connect(signal, callback)
	local Connection = signal:Connect(callback)

	table.insert(Utility.Connections, Connection)

	return Connection
end

function Utility:Disconnect(connection)
	local Index = table.find(Library.Connections, connection)
	connection:Disconnect()
end

function Utility:InBounds(guiElement, position)
	local AbsPosition = guiElement.AbsolutePosition
	local AbsSize = guiElement.AbsoluteSize

	local LeftBound = AbsPosition.X
	local RightBound = AbsPosition.X + AbsSize.X
	local TopBound = AbsPosition.Y
	local BottomBound = AbsPosition.Y + AbsSize.Y

	return position.X >= LeftBound and position.X <= RightBound and position.Y >= TopBound and position.Y <= BottomBound
end

function Utility:InBoundsSize(guiElement, position, size)
    local AbsPosition = guiElement.AbsolutePosition
    local AbsSize = guiElement.AbsoluteSize

    local LeftBound = AbsPosition.X
    local RightBound = AbsPosition.X + AbsSize.X
    local TopBound = AbsPosition.Y
    local BottomBound = AbsPosition.Y + AbsSize.Y

    local PositionWithSize = position + size

    return PositionWithSize.X >= LeftBound and position.X <= RightBound and PositionWithSize.Y >= TopBound and position.Y <= BottomBound
end

function Utility:Lerp(delta, from, to)
    if (delta > 1) then
        return to
    end
    if (delta < 0) then
        return from
    end
    return from + (to - from) * delta
end

function Utility:ColorRange(value, ranges) 
    if value <= ranges[1].start then
        return ranges[1].color
    end
    if value >= ranges[#ranges].start then
        return ranges[#ranges].color
    end

    local selected = #ranges
    for i = 1, #ranges - 1 do
        if value < ranges[i + 1].start then
            selected = i
            break
        end
    end
    local minColor = ranges[selected]
    local maxColor = ranges[selected + 1]
    local lerpValue = (value - minColor.start) / (maxColor.start - minColor.start)
    return Color3.new(
        Utility:Lerp(lerpValue, minColor.color.r, maxColor.color.r),
        Utility:Lerp(lerpValue, minColor.color.g, maxColor.color.g),
        Utility:Lerp(lerpValue, minColor.color.b, maxColor.color.b)
    )
end

function Utility:NumberLerp(value, ranges)
    if value >= ranges[#ranges].start then
        return ranges[#ranges].number
    end

    local selected = #ranges
    for i = 1, #ranges - 1 do
        if value < ranges[i + 1].start then
            selected = i
            break
        end
    end
    local minnumb = ranges[selected]
    local maxnumb = ranges[selected + 1]
    local lerpValue = (value - minnumb.start) / (maxnumb.start - minnumb.start)
    return Utility:Lerp(lerpValue, minnumb.number, maxnumb.number)
end

function Utility:FindRandomText(text)
	if text:find(' @r ') then 
		local b = text:split(' @r ')
		return b[math.random(#b)]
	else 
		return text
	end
end

function Utility:IsAlive(player)
    player = player or LocalPlayer

    return player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("Humanoid").Health > 0
end

function Utility:GetCase(text, case)
    case = case:lower()

    if case == "normal" then
        return text
    elseif case == "uppercase" then
        return text:upper()
    elseif case == "lowercase" then
        return text:lower()
    end
end

function Utility:GetDistance(player)
    if Utility:IsAlive(player) and Utility:IsAlive() then
        local Character = player.Character
        local HumanoidRootPart = Character.HumanoidRootPart
        
        return (HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    else
        return 0
    end
end

function Utility:Raycast(from, to, ignore)
    ignore = ignore or {}

    for _,v in pairs(Players:GetPlayers()) do
        if Utility:IsAlive(v) then
            table.insert(ignore, v.Character)
        end
    end

    local Params = RaycastParams.new()
    Params.IgnoreWater = true
    Params.FilterType = Enum.RaycastFilterType.Blacklist
    Params.FilterDescendantsInstances = ignore
    
    local Ray = workspace:Raycast(from, to, Params)

    if Ray ~= nil then
        -- Doing this if there is like glass or something.
        if Ray.Instance.Transparency >= .25 or not Ray.Instance.CanCollide then
            table.insert(ignore, Ray.Instance)
        end

        local NewRay = workspace:Raycast(from, to, Params)

        if NewRay ~= nil then
            Ray = NewRay
        end
    end

    return Ray
end

function Utility:FromRGBA(r, g, b, alpha)
    local rgb = NewRGB(r, g, b)
    local mt = table.clone(getrawmetatable(rgb))

    setreadonly(mt, false)
    local old = mt.__index

    mt.__index = newcclosure(function(self, key)
        if key:lower() == "a" then
            return alpha
        end

        return old(self, key)
    end)

    setrawmetatable(rgb, mt)

    return rgb
end

function Utility:GetPartInfo(part)
    return {
        ["Size"] = part.Size,
        ["Position"] = part.Position,
        ["CFrame"] = part.CFrame,
    }
end

function Utility:CFrameToVector3(cframe)
    return Vector3.new(cframe.X, cframe.Y, cframe.Z)
end

function Utility:Unload()
    --pcall(function()
        for _,v in pairs(Utility.Connections) do
            v:Disconnect()
            v = nil
        end
    
        for _,v in pairs(Utility.Drawings) do
            v.Visible = false
            --v:Remove()
        end
    
        for _,v in pairs(Utility.Objects) do
            v:Destroy()
        end

        for _,v in pairs(Utility.BindToRenderSteps) do
            RunService:UnbindFromRenderStep(v)
        end
    
        for _,v in pairs(Loader.FilesLoaded) do
            getgenv()[v] = nil
        end
    --end)
end

Utility:Connect(UserInputService.InputBegan, function(input)
    if input.KeyCode == Enum.KeyCode.F2 then
        Utility.NotificationHolder.Visible = not Utility.NotificationHolder.Visible
    end
end)

Utility:Notify({
    Title = "GameShark",
    Description = "Press F2 to open/close this menu!",
    Time = 10,
})

Utility:Notify({
    Title = "GameShark",
    Description = "Utility Loaded.",
    Time = 10,
})  

return Utility