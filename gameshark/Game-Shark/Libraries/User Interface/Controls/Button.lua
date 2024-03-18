repeat wait() until Library and Utility

return function(tbl, name, cfg)
    cfg = cfg or {}

    Utility:Default(cfg, {
        Confirm = false,
        Callback = function() end,
    })

    local Button = {
        Clicked = false,
        Counting = false,
    }

    local ButtonHolder = Library:New("Frame", {
        Name = "ButtonHolder",
        Parent = tbl.Content,
        BackgroundTransparency = 1.000,
        Size = UDim2.new(1, 0, 0, 22),
    })
    
    local Inline = Library:New("Frame", {
        Name = "Inline",
        Parent = ButtonHolder,
        Theme = "Inline",
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
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
    
    local ButtonName = Library:New("TextLabel", {
        Name = "ButtonName",
        Parent = Background,
        BackgroundTransparency = 1.000,
        Size = UDim2.new(1, 0, 1, 0),
        FontFace = Library.Font,
        Weight = Enum.FontWeight.Regular,
        Text = name,
        Theme = "DarkText",
        TextSize = 14.000,
        TextStrokeTransparency = 0.700,
    })

    local ButtonClick = Library:New("TextButton", {
        Name = "ButtonName",
        Parent = Background,
        BackgroundTransparency = 1.000,
        Size = UDim2.new(1, 0, 1, 0),
        Text = "",
    })

    function Button:Confirm(value)
        cfg.Confirm = value

        return Button
    end

    function Button:Callback(value)
        cfg.Callback = value

        return Button
    end

    local function Click()
        if cfg.Confirm then
            if Button.Clicked then
                Button.Clicked = false
                Button.Counting = false

                ButtonName.Text = name
                Library:ChangeObjectTheme(ButtonName, "DarkText", true)
                cfg.Callback()
            else
                Button.Clicked = true
                Button.Counting = true

                for i = 1, 5 do
                    if not Button.Counting then
                        return
                    end

                    ButtonName.Text = "Confirm '" .. name .. "'? " .. 6 - i .. "s"
                    Library:ChangeObjectTheme(ButtonName, "Accent", true)
                    wait(1)
                end

                Button.Clicked = false
                Button.Counting = false
                ButtonName.Text = name
                Library:ChangeObjectTheme(ButtonName, "DarkText", true)
            end
        else
            cfg.Callback()
        end
    end

    function Button:Ret()
        return tbl.Tbl
    end

    Utility:Connect(ButtonClick.MouseButton1Down, function()
        Library:ChangeObjectTheme(Background, "NavBackground", true)
    end)

    Utility:Connect(ButtonClick.MouseButton1Up, function()
        Library:ChangeObjectTheme(Background, "Background", true)
        Click()
    end)

    return Button
end