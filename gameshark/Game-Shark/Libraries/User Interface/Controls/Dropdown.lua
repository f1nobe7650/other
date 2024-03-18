repeat wait() until Library and Utility

return function(tbl, name, cfg)
    cfg = cfg or {}

    Utility:Default(cfg, {
        Content = {},
        Default = "",
        Multi = false,
        Flag = Library:GetNextFlag(),
        Callback = function() end,
    })

    local Dropdown = {
        FValues = {},
        FValue = cfg.Multi and {} or "",
    }

    local DropdownHolder = Library:New("Frame", {
        Name = "DropdownHolder",
        Parent = tbl.Content,
        BackgroundTransparency = 1.000,
        Size = UDim2.new(1, 0, 0, 44),
        AutomaticSize = Enum.AutomaticSize.Y,
    })
    
    local DropdownName = Library:New("TextLabel", {
        Name = "DropdownName",
        Parent = DropdownHolder,
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
    
    local Inline = Library:New("Frame", {
        Name = "Inline",
        Parent = DropdownHolder,
        Theme = "Inline",
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 22),
        Size = UDim2.new(1, 0, 0, 22),
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
    
    local DropdownValues = Library:New("TextLabel", {
        Name = "DropdownValues",
        Parent = Background,
        BackgroundTransparency = 1.000,
        Position = UDim2.new(0, 6, 0, 0),
        Size = UDim2.new(1, -6, 0, 20),
        FontFace = Library.Font,
        Weight = Enum.FontWeight.Regular,
        Text = "-",
        Theme = "DarkText",
        TextSize = 14.000,
        TextStrokeTransparency = 0.700,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    
    local Content = Library:New("ScrollingFrame", {
        Name = "Content",
        Parent = Inline,
        Active = true,
        BackgroundTransparency = 1.000,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Position = UDim2.new(0, 0, 0, 22),
        Size = UDim2.new(1, 0, 1, -22),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 0,
        VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
    })

    local OpenButton = Library:New("TextButton", {
        Name = "OpenButton",
        Parent = Background,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 0, 22),
        Text = "",
    })
    
    Library:New("UIListLayout", {
        Parent = Content,
        SortOrder = Enum.SortOrder.LayoutOrder,
    })
    
    Library:New("UIPadding", {
        Parent = Content,
        PaddingBottom = UDim.new(0, 3),
        PaddingLeft = UDim.new(0, 7),
        PaddingRight = UDim.new(0, 7),
    })

    local Count = 0

    function Dropdown:CreateValue(name)
        if not Dropdown.FValues[name] then
            local Objects = {}

            Objects.Name = Library:New("TextButton", {
                Name = "DropdownValue",
                Parent = Content,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 20),
                FontFace = Library.Font,
                Weight = Enum.FontWeight.Regular,
                Text = name,
                Theme = "DarkText",
                TextSize = 14.000,
                TextStrokeTransparency = 0.700,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            Library:New("UIPadding", {
                Parent = Objects.Name,
                PaddingTop = UDim.new(0, 3),
                PaddingBottom = UDim.new(0, 3),
            })        

            Objects.Accent = Library:New("Frame", {
                Name = "Accent",
                Parent = Objects.Name,
                Theme = "Accent",
                BorderSizePixel = 0,
                Position = UDim2.new(0, -5, 0, 1),
                Size = UDim2.new(0, 1, 1, -2),
                BackgroundTransparency = 1,
            })
            
            Objects.AccentUnderline = Library:New("Frame", {
                Name = "AccentUnderline",
                Parent = Objects.Name,
                Theme = "Accent",
                BorderSizePixel = 0,
                Position = UDim2.new(0, -6, 0, 0),
                Size = UDim2.new(0, 1, 1, 0),
                BackgroundTransparency = 1,
            })

            local function Click()
                Library:ChangeObjectTheme(Objects.Name, "Text", true)
                Library:Tween(Objects.Accent, true, {BackgroundTransparency = 0})
                Library:Tween(Objects.AccentUnderline, true, {BackgroundTransparency = 0})
                Dropdown.FValues[name].Selected = true
            end

            local function Unclick()
                Library:ChangeObjectTheme(Objects.Name, "DarkText", true)
                Library:Tween(Objects.Accent, true, {BackgroundTransparency = 1})
                Library:Tween(Objects.AccentUnderline, true, {BackgroundTransparency = 1})
                Dropdown.FValues[name].Selected = false
            end

            Utility:Connect(Objects.Name.MouseButton1Down, function()
                Dropdown:Set(name)
            end)
            
            Count += 1

            Dropdown.FValues[name] = {
                Click = Click,
                Unclick = Unclick,
                Objects = Objects,
                Selected = false,
            }
        end

        return Dropdown
    end

    function Dropdown:Update()
        for _, v in pairs(Dropdown.FValues) do
            if Dropdown.FValue == _ then
                v.Click()
            else
                v.Unclick()
            end
        end

        return Dropdown
    end

    function Dropdown:Display()
        if cfg.Multi then
            local CurrentText = {}

            if #Dropdown.FValue > 0 then
                for _,v in pairs(Dropdown.FValue) do
                    CurrentText[#CurrentText + 1] = v

                    local Text = table.concat(CurrentText, ", ")
                    DropdownValues.Text = Text

                    local Size = Utility:GetTextBounds(Text, Library.Font, 14)

                    if Size.X > Content.AbsoluteSize.X - 20 then
                        table.remove(CurrentText, #CurrentText)

                        DropdownValues.Text = table.concat(CurrentText, ", ") .. ", ..."
                        return
                    end
                end
            else
                DropdownValues.Text = "-"
            end
        else
            DropdownValues.Text = Dropdown.FValue ~= "" and Dropdown.FValue or "-"
        end

        return Dropdown
    end

    function Dropdown:Set(value)
        if cfg.Multi then
            if typeof(value) == "table" then
                for _,v in pairs(value) do
                    if not table.find(Dropdown.FValue, _) then
                        Dropdown:Set(v)
                    end
                end

                local RemovedButtons = {}

                for _,v in pairs(Dropdown.FValue) do
                    if not table.find(value, _) then
                        RemovedButtons[#RemovedButtons + 1] = v
                    end
                end

                --[[for _,v in pairs(RemovedButtons) do
                    Dropdown:Set(v)
                end]]

                cfg.Callback(Dropdown.FValue)
                Library.Flags[cfg.Flag] = Dropdown.FValue
                Library.Flags[cfg.Flag .. "f"] = { [1] = function(value) Dropdown:Refresh(value) end, [2] = function(value) Dropdown:Set(value) end }

                return
            end

            local Index = table.find(Dropdown.FValue, value)

            if Index then
                table.remove(Dropdown.FValue, Index)

                Dropdown:Display()

                Dropdown.FValues[value].Unclick()

                cfg.Callback(Dropdown.FValue)
                Library.Flags[cfg.Flag] = Dropdown.FValue
                Library.Flags[cfg.Flag .. "f"] = { [1] = function(value) Dropdown:Refresh(value) end, [2] = function(value) Dropdown:Set(value) end }
            else
                Dropdown.FValue[#Dropdown.FValue + 1] = value

                Dropdown:Display()

                Dropdown.FValues[value].Click()

                cfg.Callback(Dropdown.FValue)
                Library.Flags[cfg.Flag] = Dropdown.FValue
                Library.Flags[cfg.Flag .. "f"] = { [1] = function(value) Dropdown:Refresh(value) end, [2] = function(value) Dropdown:Set(value) end }
            end
        else
            Dropdown.FValue = value

            self:Update()

            Dropdown:Display()
            cfg.Callback(Dropdown.FValue)
            Library.Flags[cfg.Flag] = Dropdown.FValue
            Library.Flags[cfg.Flag .. "f"] = { [1] = function(value) Dropdown:Refresh(value) end, [2] = function(value) Dropdown:Set(value) end }
        end

        return Dropdown
    end
    
    function Dropdown:Refresh(tbl)
        for _,v in pairs(Dropdown.FValues) do
            v.Objects.Name:Destroy()
            v = nil
        end

        table.clear(Dropdown.FValues)

        if cfg.Multi then
            table.clear(Dropdown.FValue)
            Count = 0

            for _,v in pairs(tbl) do
                Dropdown:CreateValue(v)
            end

            Dropdown:Display()

            cfg.Callback(Dropdown.FValue)
            Library.Flags[cfg.Flag] = Dropdown.FValue
            Library.Flags[cfg.Flag .. "f"] = { [1] = function(value) Dropdown:Refresh(value) end, [2] = function(value) Dropdown:Set(value) end }
        else
            Count = 0

            for _,v in pairs(tbl) do
                Dropdown:CreateValue(v)
            end

            Dropdown.FValue = nil

            Dropdown:Update()
            Dropdown:Display()

            cfg.Callback(Dropdown.FValue)
            Library.Flags[cfg.Flag] = Dropdown.FValue
            Library.Flags[cfg.Flag .. "f"] = { [1] = function(value) Dropdown:Refresh(value) end, [2] = function(value) Dropdown:Set(value) end }
        end

        return Dropdown
    end

    function Dropdown:Ret()
        return tbl.Tbl
    end

    function Dropdown:Callback(value)
        cfg.Callback = value

        cfg.Callback(Dropdown.FValue)

        return Dropdown
    end

    function Dropdown:Flag(value)
        Library.Flags[cfg.Flag] = nil
        Library.Flags[cfg.Flag .. "f"] = nil
        Library.ConfigFlags[cfg.Flag] = nil

        cfg.Flag = value

        Library.Flags[cfg.Flag] = Dropdown.FValue
        Library.Flags[cfg.Flag .. "f"] = { [1] = function(value) Dropdown:Refresh(value) end, [2] = function(value) Dropdown:Set(value) end }
        Library.ConfigFlags[cfg.Flag] = function(value) Dropdown:Set(value) end

        return Dropdown
    end

    function Dropdown:Multi(bool)
        cfg.Multi = bool

        Dropdown.FValue = bool and {} or nil

        Dropdown:Refresh(Dropdown.FValues) 

        return Dropdown
    end

    function Dropdown:Value(value)
        cfg.Default = value

        Dropdown:Set(value)

        return Dropdown
    end

    function Dropdown:Values(value)
        cfg.Content = value
        
        Dropdown:Refresh(value)

        return Dropdown
    end

    for _, v in pairs(cfg.Content) do
        Dropdown:CreateValue(v)
    end

    Dropdown:Set(cfg.Default)

    Utility:Connect(OpenButton.MouseButton1Down, function()
        if Inline.Size.Y.Offset == 22 then
            Library:Tween(Inline, true, {Size = UDim2.new(1, 0, 0, math.min((Count + 1) * 22, 102))})
            Library:Tween(DropdownHolder, true, {Size = UDim2.new(1, 0, 0, math.min(((Count + 1) * 22) + 23, 125))})
        else
            Library:Tween(Inline, true, {Size = UDim2.new(1, 0, 0, 22)})
            Library:Tween(DropdownHolder, true, {Size = UDim2.new(1, 0, 0, 45)})
        end
    end)

    Library.ConfigFlags[cfg.Flag] = function(value) Dropdown:Set(value) end

    return Dropdown
end