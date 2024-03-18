repeat wait() until Utility

local UserInputService = game.UserInputService
local TweenService = game.TweenService
local RunService = game:GetService("RunService")
local HttpService = game.HttpService
local NewRGB = Color3.fromRGB
local NewHSV = Color3.fromHSV
local NewInst = Instance.new
local NewVector = Vector2.new
local NewUdim2 = UDim2.new
local NewUdim = UDim.new

--[[ 

    Todo:
        1. Buttons.
        2. Dropdowns.
        3. Keybinds.
        4. Sliders.
        5. TextBoxes.
        6. Notifications.
        7. Confirmations.
        
]]--

Utility:Notify({
    Title = "GameShark",
    Description = "User Interface Loaded.",
    Time = 10,
})

local Library = {
	Drawings = {},
	Flags = {},
	ConfigFlags = {},
	Folder = "GameShark",
	Theme = {
		Outline = NewRGB(40, 40, 40),
		Background = NewRGB(30, 30, 30),
		ContextBackground = NewRGB(35, 35, 35),
        SectionBackground = NewRGB(40, 40, 40),
		ItemBackground = NewRGB(45, 45, 45),
        InfoBackground = NewRGB(32, 32, 32),
		Text = NewRGB(200, 200, 200),
		TabDisabled = NewRGB(180, 180, 180),
		DarkText = NewRGB(100, 100, 100),
		ControlDisabled = NewRGB(120, 120, 120),
        Accent = NewRGB(0, 174, 255),
	},
    Images = {
        Circle = "rbxassetid://14087443494",
    },
	ThemeObjects = {},
	TweenSpeed = 0.5,
	TweenType = Enum.EasingStyle.Cubic,
	ScreenGui = NewInst("ScreenGui", game.CoreGui),
    Interactions = {},
	Open = true,
}

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
            else
                obj[_] = v
            end
        end
    else
        obj.Parent = prop
    end

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
			object.Position = CurrentPosition
		end
	end)
end

function Library:Tween(obj, info, values)
	info = info == true and TweenInfo.new(Library.TweenSpeed, Library.TweenType) or info

	local Tween = TweenService:Create(obj, info, values)

	Tween:Play()

	return Tween
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

local SectionClass = {}
SectionClass.__index = SectionClass do
    function SectionClass:ChangeName(text)
        if self.SectionName then
            self.SectionName.Text = text
        end
    end

    function SectionClass:Paragraph(cfg)
        local Paragraph = Paragraph(self, cfg)

        return Paragraph
    end

    function SectionClass:Toggle(cfg)
        local Toggle = Toggle(self, cfg)

        return Toggle
    end
end

