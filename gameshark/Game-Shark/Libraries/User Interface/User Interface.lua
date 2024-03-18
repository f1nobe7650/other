repeat wait() until Utility

local UserInputService = game.UserInputService
local TweenService = game.TweenService
local RunService = game.RunService
local HttpService = game.HttpService
local NewRGB = Color3.fromRGB
local NewHSV = Color3.fromHSV
local NewInst = Instance.new
local NewVector = Vector2.new
local NewUdim2 = UDim2.new
local NewUdim = UDim.new

Utility:Notify({
    Title = "GameShark",
    Description = "User Interface Loaded.",
    Time = 10,
})

local Library = {
	Drawings = {},
	Flags = {},
	ConfigFlags = {},
	Folder = "Game-Shark",
	Theme = {
        Inline = NewRGB(52, 52, 52),
        Background = NewRGB(24, 24, 24),
        Accent = NewRGB(0, 174, 255),
        Text = NewRGB(200, 200, 200),
        NavBackground = NewRGB(32, 32, 32),
        SectionBackground = NewRGB(27, 27, 27),
        ListBackground = NewRGB(27, 27, 27),
        WatermarkBackground = NewRGB(27, 27, 27),
        TabDisabled = NewRGB(150, 150, 150),
        DarkText = NewRGB(150, 150, 150),
	},
    Images = {
        Circle = "rbxassetid://14087443494",
        Check = "rbxassetid://14087347755",
        SaturationPicker = "rbxassetid://13900819741",
        Saturation = "rbxassetid://13901004307",
        HuePicker = "rbxassetid://13900818694",
        TransparencyPicker = "rbxassetid://14248606745",
    },
	ThemeObjects = {},
	TweenSpeed = 0.25,
	TweenType = Enum.EasingStyle.Quint,
	ScreenGui = NewInst("ScreenGui", game.CoreGui),
    Interactions = {},
    Font = Font.fromId(11702779409),
    IsOpening = false,
	Open = true,
    Fps = 0,
    Game = "",
    Version = "",
    User = "",
    Keys = {
        [Enum.KeyCode.LeftShift] = "LS",
        [Enum.KeyCode.RightShift] = "RS",
        [Enum.KeyCode.LeftControl] = "LC",
        [Enum.KeyCode.RightControl] = "RC",
        [Enum.KeyCode.LeftAlt] = "LA",
        [Enum.KeyCode.RightAlt] = "RA",
        [Enum.KeyCode.CapsLock] = "CAPS",
        [Enum.KeyCode.Return] = "ENT",
        [Enum.KeyCode.PageDown] = "PGD",
        [Enum.KeyCode.PageUp] = "PGU",
        [Enum.KeyCode.ScrollLock] = "SCL",
        [Enum.KeyCode.One] = "1",
        [Enum.KeyCode.Two] = "2",
        [Enum.KeyCode.Three] = "3",
        [Enum.KeyCode.Four] = "4",
        [Enum.KeyCode.Five] = "5",
        [Enum.KeyCode.Six] = "6",
        [Enum.KeyCode.Seven] = "7",
        [Enum.KeyCode.Eight] = "8",
        [Enum.KeyCode.Nine] = "9",
        [Enum.KeyCode.Zero] = "0",
        [Enum.KeyCode.KeypadOne] = "1",
        [Enum.KeyCode.KeypadTwo] = "2",
        [Enum.KeyCode.KeypadThree] = "3",
        [Enum.KeyCode.KeypadFour] = "4",
        [Enum.KeyCode.KeypadFive] = "5",
        [Enum.KeyCode.KeypadSix] = "6",
        [Enum.KeyCode.KeypadSeven] = "7",
        [Enum.KeyCode.KeypadEight] = "8",
        [Enum.KeyCode.KeypadNine] = "9",
        [Enum.KeyCode.KeypadZero] = "0",
        [Enum.KeyCode.Minus] = "-",
        [Enum.KeyCode.Equals] = "=",
        [Enum.KeyCode.Tilde] = "~",
        [Enum.KeyCode.LeftBracket] = "[",
        [Enum.KeyCode.RightBracket] = "]",
        [Enum.KeyCode.RightParenthesis] = ")",
        [Enum.KeyCode.LeftParenthesis] = "(",
        [Enum.KeyCode.Semicolon] = ",",
        [Enum.KeyCode.Quote] = "'",
        [Enum.KeyCode.BackSlash] = "\\",
        [Enum.KeyCode.Comma] = ",",
        [Enum.KeyCode.Period] = ".",
        [Enum.KeyCode.Slash] = "/",
        [Enum.KeyCode.Asterisk] = "*",
        [Enum.KeyCode.Plus] = "+",
        [Enum.KeyCode.Period] = ".",
        [Enum.KeyCode.Backquote] = "`",
        [Enum.KeyCode.Insert] = "INS",
        [Enum.UserInputType.MouseButton1] = "MB1",
        [Enum.UserInputType.MouseButton2] = "MB2",
        [Enum.UserInputType.MouseButton3] = "MB3",
        [Enum.KeyCode.Backspace] = "BS",
        [Enum.KeyCode.Escape] = "ESC",
        [Enum.KeyCode.Space] = "SPC",
    }
}

