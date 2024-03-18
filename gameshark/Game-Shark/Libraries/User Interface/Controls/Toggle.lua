repeat wait() until Library and Utility

return function(tbl, name, cfg)
    cfg = cfg or {}

    Utility:Default(cfg, {
        State = false,
        Flag = Library:GetNextFlag(),
        Callback = function() end,
    })

    local Toggle = {
        Enabled = false,
    }

    local ToggleHolder = Library:New("TextButton", {
        Name = "ToggleHolder",
        Parent = tbl.Content,
        BackgroundTransparency = 1.000,
        Size = UDim2.new(1, 0, 0, 18),
        Text = "",
        AutomaticSize = Enum.AutomaticSize.Y,
    })
    
    local Inline = Library:New("Frame", {
        Name = "Inline",
        Parent = ToggleHolder,
        Theme = "Inline",
        BorderSizePixel = 0,
        Size = UDim2.new(0, 18, 0, 18),
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
    
    local ImageLabel = Library:New("ImageLabel", {
        Parent = Background,
        BackgroundTransparency = 1.000,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        Image = Library.Images.Check,
        ImageTransparency = 1.000,
    })
    
    local ToggleName = Library:New("TextLabel", {
        Name = "ToggleName",
        Parent = ToggleHolder,
        BackgroundTransparency = 1.000,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 23, 0, 0),
        Size = UDim2.new(1, -23, 0, 18),
        FontFace = Library.Font,
        Weight = Enum.FontWeight.Regular,
        Text = name,
        Theme = "Text",
        TextSize = 14.000,
        TextStrokeTransparency = 0.700,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    local ExtraHolder = Library:New("Frame", {
        Name = "ExtraHolder",
        Parent = ToggleHolder,
        BackgroundTransparency = 1.000,
        Size = UDim2.new(1, 0, 1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
    })
    
    Library:New("UIListLayout", {
        Parent = ExtraHolder,
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 4),
    })

    function Toggle:State(value)
        Toggle:Set(value)

        return Toggle
    end

    function Toggle:Callback(value)
        cfg.Callback = value

        Toggle:Set(Toggle.Enabled)

        return Toggle
    end

    function Toggle:Flag(value)
        Library.Flags[cfg.Flag] = nil
        Library.ConfigFlags[cfg.Flag] = nil

        cfg.Flag = value

        Library.ConfigFlags[cfg.Flag] = function(state) Toggle:Set(state) end

        Toggle:Set(Toggle.Enabled)

        return Toggle
    end

    function Toggle:Toggle()
        Toggle:Set(not Toggle.Enabled)

        return Toggle
    end

    function Toggle:Set(bool)
        Library:ChangeObjectTheme(Background, bool and "Inline" or "Background", true)

        Library:Tween(ImageLabel, true, {ImageTransparency = bool and 0 or 1})

        Toggle.Enabled = bool

        cfg.Callback(Toggle.Enabled)
        Library.Flags[cfg.Flag] = Toggle.Enabled

        return Toggle
    end

    function Toggle:Add(type, name, tbl)
        tbl = tbl or {}
        name = name or ""

        return getgenv()[type]({Content = ExtraHolder, Content2 = ToggleHolder, Tbl = Toggle}, name, tbl, true)
    end
    
    function Toggle:Ret()
        return tbl.Tbl
    end

    Toggle:Set(cfg.State)

    Utility:Connect(ToggleHolder.MouseButton1Down, Toggle.Toggle )

    Library.ConfigFlags[cfg.Flag] = function(state) Toggle:Set(state) end

    return Toggle
end