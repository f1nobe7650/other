repeat wait() until Library and Utility

return function(tbl, name, cfg)
    cfg = cfg or {}

    Utility:Default(cfg, {
        Default = "",
        ClearOnFocus = false,
        Flag = Library:GetNextFlag(),
        Callback = function() end,
    })

    local TextBox = {}

    local TextBoxHolder = Library:New("Frame", {
        Name = "TextBoxHolder",
        Parent = tbl.Content,
        BackgroundTransparency = 1.000,
        Size = UDim2.new(1, 0, 0, 22),
    })
    
    local Inline = Library:New("Frame", {
        Name = "Inline",
        Parent = TextBoxHolder,
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
    
    local TextBoxObj = Library:New("TextBox", {
        Parent = Background,
        BackgroundTransparency = 1.000,
        ClipsDescendants = true,
        Size = UDim2.new(1, 0, 1, 0),
        ClearTextOnFocus = cfg.ClearOnFocus,
        FontFace = Library.Font,
        Weight = Enum.FontWeight.Regular,
        PlaceholderText = "",
        Text = "",
        Theme = "Text",
        TextSize = 14.000,
        TextTransparency = 1,
        TextStrokeTransparency = 0.700,
    })

    local PlaceHolder = Library:New("TextLabel", {
        Name = "PladeHolder",
        Parent = Background,
        BackgroundTransparency = 1.000,
        Size = UDim2.new(1, 0, 1, 0),
        FontFace = Library.Font,
        Weight = Enum.FontWeight.Regular,
        Text = name,
        Theme = "DarkText",
        TextSize = 14.000,
        TextTransparency = 1,
        TextStrokeTransparency = 0.700,
    })

    function TextBox:Callback(value)
        cfg.Callback = value

        TextBox:Set(TextBoxObj.Text)

        return TextBox
    end

    function TextBox:Flag(value)
        Library.Flags[cfg.Flag] = nil
        Library.ConfigFlags[cfg.Flag] = nil

        cfg.Flag = value

        Library.ConfigFlags[cfg.Flag] = function(value) TextBox:Set(value) end

        TextBox:Set(TextBoxObj.Text)

        return TextBox
    end

    function TextBox:Default(value)
        cfg.Default = value

        TextBox:Set(value)

        return TextBox
    end

    function TextBox:ClearOnFocus(value)
        cfg.ClearOnFocus = value

        return TextBox
    end

    function TextBox:Set(text)
        text = text or ""

        if text == "" then
            Library:Tween(TextBoxObj, true, {TextTransparency = 1, TextStrokeTransparency = 1})
            Library:Tween(PlaceHolder, true, {TextTransparency = 0, TextStrokeTransparency = 0.7})
        else
            Library:Tween(TextBoxObj, true, {TextTransparency = 0, TextStrokeTransparency = 0.7})
            Library:Tween(PlaceHolder, true, {TextTransparency = 1, TextStrokeTransparency = 1})
        end

        TextBoxObj.Text = text

        cfg.Callback(TextBoxObj.Text)
        Library.Flags[cfg.Flag] = TextBoxObj.Text
        Library.Flags[cfg.Flag .. "f"] = function(value) TextBox:Set(value) end

        return TextBox
    end

    function TextBox:Ret()
        return tbl.Tbl
    end

    TextBox:Set(cfg.Default)

    Utility:Connect(TextBoxObj.Focused, function()
        Library:Tween(TextBoxObj, true, {TextTransparency = 0, TextStrokeTransparency = 0.7})
        Library:Tween(PlaceHolder, true, {TextTransparency = 1, TextStrokeTransparency = 1})
    end)

    Utility:Connect(TextBoxObj.FocusLost, function()
        TextBox:Set(TextBoxObj.Text)
    end)

    Library.ConfigFlags[cfg.Flag] = function(value) TextBox:Set(value) end

    return TextBox
end