if not isfolder(Library.Folder) then
    makefolder(Library.Folder)
end

if not isfolder(Library.Folder .. "/Configs") then
    makefolder(Library.Folder .. "/Configs")
end

function Library:GetCenter(size)
	return NewUdim2(0.5, -(size.X.Offset / 2), 0.5, -(size.Y.Offset / 2))
end

function Library:New(class, prop, ignore)
    prop = prop or {}

	local obj = Utility:NewObject(class, {}, ignore and nil or Library.Drawings)

    if typeof(prop) == "table" then
        for _,v in pairs(prop) do
            if _ == "Theme" then
                if obj:IsA("UIGradient") then
                    Library.ThemeObjects[obj] = v
                    obj.Color = Library.Theme[v]
                elseif obj:IsA("ImageButton") or obj:IsA("ImageLabel") then
                    Library.ThemeObjects[obj] = v
                    obj.ImageColor3 = Library.Theme[v]
                elseif obj:IsA("TextButton") then
                    Library.ThemeObjects[obj] = v
                    obj.TextColor3 = Library.Theme[v]
                elseif obj:IsA("TextBox") then
                    Library.ThemeObjects[obj] = v
                    obj.TextColor3 = Library.Theme[v]
                elseif obj:IsA("ScrollingFrame") then
                    Library.ThemeObjects[obj] = v
                    obj.ScrollBarImageColor3 = Library.Theme[v]
                elseif obj:IsA("TextLabel") then
                    Library.ThemeObjects[obj] = v
                    obj.TextColor3 = Library.Theme[v]
                else
                    Library.ThemeObjects[obj] = v
                    obj.BackgroundColor3 = Library.Theme[v]
                end
            elseif _ == "Weight" then
                obj.FontFace.Weight = v
            else
                obj[_] = v
            end
        end
    else
        obj.Parent = prop
    end

    pcall(function()
        obj.BorderSizePixel = 0
    end)

	return obj
end

function Library:ChangeTheme(theme, color)
	Library.Theme[theme] = color

	for obj,v in pairs(Library.ThemeObjects) do
		if theme == v then
			if obj:IsA("UIGradient") then
				obj.Color = color
			elseif obj:IsA("ImageButton") or obj:IsA("ImageLabel") then
				obj.ImageColor3 = color
			elseif obj:IsA("TextButton") then
				obj.TextColor3 = color
			elseif obj:IsA("TextBox") then
				obj.TextColor3 = color
			elseif obj:IsA("ScrollingFrame") then
				obj.ScrollBarImageColor3 = color
			elseif obj:IsA("TextLabel") then
				obj.TextColor3 = color
			else
				obj.BackgroundColor3 = color
			end
		end
	end
end

function Library:Drag(object, dragobj)
	local Start, ObjectPosition, Dragging, CurrentPosition

	Utility:Connect(dragobj.InputBegan, function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			Dragging = true
			Start = input.Position
			ObjectPosition = object.Position
		end
	end)

	Utility:Connect(UserInputService.InputChanged, function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement and Dragging then
			CurrentPosition = NewUdim2(ObjectPosition.X.Scale, ObjectPosition.X.Offset + (input.Position - Start).X, ObjectPosition.Y.Scale, ObjectPosition.Y.Offset + (input.Position - Start).Y)
			object.Position = CurrentPosition
		end
	end)

	Utility:Connect(UserInputService.InputEnded, function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and Dragging then
			Dragging = false
		end
	end)
end

function Library:Tween(obj, info, values)
	info = info == true and TweenInfo.new(Library.TweenSpeed, Library.TweenType) or info

	local Tween = TweenService:Create(obj, info, values)

	Tween:Play()

	return Tween
