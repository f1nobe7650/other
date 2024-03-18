repeat wait() until Library and Utility

return function(tbl, name, cfg)
    cfg = cfg or {}

    Utility:Default(cfg, {
        Default = Color3.fromRGB(255, 255, 255),
        Transparency = 1,
        Flag = Library:GetNextFlag(),
        Callback = function() end,
    })

    local Colorpicker = {
        TransparencyValue = 0,
		ColorValue = nil,
		HuePosition = 0,
        SlidingSat = false,
		SlidingHue = false,
		SlidingAlpha = false,
    }

    local ColorpickerHolder = Library:New("Frame", {
        Name = "ColorpickerHolder",
        Parent = tbl.Content,
        BackgroundTransparency = 1.000,
        Size = name ~= "" and UDim2.new(1, 0, 0, 22) or UDim2.new(0, 18, 0, 18),
        ZIndex = 2,
        AutomaticSize = Enum.AutomaticSize.Y,
    })

    if name ~= "" then
        local ColorpickerName = Library:New("TextLabel", {
            Name = "ColorpickerName",
            Parent = ColorpickerHolder,
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
   
    local Inline = Library:New("Frame", {
        Name = "Inline",
        Parent = ColorpickerHolder,
        Theme = "Inline",
        Position = UDim2.new(1, -20, 0, 0),
        Size = UDim2.new(0, 18, 0, 18),
    })

    Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = Inline,
    })
    
    local Background = Library:New("Frame", {
        Name = "Background",
        Parent = Inline,
        Position = UDim2.new(0, 1, 0, 1),
        Size = UDim2.new(1, -2, 1, -2),
    })
    
    Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = Background,
    })

    local ColorpickerButton = Library:New("TextButton", {
        Name = "ColorpickerButton",
        Parent = Background,
        BackgroundTransparency = 1.000,
        Size = UDim2.new(1, 0, 1, 0),
        Text = "",
    })

    local ColorpickerInline = Library:New("Frame", {
        Name = "ColorpickerInline",
        Parent = name ~= "" and ColorpickerHolder or tbl.Content2,
        Theme = "Inline",
        Position = UDim2.new(0, 0, 0, 18),
        Size = UDim2.new(0, 219, 0, 0),
        Visible = false,
        ClipsDescendants = true,
    })
    
    Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = ColorpickerInline,
    })
    
    local ColorpickerBackground = Library:New("Frame", {
        Name = "ColorpickerBackground",
        Parent = ColorpickerInline,
        Theme = "Background",
        Position = UDim2.new(0, 1, 0, 1),
        Size = UDim2.new(1, -2, 1, -2),
    })

    Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = ColorpickerBackground,
    })

    local ColorpickerContent = Library:New("ScrollingFrame", {
        Name = "ColorpickerContent",
        Parent = ColorpickerBackground,
        Active = true,
        BackgroundTransparency = 1.000,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 1, 0),
        CanvasSize = UDim2.new(0, 0, 1, 0),
        ScrollBarThickness = 0,
        VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
    })
    
    Library:New("UIPadding", {
        Parent = ColorpickerContent,
        PaddingBottom = UDim.new(0, 6),
        PaddingLeft = UDim.new(0, 6),
        PaddingRight = UDim.new(0, 6),
        PaddingTop = UDim.new(0, 6),
    })
    
    Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = ColorpickerContent,
    })

    local SaturationInline = Library:New("Frame", {
        Name = "SaturationInline",
        Parent = ColorpickerContent,
        Theme = "Inline",
        Size = UDim2.new(0, 184, 0, 184),
    })
    
    Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = SaturationInline,
    })
    
    local SaturationBackground = Library:New("Frame", {
        Name = "SaturationBackground",
        Parent = SaturationInline,
        Position = UDim2.new(0, 1, 0, 1),
        Size = UDim2.new(1, -2, 1, -2),
    })

    Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = SaturationBackground,
    })
    
    local SaturationImage = Library:New("ImageLabel", {
        Name = "SaturationImage",
        Parent = SaturationBackground,
        BackgroundTransparency = 1.000,
        Size = UDim2.new(1, 0, 1, 0),
        Image = Library.Images.Saturation,
    })
    
    Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = SaturationImage,
    })
    
    local SaturationPicker = Library:New("ImageLabel", {
        Name = "SaturationPicker",
        Parent = SaturationBackground,
        BackgroundTransparency = 1.000,
        Position = UDim2.new(0, -1, 0, -1),
        Size = UDim2.new(0, 5, 0, 5),
        Image = Library.Images.SaturationPicker,
    })

    local SaturationButton = Library:New("TextButton", {
        Name = "SaturationButton",
        Parent = SaturationBackground,
        BackgroundTransparency = 1.000,
        Size = UDim2.new(1, 0, 1, 0),
        Text = "",
    })


    local HueInline = Library:New("Frame", {
        Name = "HueInline",
        Parent = ColorpickerContent,
        Theme = "Inline",
        Position = UDim2.new(1, -15, 0, 0),
        Size = UDim2.new(0, 15, 0, 184),
    })

    Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = HueInline,
    })
    
    local HueBackground = Library:New("Frame", {
        Name = "HueBackground",
        Parent = HueInline,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Position = UDim2.new(0, 1, 0, 1),
        Size = UDim2.new(1, -2, 1, -2),
    })
    
    Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = HueBackground,
    })
    
    Library:New("UIGradient", {
        Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
			ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 0, 255)),
			ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 0, 255)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
			ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 255, 0)),
			ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 255, 0)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
		}),
        Rotation = 90,
        Parent = HueBackground,
    })
    
    local HuePicker = Library:New("ImageLabel", {
        Name = "HuePicker",
        Parent = HueBackground,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1.000,
        Position = UDim2.new(0, -2, 0, -2),
        Size = UDim2.new(0, 17, 0, 5),
        Image = Library.Images.HuePicker,
    })

    local HueButton = Library:New("TextButton", {
        Name = "HueButton",
        Parent = HueBackground,
        BackgroundTransparency = 1.000,
        Size = UDim2.new(1, 0, 1, 0),
        Text = "",
    })


    local TransparencyInline = Library:New("Frame", {
        Name = "TransparencyInline",
        Parent = ColorpickerContent,
        Theme = "Inline",
        Position = UDim2.new(0, 0, 0, 190),
        Size = UDim2.new(0, 184, 0, 15),
        Visible = cfg.Transparency and true or false,
    })
    
    Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = TransparencyInline,
    })
    
    local TransparencyBackground = Library:New("Frame", {
        Name = "TransparencyBackground",
        Parent = TransparencyInline,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Position = UDim2.new(0, 1, 0, 1),
        Size = UDim2.new(1, -2, 1, -2),
    })
    
    Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = TransparencyBackground,
    })
    
    Library:New("UIGradient", {
        Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.57, Color3.fromRGB(150, 150, 150)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))},
        Parent = TransparencyBackground,
    })
    
    local TransparencyPicker = Library:New("ImageLabel", {
        Name = "TransparencyPicker",
        Parent = TransparencyBackground,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1.000,
        Position = UDim2.new(0, -2, 0, -2),
        Size = UDim2.new(0, 5, 0, 17),
        Image = Library.Images.TransparencyPicker,
    })

    local TransparencyButton = Library:New("TextButton", {
        Name = "TransparencyButton",
        Parent = TransparencyBackground,
        BackgroundTransparency = 1.000,
        Size = UDim2.new(1, 0, 1, 0),
        Text = "",
    })

    
    local InlineColor = Library:New("Frame", {
        Name = "Inline",
        Parent = ColorpickerContent,
        Theme = "Inline",
        Position = UDim2.new(0, 190, 0, 190),
        Size = UDim2.new(0, 15, 0, 15),
    })
    
    Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = InlineColor,
    })

    local BackgroundColor = Library:New("Frame", {
        Name = "Background",
        Parent = InlineColor,
        Position = UDim2.new(0, 1, 0, 1),
        Size = UDim2.new(1, -2, 1, -2),
    })
    
    Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = BackgroundColor,
    })

    local Hue, Sat, Val = cfg.Default:ToHSV()

    function Colorpicker:Set(color, trans, ignore)
        if not cfg.Transparency then
            Colorpicker.TransparencyValue = 1
        end

        trans = trans or Colorpicker.TransparencyValue

        if typeof(color) == "table" then
            local OldColor = color

            color = Color3.fromHex(OldColor[1])
            trans = OldColor[2]
        end

        Hue, Sat, Val = color:ToHSV()

        --if Colorpicker.ColorValue  ~= color then
            Colorpicker.ColorValue = color
            Colorpicker.TransparencyValue = trans

            SaturationBackground.BackgroundColor3 = Color3.fromHSV(Colorpicker.HuePosition, 1, 1)
            
            BackgroundColor.BackgroundColor3 = color
            Background.BackgroundColor3 = color

            if not ignore then
                SaturationPicker.Position = UDim2.new(0, math.clamp(Sat * SaturationBackground.AbsoluteSize.X, 0, SaturationBackground.AbsoluteSize.X - 3), 0, math.clamp(SaturationBackground.AbsoluteSize.Y - Val * SaturationBackground.AbsoluteSize.Y, 0, SaturationBackground.AbsoluteSize.Y - 3))
                Colorpicker.HuePosition = Hue
                HuePicker.Position = UDim2.new(0, -2, 1 - Hue, -2)
            
                if cfg.Transparency then
                    TransparencyPicker.Position = UDim2.new(0, math.clamp((1 - trans) * TransparencyBackground.AbsoluteSize.X, 0, TransparencyBackground.AbsoluteSize.X) - 2, 0, -2)
                end
            end
            
            cfg.Callback(Utility:FromRGBA(color.R * 255, color.G * 255, color.B * 255, trans))
            Library.Flags[cfg.Flag] = Utility:FromRGBA(color.R * 255, color.G * 255, color.B * 255, trans)
        --end
    end

    Colorpicker:Set(cfg.Default, cfg.Transparency)

    local function SlideSaturation(input)
        local SizeX = math.clamp((input.Position.X - SaturationBackground.AbsolutePosition.X) / SaturationBackground.AbsoluteSize.X, 0, 1)
        local SizeY = 1 - math.clamp((input.Position.Y - SaturationBackground.AbsolutePosition.Y) / SaturationBackground.AbsoluteSize.Y, 0, 1)
        local PosY = math.clamp(((input.Position.Y - SaturationBackground.AbsolutePosition.Y) / SaturationBackground.AbsoluteSize.Y) * SaturationBackground.AbsoluteSize.Y, 0, SaturationBackground.AbsoluteSize.Y - 3)
        local PosX = math.clamp(((input.Position.X - SaturationBackground.AbsolutePosition.X) / SaturationBackground.AbsoluteSize.X) * SaturationBackground.AbsoluteSize.X, 0, SaturationBackground.AbsoluteSize.X - 3)
        
        SaturationPicker.Position = UDim2.new(0, PosX, 0, PosY)

        Colorpicker:Set(Color3.fromHSV(Colorpicker.HuePosition, SizeX, SizeY), Colorpicker.TransparencyValue, true)
    end

    Utility:Connect(SaturationButton.MouseButton1Down, function(input)
        Colorpicker.SlidingSat = true

        SlideSaturation({ Position = game.UserInputService:GetMouseLocation() - Vector2.new(0, 36) })
    end)

	local function SlideHue(input)
		local SizeY = 1 - math.clamp((input.Position.Y - HueBackground.AbsolutePosition.Y) / HueBackground.AbsoluteSize.Y, 0, 1)
		local PosY = math.clamp(((input.Position.Y - HueBackground.AbsolutePosition.Y) / HueBackground.AbsoluteSize.Y) * HueBackground.AbsoluteSize.Y, 0, HueBackground.AbsoluteSize.Y - 2)
	
		HuePicker.Position = UDim2.new(0, -2, 0, PosY - 2)
		Colorpicker.HuePosition = SizeY

		Colorpicker:Set(Color3.fromHSV(SizeY, Sat, Val), Colorpicker.TransparencyValue, true)
	end

    Utility:Connect(HueButton.MouseButton1Down, function(input)
        Colorpicker.SlidingHue = true

        SlideHue({ Position = game.UserInputService:GetMouseLocation() - Vector2.new(0, 36) })
    end)
    
    local function SlideTrans(input)
		local SizeX = 1 - math.clamp((input.Position.X - TransparencyBackground.AbsolutePosition.X) / TransparencyBackground.AbsoluteSize.X, 0, 1)
        local PosX = math.clamp(((input.Position.X - TransparencyBackground.AbsolutePosition.X) / TransparencyBackground.AbsoluteSize.X) * TransparencyBackground.AbsoluteSize.X, 0, TransparencyBackground.AbsoluteSize.X - 3)

        TransparencyPicker.Position = UDim2.new(0, PosX, 0, -2)

		Colorpicker:Set(Color3.fromHSV(Colorpicker.HuePosition, Sat, Val), SizeX, true)
    end

    Utility:Connect(TransparencyButton.MouseButton1Down, function(input)
        Colorpicker.SlidingAlpha = true

        SlideTrans({ Position = game.UserInputService:GetMouseLocation() - Vector2.new(0, 36) })
    end)

    Utility:Connect(game.UserInputService.InputEnded, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Colorpicker.SlidingSat, Colorpicker.SlidingHue, Colorpicker.SlidingAlpha = false, false, false
        end
    end)

    Utility:Connect(game.UserInputService.InputChanged, function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            if Colorpicker.SlidingSat then
                SlideSaturation(input)
            elseif Colorpicker.SlidingHue then
                SlideHue(input)
            elseif Colorpicker.SlidingAlpha then
                SlideTrans(input)
            end
        end
    end)

    Utility:Connect(ColorpickerButton.MouseButton1Down, function()
        if ColorpickerInline.Visible then
            Library:Tween(ColorpickerInline, true, {Size = UDim2.new(0, 219, 0, 0)})
            Library:Tween(name ~= "" and ColorpickerHolder or tbl.Content2, true, {Size = UDim2.new(1, 0, 0, 18)})

            wait(Library.TweenSpeed)

            ColorpickerInline.Visible = false
        else
            ColorpickerInline.Visible = true

            Library:Tween(ColorpickerInline, true, {Size = UDim2.new(0, 219, 0, 219)})
            Library:Tween(name ~= "" and ColorpickerHolder or tbl.Content2, true, {Size = UDim2.new(1, 0, 0, 237)})
        end
    end)

    function Colorpicker:Color(value)
        cfg.Default = value

        Colorpicker:Set(value)
        
        return Colorpicker
    end

    function Colorpicker:Transparency(value)
        cfg.Transparency = value

        TransparencyInline.Visible = cfg.Transparency and true or false

        Colorpicker:Set(Colorpicker.ColorValue, value)

        return Colorpicker
    end

    function Colorpicker:Callback(value)
        cfg.Callback = value

        Colorpicker:Set(Colorpicker.ColorValue)

        return Colorpicker
    end

    function Colorpicker:Flag(value)
        Library.Flags[cfg.Flag] = nil
        Library.ConfigFlags[cfg.Flag] = nil

        cfg.Flag = value

        Colorpicker:Set(Colorpicker.ColorValue)
        Library.ConfigFlags[cfg.Flag] = function(value) Colorpicker:Set(value) end

        return Colorpicker
    end

    function Colorpicker:Ret()
        return tbl.Tbl
    end

    Library.ConfigFlags[cfg.Flag] = function(value) Colorpicker:Set(value) end
    
    return Colorpicker
end