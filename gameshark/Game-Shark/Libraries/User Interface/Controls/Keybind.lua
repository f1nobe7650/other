repeat wait() until Library and Utility

local UserInputService = game.UserInputService

return function(tbl, name, cfg, intgl)
    cfg = cfg or {}

    Utility:Default(cfg, {
        Mode = "Toggle",
        Key = "",
        Ignore = false,
        Flag = Library:GetNextFlag(),
        Callback = function() end,
    })

    local Keybind = {
        FMode = cfg.Mode,
        FKey = cfg.Key,
        Toggled = false,
        Picking = false,
        Modes = {},
    }

    local KeybindHolder = Library:New("Frame", {
        Name = "KeybindHolder",
        Parent = tbl.Content,
        BackgroundTransparency = 1.000,
        Size = name ~= "" and not intgl and UDim2.new(1, 0, 0, 18) or UDim2.new(0, 0, 0, 0),
        ZIndex = 2,
        AutomaticSize = name ~= "" and not intgl and Enum.AutomaticSize.Y or Enum.AutomaticSize.XY,
    })
    
    if name ~= "" and not intgl then
        local KeybindName = Library:New("TextLabel", {
            Name = "KeybindName",
            Parent = KeybindHolder,
            BackgroundTransparency = 1.000,
            Size = UDim2.new(1, 0, 0, 18),
            FontFace = Library.Font,
            Weight = Enum.FontWeight.Regular,
            Text = name,
            Theme = "Text",
            TextSize = 14.000,
            TextStrokeTransparency = 0.700,
            TextXAlignment = Enum.TextXAlignment.Left,
        })
    end

    local KeybindValue = Library:New("TextLabel", {
        Name = "KeybindValue",
        Parent = KeybindHolder,
        BackgroundTransparency = 1.000,
        Size = name ~= "" and not intgl and UDim2.new(1, 0, 0, 18) or UDim2.new(0, 0, 0, 18),
        FontFace = Library.Font,
        Weight = Enum.FontWeight.Regular,
        Text = "[ " .. Keybind.FKey .. " ]",
        Theme = "Text",
        TextSize = 14.000,
        TextStrokeTransparency = 0.700,
        TextXAlignment = Enum.TextXAlignment.Right,
        AutomaticSize = name ~= "" and not intgl and Enum.AutomaticSize.None or Enum.AutomaticSize.X,
    })

    local KeybindInline = Library:New("Frame", {
        Name = "KeybindInline",
        Parent = KeybindValue,
        Theme = "Inline",
        BorderSizePixel = 0,
        Position = UDim2.new(1, -60, 0, 0),
        Size = UDim2.new(0, 60, 0, 0),
        Visible = false,
        AutomaticSize = Enum.AutomaticSize.Y,
    })

    local KeybindButton = Library:New("TextButton", {
        Name = "KeybindValue",
        Parent = KeybindValue,
        BackgroundTransparency = 1.000,
        Size = UDim2.new(1, 0, 1, 0),
        Text = "",
    })
    
    Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = KeybindInline,
    })
    
    local KeybindBackground = Library:New("Frame", {
        Name = "KeybindBackground",
        Parent = KeybindInline,
        Theme = "Background",
        BorderSizePixel = 0,
        Position = UDim2.new(0, 1, 0, 1),
        Size = UDim2.new(1, -2, 1, -2),
    })
    
    Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = KeybindBackground,
    })
    
    Library:New("UIListLayout", {
        Parent = KeybindBackground,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 2),
    })

    Library:New("UIPadding", {
        Parent = KeybindBackground,
        PaddingBottom = UDim.new(0, 6),
        PaddingLeft = UDim.new(0, 8),
        PaddingTop = UDim.new(0, 4),
    })       
    
    function Keybind:Mode(value)
        Keybind.Modes[value]:Click()

        cfg.Callback(Keybind:GetState())
        Library.Flags[cfg.Flag] = Keybind:GetState()
        Library.Flags[cfg.Flag .. "_info"] = {Keybind.FKey, Keybind.FMode}

        Keybind:UpdateList()

        return Keybind
    end

    function Keybind:Key(value)
        KeybindValue.Text = "[ " .. value .. " ]"
        Keybind.FKey = value
        cfg.Key = value

        cfg.Callback(Keybind:GetState())
        Library.Flags[cfg.Flag] = Keybind:GetState()
        Library.Flags[cfg.Flag .. "_info"] = {Keybind.FKey, Keybind.FMode}

        Keybind:UpdateList()

        return Keybind
    end

    function Keybind:Value(info)
        if info then
            if info[1] then
                local Key = info[1]
                KeybindValue.Text = "[ " .. Key .. " ]"
                Keybind.FKey = Key
            end

            if info[2] then
                Keybind.Modes[info[2]]:Click(info[2] == "Toggle" and true or false)
            end

            Keybind:UpdateList()
        end

        return Keybind
    end

    function Keybind:Callback(value)
        cfg.Callback = value
        Keybind:UpdateList()

        return Keybind
    end

    function Keybind:Flag(value)
        Library.Flags[cfg.Flag] = nil
        Library.Flags[cfg.Flag .. "_info"] = nil
        Library.ConfigFlags[cfg.Flag .. "_info"] = nil

        cfg.Flag = value

        Library.Flags[cfg.Flag] = Keybind:GetState()
        Library.Flags[cfg.Flag .. "_info"] = {Keybind.FKey, Keybind.FMode}
        Library.ConfigFlags[cfg.Flag .. "_info"] = function(info) Keybind:Value(info) end

        Keybind:UpdateList()

        return Keybind
    end

    function Keybind:GetState()
        if Keybind.FMode == "Always" then
            return true
        elseif Keybind.FMode == "Hold" then
            if Keybind.FKey == "" then
                return false
            end

            local Key = Keybind.FKey

            if Key == "MB1" or Key == "MB2" then
                return UserInputService:IsMouseButtonPressed(Key == "MB1" and Enum.UserInputType.MouseButton1 or Enum.UserInputType.MouseButton2)
            else
                return UserInputService:IsKeyDown(Enum.KeyCode[Key])
            end
        else
            if Keybind.FKey == "" then
                return false
            end

            return Keybind.Toggled
        end
    end

    function Keybind:Ret()
        return tbl.Tbl
    end

    function Keybind:Ignore(value)
        cfg.Ignore = value

        if value then
            Library.KeybindList:Remove(name)
        else
            Library.KeybindList:Add({
                FooterLeft = name,
                FooterRight = (Keybind.FMode == "Always" or Keybind.FKey == "") and Keybind.FMode or Keybind.FMode .. ": " .. Keybind.FKey,
            }, name)
        end

        return Keybind
    end

    function Keybind:UpdateList()
        if not cfg.Ignore then
            Library.KeybindList:SetVisibility(Keybind.FMode == "Always" or Keybind.FKey ~= "", name)
            Library.KeybindList:Change("FooterRight", "Text", (Keybind.FMode == "Always" or Keybind.FKey == "") and Keybind.FMode or Keybind.FMode .. ": " .. Keybind.FKey, name)
            Library.KeybindList:ChangeTextTheme(Keybind:GetState() and "Accent" or "Text", name)
        end
    end

    for _,v in pairs({ "Toggle", "Hold", "Always" }) do
        local Button = {}

        Button.ButtonName = Library:New("TextButton", {
            Name = "Toggle",
            Parent = KeybindBackground,
            BackgroundTransparency = 1.000,
            Size = UDim2.new(1, 0, 0, 20),
            FontFace = Library.Font,
            Weight = Enum.FontWeight.Regular,
            Text = v,
            Theme = "DarkText",
            TextSize = 14.000,
            TextStrokeTransparency = 0.700,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 10,
        })
        
        Button.Accent = Library:New("Frame", {
            Name = "Accent",
            Parent = Button.ButtonName,
            Theme = "Accent",
            BorderSizePixel = 0,
            Position = UDim2.new(0, -4, 0, 1),
            Size = UDim2.new(0, 1, 1, -2),
            BackgroundTransparency = 1,
            ZIndex = 10,
        })
        
        Button.AccentUnderline = Library:New("Frame", {
            Name = "AccentUnderline",
            Parent = Button.ButtonName,
            Theme = "Accent",
            BorderSizePixel = 0,
            Position = UDim2.new(0, -5, 0, 0),
            Size = UDim2.new(0, 1, 1, 0),
            BackgroundTransparency = 1,
            ZIndex = 10,
        })

        function Button:Click(igr)
            for _,v in pairs(Keybind.Modes) do
                v:Unclick()
            end

            Keybind.FMode = v

            Library:ChangeObjectTheme(Button.ButtonName, "Text", true)
            Library:Tween(Button.Accent, true, {BackgroundTransparency = 0})
            Library:Tween(Button.AccentUnderline, true, {BackgroundTransparency = 0}) 
            KeybindInline.Visible = false

            Library.Flags[cfg.Flag] = Keybind:GetState()
            Library.Flags[cfg.Flag .. "_info"] = {Keybind.FKey, Keybind.FMode}

            if not igr then
                cfg.Callback(Keybind:GetState())
            end
            Keybind:UpdateList()
        end

        function Button:Unclick()
            Library:ChangeObjectTheme(Button.ButtonName, "DarkText", true)
            Library:Tween(Button.Accent, true, {BackgroundTransparency = 1})
            Library:Tween(Button.AccentUnderline, true, {BackgroundTransparency = 1}) 
        end
            
        if v == Keybind.FMode then
            Button:Click()
        end

        Utility:Connect(Button.ButtonName.MouseButton1Down, Button.Click)

        Keybind.Modes[v] = Button
    end

    Utility:Connect(KeybindButton.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Keybind.Picking = true

            KeybindValue.Text = "[ ]"

            local Break = false
            local Text = ""

            task.spawn(function()
                while not Break do
                    if Text == "..." then
                        Text = ""
                    end

                    Text = Text .. "."

                    KeybindValue.Text =  "[ " .. Text .. " ]"

                    wait(0.5)
                end
            end)

            wait(0.2)

            local Event; Event = Utility:Connect(UserInputService.InputBegan, function(input)
                local Key
                local KeyName = input.KeyCode.Name == "Escape" and "" or Library.Keys[input.KeyCode] or Library.Keys[input.UserInputType] or input.KeyCode.Name

                if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode.Name == "Escape" then
                    Key = ""
                elseif input.UserInputType == Enum.UserInputType.Keyboard then
                    Key = input.KeyCode.Name
                elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Key = "MB1"
                elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                    Key = "MB2"
                end

                Break = true
                Keybind.Picking = false

                KeybindValue.Text = "[ " .. KeyName .. " ]"
                Keybind.FKey = Key

                if Keybind.FMode ~= "Toggle" then
                    cfg.Callback(Keybind:GetState())
                end
                Library.Flags[cfg.Flag] = Keybind:GetState()
                Library.Flags[cfg.Flag .. "_info"] = {Keybind.FKey, Keybind.FMode}
                Keybind:UpdateList()

                Event:Disconnect()
            end)
        end
        
        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            KeybindInline.Visible = not KeybindInline.Visible
        end
    end)
    
    Utility:Connect(UserInputService.InputBegan, function(input)
        if (input.KeyCode.Name or input.UserInputService) == Keybind.FKey then
            cfg.Callback(Keybind:GetState())
            Library.Flags[cfg.Flag] = Keybind:GetState()
            Library.Flags[cfg.Flag .. "_info"] = {Keybind.FKey, Keybind.FMode}
            Keybind:UpdateList()
        end

        if not Keybind.Picking then
            if Keybind.FMode == "Toggle" then
                local Key = Keybind.FKey

                if Key == "MB1" or Key == "MB2" then
                    if Key == "MB1" and input.UserInputType == Enum.UserInputType.MouseButton1 or Key == "MB2" and input.UserInputType == Enum.UserInputType.MouseButton2 then
                        Keybind.Toggled = not Keybind.Toggled
                    end
                else
                    if input.KeyCode.Name == Key then
                        Keybind.Toggled = not Keybind.Toggled
                    end
                end
            end
        end
    end)

    Utility:Connect(UserInputService.InputChanged, function(input)
        --[[if (input.KeyCode.Name or input.UserInputService) == Keybind.FKey then
            cfg.Callback(Keybind:GetState())
            Library.Flags[cfg.Flag] = Keybind:GetState()
            Library.Flags[cfg.Flag .. "_info"] = {Keybind.FKey, Keybind.FMode}
            Keybind:UpdateList()
        end]]

        if not Keybind.Picking then
            if Keybind.FMode == "Toggle" then
                local Key = Keybind.FKey

                if Key == "MB1" or Key == "MB2" then
                    if Key == "MB1" and input.UserInputType == Enum.UserInputType.MouseButton1 or Key == "MB2" and input.UserInputType == Enum.UserInputType.MouseButton2 then
                        Keybind.Toggled = not Keybind.Toggled
                    end
                else
                    if input.KeyCode.Name == Key then
                        Keybind.Toggled = not Keybind.Toggled
                    end
                end
            end
        end
    end)

    Utility:Connect(UserInputService.InputEnded, function(input)
        if (input.KeyCode.Name or input.UserInputService) == Keybind.FKey then
            if Keybind.FMode ~= "Toggle" then
                cfg.Callback(Keybind:GetState())
            end
            Library.Flags[cfg.Flag] = Keybind:GetState()
            Library.Flags[cfg.Flag .. "_info"] = {Keybind.FKey, Keybind.FMode}
            Keybind:UpdateList()
        end
    end)

    if not cfg.Ignore then
        Library.KeybindList:Add({
            FooterLeft = name,
            FooterRight = (Keybind.FMode == "Always" or Keybind.FKey == "") and Keybind.FMode or Keybind.FMode .. ": " .. Keybind.FKey,
        }, name)
    end

    Library.Flags[cfg.Flag] = Keybind:GetState()
    Library.Flags[cfg.Flag .. "_info"] = {Keybind.FKey, Keybind.FMode}

    Library.ConfigFlags[cfg.Flag .. "_info"] = function(info) Keybind:Value(info) end

    return Keybind
end