end

function Library:TextTriggers(text)
	local Triggers = {
		['{user}'] = Library.User,
		['{hour}'] = os.date("%H"),
		['{minute}'] = os.date("%M"),
		['{second}'] = os.date("%S"),
		['{ap}'] = os.date("%p"),
		['{month}'] = os.date("%b"),
		['{day}'] = os.date("%d"),
		['{year}'] = os.date("%Y"),
		['{version}'] = Library.Version,
		['{fps}'] = Library.Fps,
		['{ping}'] = math.floor(game.Stats.PerformanceStats.Ping:GetValue() or 0),
		['{game}'] = Library.Game,
		['{time}'] = os.date("%H:%M:%S"),
		['{date}'] = os.date("%b. %d, %Y")
	}

	for i, v in pairs(Triggers) do
		text = string.gsub(text, i, v)
	end

	return Utility:FindRandomText(text)
end

function Library:ChangeObjectTheme(obj, theme, tween)
	if tween then
		if obj:IsA("UIGradient") then
			Library.ThemeObjects[obj] = theme
			Library:Tween(obj, true, {Color = Library.Theme[theme]})
		elseif obj:IsA("TextButton") then
			Library.ThemeObjects[obj] = theme
			Library:Tween(obj, true, {TextColor3 = Library.Theme[theme]})
		elseif obj:IsA("TextBox") then
			Library.ThemeObjects[obj] = theme
			Library:Tween(obj, true, {TextColor3 = Library.Theme[theme]})
		elseif obj:IsA("ImageButton") or obj:IsA("ImageLabel") then
			Library.ThemeObjects[obj] = theme
			Library:Tween(obj, true, {ImageColor3 = Library.Theme[theme]})
		elseif obj:IsA("ScrollingFrame") then
			Library.ThemeObjects[obj] = theme
			Library:Tween(obj, true, {ScrollBarImageColor3 = Library.Theme[theme]})
		elseif obj:IsA("TextLabel") then
			Library.ThemeObjects[obj] = theme
			Library:Tween(obj, true, {TextColor3 = Library.Theme[theme]})
		else
			Library.ThemeObjects[obj] = theme
			Library:Tween(obj, true, {BackgroundColor3 = Library.Theme[theme]})
		end
	else
		if obj:IsA("UIGradient") then
			Library.ThemeObjects[obj] = theme
			obj.Color = Library.Theme[theme]
		elseif obj:IsA("ImageButton") or obj:IsA("ImageLabel") then
			Library.ThemeObjects[obj] = theme
			obj.ImageColor3 = Library.Theme[theme]
		elseif obj:IsA("TextButton") then
			Library.ThemeObjects[obj] = theme
			obj.TextColor3 = Library.Theme[theme]
		elseif obj:IsA("TextBox") then
			Library.ThemeObjects[obj] = theme
			obj.TextColor3 = Library.Theme[theme]
		elseif obj:IsA("ScrollingFrame") then
			Library.ThemeObjects[obj] = theme
			obj.ScrollBarImageColor3 = Library.Theme[theme]
		elseif obj:IsA("TextLabel") then
			Library.ThemeObjects[obj] = theme
			obj.TextColor3 = Library.Theme[theme]
		else
			Library.ThemeObjects[obj] = theme
			obj.BackgroundColor3 = Library.Theme[theme]
		end
	end
end

function Library:Round(number, float)
	return float * math.round(number / float)
end

local FlagCount = 0
function Library:GetNextFlag()
    FlagCount = FlagCount + 1
    return tostring(FlagCount)
end