local TabClass = {}
TabClass.__index = TabClass do
    function TabClass:Update()
        local Objects = self.Objects

        if self.Window.Selected == self then
            Library:Tween(Objects.AccentBackground, true, {Transparency = 0.8})
            Library:Tween(Objects.AccentLine, true, {Transparency = 0})
            Library:ChangeObjectTheme(Objects.TabIcon, "Accent", true)
            Library:ChangeObjectTheme(Objects.TabName, "Accent", true)
            Objects.SectionHolderOutline.Visible = true
        else
            Library:Tween(Objects.AccentBackground, true, {Transparency = 1})
            Library:Tween(Objects.AccentLine, true, {Transparency = 1})
            Library:ChangeObjectTheme(Objects.TabIcon, "TabDisabled", true)
            Library:ChangeObjectTheme(Objects.TabName, "TabDisabled", true)
            Objects.SectionHolderOutline.Visible = false
        end
    end

    function TabClass:ChangeName(text)
        Objects.TabName.Text = text
    end

    function TabClass:ChangeIcon(img)
        Objects.TabIcon.Image = img
    end

    function TabClass:Section(cfg)
        cfg = cfg or {}

        Utility:Default(cfg, {
            Name = "NEW SECTION",
            Side = "Left",
        })

        cfg.Side = cfg.Side == "Left" and self.Objects.Left or self.Objects.Right

        local Section = Library:New("Frame", {
            Name = "Section",
            Parent = cfg.Side,
            Theme = "SectionBackground",
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
        })

        Library:New("UICorner", Section)

        Library:New("UIListLayout", {
            Parent = Section,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 6),
        })

        Library:New("UIPadding", {
            Parent = Section,
            PaddingBottom = UDim.new(0, 6),
            PaddingLeft = UDim.new(0, 6),
            PaddingRight = UDim.new(0, 6),
            PaddingTop = UDim.new(0, 6),
        })

        local SectionName
        if cfg.Name ~= "" then
            SectionName = Library:New("TextLabel", {
                Name = "SectionName",
                Parent = Section,
                BackgroundTransparency = 1.000,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 20),
                Font = Enum.Font.Gotham,
                Text = cfg.Name,
                Theme = "DarkText",
                TextSize = 12.000,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            Library:New("UIPadding", {
                Parent = SectionName,
                PaddingLeft = UDim.new(0, 10),
            })
        end

        local Section = setmetatable({
            Section = Section,
            SectionName = SectionName,
            Tab = self,
        }, SectionClass)

        return Section
    end
end

function Library:Window(cfg)
    cfg = cfg or {}

    Utility:Default(cfg, {
        Size = UDim2.new(0, 606, 0, 411),
        Name = "Roblox Cheat",
    })

    local Window = {
        Selected = nil,
        Tabs = {},
    }

    local WindowHolder = Library:New("Frame", {
        Name = "Window",
        Parent = Library.ScreenGui,
        Theme = "Background",
        BorderSizePixel = 0,
        Position = Library:GetCenter(cfg.Size),
        Size = cfg.Size,
    })

    Library:New("UICorner", WindowHolder)

    local TabHolderOutline = Library:New("Frame", {
        Name = "TabHolderOutline",
        Theme = "Outline",
        Parent = WindowHolder,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Position = UDim2.new(0, 12, 0, 12),
        Size = UDim2.new(0, 150, 1, -24),
    })

    Library:New("UICorner", TabHolderOutline)

    local TabHolderBackground = Library:New("Frame", {
        Name = "TabHolderBackground",
        Parent = TabHolderOutline,
        Theme = "ContextBackground",
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Position = UDim2.new(0, 1, 0, 1),
        Size = UDim2.new(1, -2, 1, -2),
    })

    Library:New("UICorner", TabHolderBackground)

    local DragPart = Library:New("Frame", {
        Name = "DragPart",
        Parent = TabHolderBackground,
        BackgroundTransparency = 1.000,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 36),
    })

    Library:Drag(WindowHolder, DragPart)

    local GradientBottom = Library:New("Frame", {
        Name = "GradientBottom",
        Parent = TabHolderBackground,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 1, -15),
        Size = UDim2.new(1, 0, 0, 15),
    })

    Library:New("UICorner", GradientBottom)

    Library:New("UIGradient", {
        Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(13, 13, 13)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(13, 13, 13))},
        Rotation = 270,
        Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.8), NumberSequenceKeypoint.new(1.00, 1.00)},
        Parent = GradientBottom,
    })

    local WindowName = Library:New("TextLabel", {
        Name = "WindowName",
        Parent = TabHolderBackground,
        BackgroundTransparency = 1.000,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 35),
        Font = Enum.Font.GothamBold,
        Text = cfg.Name,
        Theme = "Text",
        TextSize = 12.000,
        TextXAlignment = Enum.TextXAlignment.Left,
    })    

    Library:New("UIPadding", {
        Parent = WindowName,
        PaddingLeft = UDim.new(0, 10),
    })

    local TabHolder = Library:New("ScrollingFrame", {
        Name = "TabHolder",
        Parent = TabHolderBackground,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1.000,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 35),
        Size = UDim2.new(1, 0, 1, -35),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 0,
    })

    Library:New("UIListLayout", {
        Parent = TabHolder,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, -1),
    })

    function Window:InfoTab(cfg)
        cfg = cfg or {}

        local InfoTab = {}

        Utility:Default(cfg, {
            Name = "PLAYERS"
        })

        local TabInfoOutline = Library:New("Frame", {
            Name = "TabInfoOutline",
            Parent = TabHolder,
            Theme = "Outline",
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(1, 0, 0, 30),
        })

        local TabInfoBackground = Library:New("Frame", {
            Name = "TabInfoBackground",
            Parent = TabInfoOutline,
            Theme = "InfoBackground",
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 1),
            Size = UDim2.new(1, 0, 1, -2),
        })      

        local InfoName = Library:New("TextLabel", {
            Name = "InfoName",
            Parent = TabInfoOutline,
            BackgroundTransparency = 1.000,
            BorderSizePixel = 0,
            Theme = "DarkText",
            Size = UDim2.new(1, 0, 1, 0),
            Font = Enum.Font.Gotham,
            Text = cfg.Name,
            TextColor3 = Color3.fromRGB(100, 100, 100),
            TextSize = 12.000,
            TextXAlignment = Enum.TextXAlignment.Left,
        })

        Library:New("UIPadding", {
            Parent = InfoName,
            PaddingLeft = UDim.new(0, 10),
        })

        function InfoTab:ChangeName(text)
            InfoName.Text = text
        end

        return InfoTab
    end

    function Window:Tab(cfg)
        cfg = cfg or {}

        Utility:Default(cfg, {
            Name = "Tab",
            Icon = "rbxassetid://14086880516",
        })
        
        local Objects = {}

        Objects.TabOutline = Library:New("Frame", {
            Name = "TabOutline",
            Parent = TabHolder,
            Theme = "Outline",
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 36),
        })

        Objects.TabBackground = Library:New("Frame", {
            Name = "TabBackground",
            Parent = Objects.TabOutline,
            Theme = "ContextBackground",
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 1),
            Size = UDim2.new(1, 0, 1, -2),
        })

        Objects.AccentBackground = Library:New("Frame", {
            Name = "AccentBackground",
            Parent = Objects.TabBackground,
            Theme = "Accent",
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 1, 0),
            Visible = true,
        })

        Objects.TabIcon = Library:New("ImageLabel", {
            Name = "TabIcon",
            Parent = Objects.TabBackground,
            BackgroundTransparency = 1.000,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 10, 0.5, -11),
            Size = UDim2.new(0, 20, 0, 20),
            Image = cfg.Icon,
            Theme = "TabDisabled",
        })

        Objects.TabName = Library:New("TextLabel", {
            Name = "InfoName",
            Parent = Objects.TabBackground,
            BackgroundTransparency = 1.000,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 30, 0, 0),
            Size = UDim2.new(1, -30, 1, 0),
            Font = Enum.Font.Gotham,
            Text = cfg.Name,
            Theme = "TabDisabled",
            TextSize = 12.000,
            TextXAlignment = Enum.TextXAlignment.Left,
        })
 
        Library:New("UIPadding", {
            Parent = Objects.TabName,
            PaddingLeft = UDim.new(0, 10),
        })
        
        Objects.AccentLine = Library:New("Frame", {
            Name = "AccentLine",
            Parent = Objects.TabBackground,
            BackgroundTransparency = 1,
            Theme = "Accent",
            BorderSizePixel = 0,
            Size = UDim2.new(0, 2, 1, 0),
            Visible = true,
        })

        Objects.Button = Library:New("TextButton", {
            Name = "AccentLine",
            Parent = Objects.TabBackground,
            BackgroundTransparency = 1,
            Text = "",
            Theme = "Accent",
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 1, 0),
        })
        
        Objects.SectionHolderOutline = Library:New("Frame", {
            Name = "SectionHolderOutline",
            Parent = WindowHolder,
            Theme = "Outline",
            BorderSizePixel = 0,
            ClipsDescendants = true,
            Position = UDim2.new(0, 174, 0, 12),
            Size = UDim2.new(1, -186, 1, -24),         
        })

        Library:New("UICorner", Objects.SectionHolderOutline)

        Objects.SectionHolderBackground = Library:New("Frame", {
            Name = "SectionHolderBackground",
            Parent = Objects.SectionHolderOutline,
            Theme = "ContextBackground",
            BorderSizePixel = 0,
            ClipsDescendants = true,
            Position = UDim2.new(0, 1, 0, 1),
            Size = UDim2.new(1, -2, 1, -2),
        })

        Library:New("UIPadding", {
            Parent = Objects.SectionHolderBackground,
            PaddingBottom = UDim.new(0, 6),
            PaddingLeft = UDim.new(0, 6),
            PaddingRight = UDim.new(0, 6),
            PaddingTop = UDim.new(0, 6),
        })

        Library:New("UICorner", Objects.SectionHolderBackground)

        Library:New("UIListLayout", {
            Parent = Objects.SectionHolderBackground,
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 6),
        })

        Objects.Left = Library:New("ScrollingFrame", {
            Name = "Left",
            Parent = Objects.SectionHolderBackground,
            Active = true,
            BackgroundTransparency = 1.000,
            BorderSizePixel = 0,
            Size = UDim2.new(0.5, -3, 1, 0),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarThickness = 0,
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
        })

        Library:New("UIListLayout", {
            Parent = Objects.Left,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 6),
        })

        Objects.Right = Library:New("ScrollingFrame", {
            Name = "Right",
            Parent = Objects.SectionHolderBackground,
            Active = true,
            BackgroundTransparency = 1.000,
            BorderSizePixel = 0,
            Size = UDim2.new(0.5, -3, 1, 0),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarThickness = 0,
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
        })

        Library:New("UIListLayout", {
            Parent = Objects.Right,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 6),
        })

        local Tab = setmetatable({
            Window = self,
            Objects = Objects,
            Sections = {},
        }, TabClass)

        Utility:Connect(Objects.Button.MouseButton1Down, function()
            Window:Select(Tab)
        end)

        Window.Tabs[#Window.Tabs + 1] = Tab

        if #Window.Tabs == 1 then
            Window:Select(Tab)
        end

        self:Update()

        return Tab
    end

    function Window:Select(tab)
        self.Selected = tab

        self:Update()
    end

    function Window:Update()
        for _,v in pairs(self.Tabs) do
            v:Update()
        end
    end

    function Window:ChangeName(text)
        WindowName.Text = text
    end

    return Window
end

return Library