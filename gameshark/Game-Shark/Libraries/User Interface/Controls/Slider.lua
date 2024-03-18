repeat wait() until Library and Utility

local UserInputService = game.UserInputService

return function(tbl, name, cfg)
    cfg = cfg or {}

    Utility:Default(cfg, {
        Min = -100,
        Max = 100,
        Value = 0,
        Float = 1,
        Flag = Library:GetNextFlag(),
        Callback = function() end,
    })

    local Slider = {
        Sliding = false,
    }

    local SliderHolder = Library:New("Frame", {
        Name = "SliderHolder",
        Parent = tbl.Content,
        BackgroundTransparency = 1.000,
        Size = UDim2.new(1, 0, 0, 33),
    })
    
    local SliderName = Library:New("TextLabel", {
        Name = "SliderName",
        Parent = SliderHolder,
        BackgroundTransparency = 1.000,
        Size = UDim2.new(1, 0, 0, 20),
        FontFace = Library.Font,
        Weight = Enum.FontWeight.Regular,
        Text = name,
        Theme = "Text",
        TextSize = 14.000,
        TextStrokeTransparency = 0.700,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    local SliderValue = Library:New("TextLabel", {
        Name = "SliderValue",
        Parent = SliderHolder,
        BackgroundTransparency = 1.000,
        Size = UDim2.new(1, 0, 0, 20),
        FontFace = Library.Font,
        Weight = Enum.FontWeight.Regular,
        Text = "",
        Theme = "Text",
        TextSize = 14.000,
        TextStrokeTransparency = 0.700,
        TextXAlignment = Enum.TextXAlignment.Right,
    })
    
    local Inline = Library:New("Frame", {
        Name = "Inline",
        Parent = SliderHolder,
        Theme = "Inline",
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 22),
        Size = UDim2.new(1, 0, 1, -22),
    })
    
    Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = Inline,
    })
    
    local Background = Library:New("Frame", {
        Name = "Background",
        Parent = Inline,
        Theme = "Background",
        BorderSizePixel = 0,
        Position = UDim2.new(0, 1, 0, 1),
        Size = UDim2.new(1, -2, 1, -2),
    })
    
    Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = Background,
    })

    local FillBackground = Library:New("Frame", {
        Name = "FillBackground",
        Parent = Background,
        Theme = "Inline",
        BorderSizePixel = 0,
        Size = UDim2.new(0, 0, 1, 0),
    })
    
    Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = FillBackground,
    })
    
    local SliderBar = Library:New("Frame", {
        Name = "Slider",
        Parent = FillBackground,
        Theme = "Accent",
        BorderSizePixel = 0,
        Position = UDim2.new(1, -3, 0, -3),
        Size = UDim2.new(0, 6, 1, 6),
    })
    
    local UICorner = Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = SliderBar,
    })

    local DragPart = Library:New("Frame", {
        Name = "DragPart",
        Parent = Background,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
    })
    
    function Slider:Value(value)
        Slider:Set(value)

        return Slider
    end

    function Slider:Callback(value)
        cfg.Callback = value

        Slider:Set(cfg.Value)

        return Slider
    end

    function Slider:Flag(value)
        Library.Flags[cfg.Flag] = nil
        Library.ConfigFlags[cfg.Flag] = nil

        cfg.Flag = value

        Library.ConfigFlags[cfg.Flag] = function(value) Slider:Set(value) end

        Slider:Set(cfg.Value)

        return Slider
    end

    function Slider:Min(value)
        cfg.Min = value

        Slider:Set(cfg.Value)

        return Slider
    end

    function Slider:Max(value)
        cfg.Max = value

        Slider:Set(cfg.Value)

        return Slider
    end

    function Slider:Float(value)
        cfg.Float = value

        Slider:Set(cfg.Value)

        return Slider
    end

    function Slider:Set(value)
        value = math.clamp(Library:Round(value, cfg.Float), cfg.Min, cfg.Max)

        local Size = (value - cfg.Min) / (cfg.Max - cfg.Min)

        cfg.Value = value

        Library:Tween(FillBackground, true, {Size = UDim2.new(Size, 0, 1, 0)})

        cfg.Callback(value)
        Library.Flags[cfg.Flag] = value

        SliderValue.Text = string.format("%.14g", cfg.Value)

        return Slider
    end

    function Slider:Slide(input)
        local Size = (input.Position.X - Background.AbsolutePosition.X) / Background.AbsoluteSize.X
        local Value = math.clamp((cfg.Max - cfg.Min) * Size + cfg.Min, cfg.Min, cfg.Max)

        self:Set(Value)

        return Slider
    end

    function Slider:Ret()
        return tbl.Tbl
    end

    Slider:Set(cfg.Value)

    Library.ConfigFlags[cfg.Flag] = function(value) Slider:Set(value) end

    Utility:Connect(DragPart.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Slider.Sliding = true
            Slider:Slide(input)
        end
    end)

    Utility:Connect(DragPart.InputEnded, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Slider.Sliding = false
        end
    end)

    Utility:Connect(UserInputService.InputChanged, function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and Slider.Sliding then
            Slider:Slide(input)
        end
    end)

    return Slider
end