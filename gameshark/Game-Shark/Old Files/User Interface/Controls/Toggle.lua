repeat wait() until Library and Utility

Utility:Notify({
    Title = "GameShark",
    Description = "User Interface \n{\n    Controls: <b>Toggle</b>\n}\nloaded.",
    Time = 10,
})

return function(self, cfg)
    cfg = cfg or {}

    Utility:Default(cfg, {
        Name = "New Toggle",
        Description = "",
        State = false,
        Flag = "Toggle",
        Callback = function() end,
    })

    local Toggle = {
        Toggled = false,
    }

    local ToggleBackground = Library:New("Frame", {
        Name = "ToggleBackground",
        Parent = self.Section,
        Theme = "ItemBackground",
        BorderSizePixel = 0,
        ClipsDescendants = true,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 34),     
    })

    Library:New("UICorner", ToggleBackground)

    Library:New("UIListLayout", {
        Parent = ToggleBackground,
        SortOrder = Enum.SortOrder.LayoutOrder,
    })

    local ToggleText = Library:New("TextLabel", {
        Name = "ToggleText",
        Parent = ToggleBackground,
        BackgroundTransparency = 1.000,
        Size = UDim2.new(1, 0, 0, 34),
        Font = Enum.Font.GothamBold,
        Text = cfg.Name,
        Theme = "Text",
        TextSize = 12.000,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    Library:New("UIPadding", {
        Parent = ToggleText,
        PaddingLeft = UDim.new(0, 10),
    })

    local CheckedOutline = Library:New("Frame", {
        Name = "CheckedOutline",
        Parent = ToggleText,
        Theme = "Outline",
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Position = UDim2.new(1, -50, 0.5, -10),
        Size = UDim2.new(0, 40, 0, 20),
    })

    Library:New("UICorner", CheckedOutline)

    local CheckedBackground = Library:New("Frame", {
        Name = "CheckedBackground",
        Parent = CheckedOutline,
        Theme = "ItemBackground",
        BorderSizePixel = 0,
        Position = UDim2.new(0, 1, 0, 1),
        Size = UDim2.new(1, -2, 1, -2),        
    })

    Library:New("UICorner", CheckedBackground)

    local Circle = Library:New("ImageLabel", {
        Name = "CircleImage",
        Parent = CheckedBackground,
        BackgroundTransparency = 1.000,
        Position = UDim2.new(0, 1, 0.5, -8),
        Size = UDim2.new(0, 16, 0, 16),
        Image = Library.Images.Circle,
        Theme = "ControlDisabled",
    })

    local DescriptionText
    if cfg.Description ~= "" then
        DescriptionText = Library:New("TextLabel", {
            Name = "DescriptionText",
            Parent = ToggleBackground,
            BackgroundTransparency = 1.000,
            Size = UDim2.new(1, 0, 0, 0),
            Font = Enum.Font.Gotham,
            Text = cfg.Description,
            Theme = "Text",
            TextSize = 12.000,
            TextWrapped = true,
            AutomaticSize = Enum.AutomaticSize.Y,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
        })

        Library:New("UIPadding", {
            Parent = DescriptionText,
            PaddingBottom = UDim.new(0, 10),
            PaddingLeft = UDim.new(0, 10),
            PaddingRight = UDim.new(0, 10),
            PaddingTop = UDim.new(0, -6),
        })
    end

    function Toggle:Toggle()
        Toggle:Set(not Toggle.Toggled)
    end

    function Toggle:Set(bool)
        Library:ChangeObjectTheme(Circle, bool and "Accent" or "ControlDisabled", true)

        Library:Tween(Circle, true, {Position = bool and UDim2.new(1, -17, 0.5, -8) or UDim2.new(0, 1, 0.5, -8)})

        Toggle.Toggled = bool
    end

    function Toggle:ChangeDescription(text)
        if DescriptionText then
            DescriptionText.Text = text
        end
    end

    function Toggle:ChangeName(text)
        ToggleText.Text = text
    end

    Utility:Connect(ToggleBackground.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Toggle:Toggle()
        end
    end)

    return Toggle
end