function Library:Window(cfg)
    cfg = cfg or {}

    Utility:Default(cfg, {
        Size = UDim2.new(0, 500, 0, 400),
        Name = "Game Shark",
        FooterLeft = "Universal",
        FooterRight = "Alpha",
    })

    local Window = {
        Selected = nil,
        Tabs = {},
    }

    local Inline = Library:New("Frame", {
        Name = "Inline",
        Parent = Library.ScreenGui,
        Theme = "Inline",
        BorderSizePixel = 0,
        Position = Library:GetCenter(cfg.Size),
        Size = UDim2.new(0, 500, 0, 400),
    })

    Library.KeybindList = Library:List({
        Name = "Keybinds"
    })

    Library.Holder = Inline

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

    local Inline2 = Library:New("Frame", {
        Name = "Inline",
        Parent = Background,
        Theme = "Inline",
        BorderSizePixel = 0,
        Position = UDim2.new(0, 1, 0, 1),
        Size = UDim2.new(1, -2, 1, -2),
    })

    Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = Inline2,
    })

    local Background2 = Library:New("Frame", {
        Name = "Background",
        Parent = Inline2,
        Theme = "Background",
        BorderSizePixel = 0,
        Position = UDim2.new(0, 1, 0, 1),
        Size = UDim2.new(1, -2, 1, -2),
    })

    Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = Background2,
    })

    local TopBarBackground = Library:New("Frame", {
        Name = "TopBarBackground",
        Parent = Background2,
        Theme = "NavBackground",
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 30),
    })

    Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = TopBarBackground,
    })

    Library:New("Frame", {
        Name = "Accent",
        Parent = TopBarBackground,
        Theme = "Accent",
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 1, -2),
        Size = UDim2.new(1, 0, 0, 2),
    })

    local CheatName = Library:New("TextLabel", {
        Name = "CheatName",
        Parent = TopBarBackground,
        BackgroundTransparency = 1.000,
        Position = UDim2.new(0, 6, 0, 0),
        Size = UDim2.new(1, 0, 1, -2),
        FontFace = Library.Font,
	    Weight = Enum.FontWeight.Regular,
        Text = cfg.Name,
        Theme = "Text",
        TextSize = 14.000,
        TextStrokeTransparency = 0.700,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    local TabHolder = Library:New("Frame", {
        Name = "TabHolder",
        Parent = TopBarBackground,
        BackgroundTransparency = 1.000,
        Size = UDim2.new(1, 0, 1, -2),
    })

    Library:New("UIListLayout", {
        Parent = TabHolder,
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = UDim.new(0, 6),
    })

    Library:New("UIPadding", {
        Parent = TabHolder,
        PaddingLeft = UDim.new(0, 6),
        PaddingRight = UDim.new(0, 6),
    })

    local BottomBarBackground = Library:New("Frame", {
        Name = "BottomBarBackground",
        Parent = Background2,
        Theme = "NavBackground",
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 1, -23),
        Size = UDim2.new(1, 0, 0, 23),
    })

    Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = BottomBarBackground,
    })

    Library:New("Frame", {
        Name = "Accent",
        Parent = BottomBarBackground,
        Theme = "Accent",
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 2),
    })

    local FooterTextLeft = Library:New("TextLabel", {
        Name = "FooterTextLeft",
        Parent = BottomBarBackground,
        BackgroundTransparency = 1.000,
        Position = UDim2.new(0, 6, 0, 2),
        Size = UDim2.new(1, -6, 1, -2),
        FontFace = Library.Font,
        Weight = Enum.FontWeight.Regular,
        Text = cfg.FooterLeft,
        Theme = "Text",
        TextSize = 14.000,
        TextStrokeTransparency = 0.700,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    local FooterTextRight = Library:New("TextLabel", {
        Name = "FooterTextRight",
        Parent = BottomBarBackground,
        BackgroundTransparency = 1.000,
        Position = UDim2.new(0, 0, 0, 2),
        Size = UDim2.new(1, -6, 1, -2),
        FontFace = Library.Font,
        Weight = Enum.FontWeight.Regular,
        Text = cfg.FooterRight,
        Theme = "Text",
        TextSize = 14.000,
        TextStrokeTransparency = 0.700,
        TextXAlignment = Enum.TextXAlignment.Right,
    })

    local TopDragPart = Library:New("Frame", {
        Name = "TopDragPart",
        Parent = Background2,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 30),
    })

    Library:Drag(Inline, TopDragPart)

    function Window:Ret()
        return Window
    end

    function Window:Select(tab)
        self.Selected = tab
        self:Update()
    end

    function Window:Update()
        for _,v in pairs(self.Tabs) do
            local Objects = v.Objects
            if self.Selected == v then
                Library:ChangeObjectTheme(Objects.TabName, "Text", true)
                Library:Tween(Objects.Accent, true, {BackgroundTransparency = 0})
                Library:Tween(Objects.AccentUnderline, true, {BackgroundTransparency = 0})
                Objects.SectionHolder.Visible = true
            else
                Library:ChangeObjectTheme(Objects.TabName, "TabDisabled", true)
                Library:Tween(Objects.Accent, true, {BackgroundTransparency = 1})
                Library:Tween(Objects.AccentUnderline, true, {BackgroundTransparency = 1})
                Objects.SectionHolder.Visible = false
            end
        end
    end

    function Window:Name(name)
        CheatName.Text = name

        return Window
    end

    function Window:LeftFooter(text)
        FooterTextLeft.Text = text

        return Window
    end

    function Window:RightFooter(text)
        FooterTextRight.Text = text

        return Window
    end

    function Window:Size(size)
        Inline.Size = size

        return Window
    end

    function Window:Add(type, name, cfg)
        if type == "Tab" then
            cfg = cfg or {}

            Utility:Default(cfg, {})

            local Objects = {}

            Objects.TabButton = Library:New("TextButton", {
                Name = "TabButton",
                Parent = TabHolder,
                BackgroundTransparency = 1.000,
                AutomaticSize = Enum.AutomaticSize.X,
                Size = UDim2.new(0, 0, 1, 0),
                Text = "",
            })

            Library:New("UIPadding", {
                Parent = Objects.TabButton,
                PaddingLeft = UDim.new(0, 6),
                PaddingRight = UDim.new(0, 6),
            })

            Objects.TabName = Library:New("TextLabel", {
                Name = "TabName",
                Parent = Objects.TabButton,
                BackgroundTransparency = 1.000,
                AutomaticSize = Enum.AutomaticSize.X,
                Size = UDim2.new(1, 0, 1, 0),
                FontFace = Library.Font,
                Weight = Enum.FontWeight.Regular,
                Text = name,
                Theme = "TabDisabled",
                TextSize = 14.000,
                TextStrokeTransparency = 0.700,
            })

            Objects.Accent = Library:New("Frame", {
                Name = "Accent",
                BackgroundTransparency = 1.000,
                Parent = Objects.TabButton,
                Theme = "Accent",
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 1, -2),
                Size = UDim2.new(1, 0, 0, 1),
            })

            Objects.AccentUnderline = Library:New("Frame", {
                Name = "AccentUnderline",
                BackgroundTransparency = 1.000,
                Parent = Objects.TabButton,
                Theme = "Accent",
                BorderSizePixel = 0,
                Position = UDim2.new(0, -1, 1, -1),
                Size = UDim2.new(1, 2, 0, 1),
            })

            Objects.SectionHolder = Library:New("Frame", {
                Name = "SectionHolder",
                Parent = Background2,
                BackgroundTransparency = 1.000,
                Position = UDim2.new(0, 0, 0, 30),
                Size = UDim2.new(1, 0, 1, -53),
            })

            Library:New("UIPadding", {
                Parent = Objects.SectionHolder,
                PaddingBottom = UDim.new(0, 8),
                PaddingLeft = UDim.new(0, 8),
                PaddingRight = UDim.new(0, 8),
                PaddingTop = UDim.new(0, 8),
            })

            Library:New("UIListLayout", {
                Parent = Objects.SectionHolder,
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 4),
            })

            Objects.Left = Library:New("ScrollingFrame", {
                Name = "Left",
                Parent = Objects.SectionHolder,
                Active = true,
                BackgroundTransparency = 1.000,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                Size = UDim2.new(0.5, -2, 1, 0),
                CanvasSize = UDim2.new(0, 0, 0, 0),
                ScrollBarThickness = 0,
                VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
            })

            Library:New("UIListLayout", {
                Parent = Objects.Left,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 5),
            })

            Objects.Right = Library:New("ScrollingFrame", {
                Name = "Right",
                Parent = Objects.SectionHolder,
                Active = true,
                BackgroundTransparency = 1.000,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                Size = UDim2.new(0.5, -2, 1, 0),
                CanvasSize = UDim2.new(0, 0, 0, 0),
                ScrollBarThickness = 0,
                VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
            })

            Library:New("UIListLayout", {
                Parent = Objects.Right,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 5),
            })

            local Tab = {
                Window = self,
                Objects = Objects,
                Sections = {},
            }

            function Tab:Add(type, name, cfg)
                if type == "Section" then
                    cfg = cfg or {}

                    Utility:Default(cfg, {
                        Side = "Left",
                        Size = 0,
                        Scale = 1,
                    })

                    cfg.Side = cfg.Side:lower() == "left" and Objects.Left or Objects.Right

                    local Inline = Library:New("Frame", {
                        Name = "Inline",
                        Parent = cfg.Side,
                        Theme = "Inline",
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, cfg.Scale, cfg.Size),
                        AutomaticSize = Enum.AutomaticSize.Y,
                    })

                    Library:New("UICorner", {
                        CornerRadius = UDim.new(0, 5),
                        Parent = Inline,
                    })

                    local Background = Library:New("Frame", {
                        Name = "Background",
                        Parent = Inline,
                        Theme = "SectionBackground",
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 1, 0, 1),
                        Size = UDim2.new(1, -2, 1, -2),
                    })

                    Library:New("UICorner", {
                        CornerRadius = UDim.new(0, 5),
                        Parent = Background,
                    })

                    local TitleBackground = Library:New("Frame", {
                        Name = "TitleBackground",
                        Parent = Background,
                        Theme = "NavBackground",
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, 0, 30),
                    })

                    Library:New("UICorner", {
                        CornerRadius = UDim.new(0, 5),
                        Parent = TitleBackground,
                    })

                    Library:New("Frame", {
                        Name = "Accent",
                        Parent = TitleBackground,
                        Theme = "Accent",
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 0, 1, -2),
                        Size = UDim2.new(1, 0, 0, 2),
                    })

                    local SectionName = Library:New("TextLabel", {
                        Name = "SectionName",
                        Parent = TitleBackground,
                        BackgroundTransparency = 1.000,
                        Size = UDim2.new(1, 0, 1, -2),
                        FontFace = Library.Font,
                        Weight = Enum.FontWeight.Regular,
                        Text = name,
                        Theme = "Text",
                        TextSize = 14.000,
                        TextStrokeTransparency = 0.700,
                    })

                    local Content = Library:New("ScrollingFrame", {
                        Name = "Content",
                        Parent = Background,
                        Active = true,
                        BackgroundTransparency = 1.000,
                        AutomaticCanvasSize = Enum.AutomaticSize.Y,
                        Position = UDim2.new(0, 0, 0, 30),
                        Size = UDim2.new(1, 0, 1, -30),
                        CanvasSize = UDim2.new(0, 0, 0, 0),
                        ScrollBarThickness = 0,
                        VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
                    })

                    Library:New("UIPadding", {
                        Parent = Content,
                        PaddingBottom = UDim.new(0, 8),
                        PaddingLeft = UDim.new(0, 8),
                        PaddingRight = UDim.new(0, 8),
                        PaddingTop = UDim.new(0, 8),
                    })

                    Library:New("UIListLayout", {
                        Parent = Content,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = UDim.new(0, 5),
                    })

                    local Section = {
                        Content = Content,
                        Tab = Tab,
                        Tbl = Section,
                    }

                    Section.Tbl = Section

                    function Section:Ret()
                        return Tab
                    end

                    function Section:Side(side)
                        cfg.Side = side
                        cfg.Side = cfg.Side:lower() == "left" and Objects.Left or Objects.Right

                        Inline.Parent = cfg.Side

                        return Section
                    end

                    function Section:Size(size)
                        cfg.Size = size

                        Inline.Size = UDim2.new(1, 0, cfg.Scale, cfg.Size)

                        return Section
                    end

                    function Section:Scale(scale)
                        cfg.Scale = scale

                        Inline.Size = UDim2.new(1, 0, cfg.Scale, cfg.Size)

                        return Section
                    end

                    function Section:Add(type, name, tbl)
                        tbl = tbl or {}

                        local InterfaceTable = getgenv()[type](Section, name, tbl)

                        return InterfaceTable
                    end

                    return Section
                end
            end

            function Tab:Ret()
                return Window
            end

            Utility:Connect(Objects.TabButton.MouseButton1Down, function()
                Window:Select(Tab)
            end)

            Window.Tabs[#Window.Tabs + 1] = Tab

            if #Window.Tabs == 1 then
                Window:Select(Tab)
            end

            self:Update()

            return Tab
        end
    end

    return Window
end

function Library:GetConfig()
    local ConfigTable = {}

    for _,v in pairs(Library.ConfigFlags) do
        local Value = Library.Flags[_]

        if typeof(Value) == "EnumItem" then
            ConfigTable[_] = Value
		elseif typeof(Value) == "Color3" then
			ConfigTable[_] = { Value:ToHex(), Value.a }
        else
            ConfigTable[_] = Value
        end
    end

    return HttpService:JSONEncode(ConfigTable)
end

function Library:LoadConfig(config)
    local Config = HttpService:JSONDecode(config)

    for _,v in pairs(Config) do
        local Func = Library.ConfigFlags[_]

        if Func then
            Func(v)
        end
    end
end

function Library:SetOpen(bool)
    Library.Holder.Visible = bool
    Library.Open = bool
end

function Library:List(cfg)
    cfg = cfg or {}

    Utility:Default(cfg, {
        Name = "New List",
        Size = 200,
    })

    local List = {}
    local Content = {}

    local Inline = Library:New("Frame", {
        Name = "Inline",
        Parent = Library.ScreenGui,
        Theme = "Inline",
        Position = UDim2.new(0, 20, 0.5, 0),
        Size = UDim2.new(0, cfg.Size, 0, 40),
        AutomaticSize = Enum.AutomaticSize.Y,
    })

    Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = Inline,
    })

    local Background = Library:New("Frame", {
        Name = "Background",
        Parent = Inline,
        Theme = "ListBackground",
        Position = UDim2.new(0, 1, 0, 1),
        Size = UDim2.new(1, -2, 1, -2),
    })

    Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = Background,
    })

    local TitleBackground = Library:New("Frame", {
        Name = "TitleBackground",
        Parent = Background,
        Theme = "NavBackground",
        ClipsDescendants = true,
        Size = UDim2.new(1, 0, 0, 30),
    })

    Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = TitleBackground,
    })

    local ListName = Library:New("TextLabel", {
        Name = "ListName",
        Parent = TitleBackground,
        BackgroundTransparency = 1.000,
        Size = UDim2.new(1, 0, 1, -2),
        FontFace = Library.Font,
        Weight = Enum.FontWeight.Regular,
        Text = cfg.Name,
        Theme = "Text",
        TextSize = 14.000,
        TextStrokeTransparency = 0.700,
    })

    Library:Drag(Inline, ListName)

    local Accent = Library:New("Frame", {
        Name = "Accent",
        Parent = TitleBackground,
        Theme = "Accent",
        Position = UDim2.new(0, 0, 1, -2),
        Size = UDim2.new(1, 0, 0, 20),
    })

    Library:New("UICorner", {
        Parent = Accent,
    })

    local ContentHolder = Library:New("Frame", {
        Name = "Content",
        Parent = Background,
        BackgroundTransparency = 1.000,
        Position = UDim2.new(0, 0, 0, 30),
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
    })

    Library:New("UIListLayout", {
        Parent = ContentHolder,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 2),
    })

    Library:New("UIPadding", {
        Parent = ContentHolder,
        PaddingBottom = UDim.new(0, 5),
        PaddingTop = UDim.new(0, 5),
    })

    function List:Add(cfg, key)
        cfg = cfg or {}

        if not Content[key] then
            Utility:Default(cfg, {
                FooterLeft = "",
                FooterRight = "",
            })

            local Holder = Library:New("Frame", {
                Name = "Holder",
                Parent = ContentHolder,
                BackgroundTransparency = 1.000,
                Size = UDim2.new(1, 0, 0, 20),
            })

            local FooterLeft = Library:New("TextLabel", {
                Name = "FooterLeft",
                Parent = Holder,
                BackgroundTransparency = 1.000,
                Size = UDim2.new(1, 0, 0, 20),
                FontFace = Library.Font,
                Weight = Enum.FontWeight.Regular,
                Text = cfg.FooterLeft,
                Theme = "Text",
                TextSize = 14.000,
                TextStrokeTransparency = 0.700,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            Library:New("UIPadding", {
                Parent = FooterLeft,
                PaddingLeft = UDim.new(0, 5),
                PaddingRight = UDim.new(0, 5),
            })

            local FooterRight = Library:New("TextLabel", {
                Name = "FooterRight",
                Parent = Holder,
                BackgroundTransparency = 1.000,
                Size = UDim2.new(1, 0, 0, 20),
                FontFace = Library.Font,
                Weight = Enum.FontWeight.Regular,
                Text = cfg.FooterRight,
                Theme = "Text",
                TextSize = 14.000,
                TextStrokeTransparency = 0.700,
                TextXAlignment = Enum.TextXAlignment.Right,
            })

            Library:New("UIPadding", {
                Parent = FooterRight,
                PaddingLeft = UDim.new(0, 5),
                PaddingRight = UDim.new(0, 5),
            })

            Content[key] = {Holder = Holder, FooterLeft = FooterLeft, FooterRight = FooterRight}
        end
    end

    function List:Change(item, prop, newval, key)
        if Content[key] then
            local ContentTbl = Content[key]

            if ContentTbl[item] and ContentTbl[item][prop] then
                ContentTbl[item][prop] = newval
            end
        end
    end

    function List:ChangeTextTheme(theme, key)
        if Content[key] then
            Library:ChangeObjectTheme(Content[key].FooterLeft, theme, true)
            Library:ChangeObjectTheme(Content[key].FooterRight, theme, true)
        end
    end

    function List:Remove(key)
        if Content[key] then
            Content[key].Holder:Destroy()
            Content[key] = nil
        end
    end

    function List:Visible(bool)
        Inline.Visible = bool
    end

    function List:SetVisibility(bool, key)
        if Content[key] then
            Content[key].Holder.Visible = bool
        end
    end

    return List, Content
end

function Library:Watermark(cfg)
    cfg = cfg or {}

    Utility:Default(cfg, {
        Visible = true,
        Text = "Game Shark | {user} | {date} | {fps}: fps",
        Tickrate = 100,
    })

    local Watermark = {
        Tick = tick(),
    }

    local Inline = Library:New("Frame", {
        Name = "Inline",
        Parent = Library.ScreenGui,
        Theme = "Inline",
        ClipsDescendants = true,
        Position = UDim2.new(0, 20, 0, 50),
        Size = UDim2.new(0, 296, 0, 32),
        Visible = cfg.Visible,
    })

    Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = Inline,
    })

    local Background = Library:New("Frame", {
        Name = "Background",
        Parent = Inline,
        Theme = "WatermarkBackground",
        ClipsDescendants = true,
        Position = UDim2.new(0, 1, 0, 1),
        Size = UDim2.new(1, -2, 1, -2),
    })

    Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = Background,
    })

    local TitleBackground = Library:New("Frame", {
        Name = "TitleBackground",
        Parent = Background,
        Theme = "NavBackground",
        ClipsDescendants = true,
        Size = UDim2.new(1, 0, 0, 30),
    })

    Library:New("UICorner", {
        CornerRadius = UDim.new(0, 5),
        Parent = TitleBackground,
    })

    local Accent = Library:New("Frame", {
        Name = "Accent",
        Parent = TitleBackground,
        Theme = "Accent",
        Position = UDim2.new(0, 0, 1, -2),
        Size = UDim2.new(1, 0, 0, 20),
    })

    Library:New("UICorner", {
        Parent = Accent,
    })

    local WatermarkName = Library:New("TextLabel", {
        Name = "WatermarkName",
        Parent = TitleBackground,
        BackgroundTransparency = 1.000,
        Size = UDim2.new(1, 0, 1, -2),
        FontFace = Library.Font,
        Weight = Enum.FontWeight.Regular,
        Theme = "Text",
        TextSize = 14.000,
        MaxVisibleGraphemes = 0,
        TextStrokeTransparency = 0.700,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    Library:New("UIPadding", {
        Parent = WatermarkName,
        PaddingLeft = UDim.new(0, 5),
    })

    Utility:Connect(RunService.RenderStepped, function(step)
        Library.Fps = math.floor(1 / step)

        if tick() - Watermark.Tick > cfg.Tickrate / 50 and Inline.Visible then
            local Text = Library:TextTriggers(cfg.Text)
            local TextBounds = Utility:GetTextBounds(Text, Library.Font, 14)

            Library:Tween(Inline, TweenInfo.new(cfg.Tickrate / 50, Library.TweenType), {Size = UDim2.new(0, TextBounds.X + 14, 0, 32)})
            Library:Tween(WatermarkName, TweenInfo.new(cfg.Tickrate / 50, Library.TweenType), {MaxVisibleGraphemes = #Text})

            WatermarkName.Text = Text

            Watermark.Tick = tick()
        end
    end)

    function Watermark:SetVisibility(bool)
        Inline.Visible = bool
    end

    function Watermark:Text(text)
        cfg.Text = text
    end

    function Watermark:TickRate(ticks)
        cfg.Tickrate = ticks
    end

    return Watermark
end

function Library:GetConfigs()
    local Files = listfiles(Library.Folder .. "/Configs")
    local List = {}

    for _, v in ipairs(Files) do
        local FileNameStart = Library.Folder .. "/Configs"
        local FileName = v:sub(#FileNameStart + 2):gsub(".json", "")

        List[#List + 1] = FileName
    end

    return List
end

return Library
