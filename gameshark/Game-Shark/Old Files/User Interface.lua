return nil

repeat wait() until Utility and Animation

-- Locals
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
local StartTick = tick()

print("[Game-Shark]: User Interface Loaded.")

local Keys = {
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

local Library = {
	Drawings = {},
	Flags = {},
	ConfigFlags = {},
	Folder = "GameShark",
	Theme = {
		["Outline"]	= {NewRGB(38, 37, 38), {RainbowSpeedSlider = 20, RainbowDepthSlider = 0, RainbowIntensitySlider = 0, FadingFirstColorPicker = {NewRGB(255, 255, 255), 1}, FadingSecondColorPicker = {NewRGB(0, 0, 0), 1}, FadingSpeedSlider = 20, AnimTypeDropDown = "None"}},
		["Inline"] = {NewRGB(92, 90, 92), {RainbowSpeedSlider = 20, RainbowDepthSlider = 0, RainbowIntensitySlider = 0, FadingFirstColorPicker = {NewRGB(255, 255, 255), 1}, FadingSecondColorPicker = {NewRGB(0, 0, 0), 1}, FadingSpeedSlider = 20, AnimTypeDropDown = "None"}},
		["Inline 2"] = {NewRGB(68, 68, 68), {RainbowSpeedSlider = 20, RainbowDepthSlider = 0, RainbowIntensitySlider = 0, FadingFirstColorPicker = {NewRGB(255, 255, 255), 1}, FadingSecondColorPicker = {NewRGB(0, 0, 0), 1}, FadingSpeedSlider = 20, AnimTypeDropDown = "None"}},
		["Background"] = {NewRGB(50, 48, 50), {RainbowSpeedSlider = 20, RainbowDepthSlider = 0, RainbowIntensitySlider = 0, FadingFirstColorPicker = {NewRGB(255, 255, 255), 1}, FadingSecondColorPicker = {NewRGB(0, 0, 0), 1}, FadingSpeedSlider = 20, AnimTypeDropDown = "None"}},
		["Dark Background"] = {NewRGB(44, 44, 44), {RainbowSpeedSlider = 20, RainbowDepthSlider = 0, RainbowIntensitySlider = 0, FadingFirstColorPicker = {NewRGB(255, 255, 255), 1}, FadingSecondColorPicker = {NewRGB(0, 0, 0), 1}, FadingSpeedSlider = 20, AnimTypeDropDown = "None"}},
		["Side"] = {NewRGB(46, 45, 46), {RainbowSpeedSlider = 20, RainbowDepthSlider = 0, RainbowIntensitySlider = 0, FadingFirstColorPicker = {NewRGB(255, 255, 255), 1}, FadingSecondColorPicker = {NewRGB(0, 0, 0), 1}, FadingSpeedSlider = 20, AnimTypeDropDown = "None"}},
		["Accent"] = {NewRGB(198, 137, 142), {RainbowSpeedSlider = 20, RainbowDepthSlider = 0, RainbowIntensitySlider = 0, FadingFirstColorPicker = {NewRGB(255, 255, 255), 1}, FadingSecondColorPicker = {NewRGB(0, 0, 0), 1}, FadingSpeedSlider = 20, AnimTypeDropDown = "None"}},
		["Text"] = {NewRGB(187, 186, 187), {RainbowSpeedSlider = 20, RainbowDepthSlider = 0, RainbowIntensitySlider = 0, FadingFirstColorPicker = {NewRGB(255, 255, 255), 1}, FadingSecondColorPicker = {NewRGB(0, 0, 0), 1}, FadingSpeedSlider = 20, AnimTypeDropDown = "None"}},
		["Dark Text"] = {NewRGB(120, 120, 120), {RainbowSpeedSlider = 20, RainbowDepthSlider = 0, RainbowIntensitySlider = 0, FadingFirstColorPicker = {NewRGB(255, 255, 255), 1}, FadingSecondColorPicker = {NewRGB(0, 0, 0), 1}, FadingSpeedSlider = 20, AnimTypeDropDown = "None"}},
		["Tab Disabled"] = {NewRGB(100, 100, 100), {RainbowSpeedSlider = 20, RainbowDepthSlider = 0, RainbowIntensitySlider = 0, FadingFirstColorPicker = {NewRGB(255, 255, 255), 1}, FadingSecondColorPicker = {NewRGB(0, 0, 0), 1}, FadingSpeedSlider = 20, AnimTypeDropDown = "None"}},
		["Tab Enabled"] = {NewRGB(180, 180, 180), {RainbowSpeedSlider = 20, RainbowDepthSlider = 0, RainbowIntensitySlider = 0, FadingFirstColorPicker = {NewRGB(255, 255, 255), 1}, FadingSecondColorPicker = {NewRGB(0, 0, 0), 1}, FadingSpeedSlider = 20, AnimTypeDropDown = "None"}},
		["Tab Background"] = {NewRGB(52, 51, 52), {RainbowSpeedSlider = 20, RainbowDepthSlider = 0, RainbowIntensitySlider = 0, FadingFirstColorPicker = {NewRGB(255, 255, 255), 1}, FadingSecondColorPicker = {NewRGB(0, 0, 0), 1}, FadingSpeedSlider = 20, AnimTypeDropDown = "None"}},
		["Dark Gradient"] = {ColorSequence.new{ColorSequenceKeypoint.new(0.00, NewRGB(0, 0, 0)), ColorSequenceKeypoint.new(1.00, NewRGB(0, 0, 0))}, {RainbowSpeedSlider = 20, RainbowDepthSlider = 0, RainbowIntensitySlider = 0, FadingFirstColorPicker = {NewRGB(255, 255, 255), 1}, FadingSecondColorPicker = {NewRGB(0, 0, 0), 1}, FadingSpeedSlider = 20, AnimTypeDropDown = "None"}},
		["Light Gradient"] = {ColorSequence.new{ColorSequenceKeypoint.new(0.00, NewRGB(120, 120, 120)), ColorSequenceKeypoint.new(1.00, NewRGB(120, 120, 120))}, {RainbowSpeedSlider = 20, RainbowDepthSlider = 0, RainbowIntensitySlider = 0, FadingFirstColorPicker = {NewRGB(255, 255, 255), 1}, FadingSecondColorPicker = {NewRGB(0, 0, 0), 1}, FadingSpeedSlider = 20, AnimTypeDropDown = "None"}},
	},
	MainTheme = {
		["Outline"]	= {NewRGB(38, 37, 38), {RainbowSpeedSlider = 20, RainbowDepthSlider = 0, RainbowIntensitySlider = 0, FadingFirstColorPicker = {NewRGB(255, 255, 255), 1}, FadingSecondColorPicker = {NewRGB(0, 0, 0), 1}, FadingSpeedSlider = 20, AnimTypeDropDown = "None"}},
		["Inline"] = {NewRGB(92, 90, 92), {RainbowSpeedSlider = 20, RainbowDepthSlider = 0, RainbowIntensitySlider = 0, FadingFirstColorPicker = {NewRGB(255, 255, 255), 1}, FadingSecondColorPicker = {NewRGB(0, 0, 0), 1}, FadingSpeedSlider = 20, AnimTypeDropDown = "None"}},
		["Inline 2"] = {NewRGB(68, 68, 68), {RainbowSpeedSlider = 20, RainbowDepthSlider = 0, RainbowIntensitySlider = 0, FadingFirstColorPicker = {NewRGB(255, 255, 255), 1}, FadingSecondColorPicker = {NewRGB(0, 0, 0), 1}, FadingSpeedSlider = 20, AnimTypeDropDown = "None"}},
		["Background"] = {NewRGB(50, 48, 50), {RainbowSpeedSlider = 20, RainbowDepthSlider = 0, RainbowIntensitySlider = 0, FadingFirstColorPicker = {NewRGB(255, 255, 255), 1}, FadingSecondColorPicker = {NewRGB(0, 0, 0), 1}, FadingSpeedSlider = 20, AnimTypeDropDown = "None"}},
		["Dark Background"] = {NewRGB(44, 44, 44), {RainbowSpeedSlider = 20, RainbowDepthSlider = 0, RainbowIntensitySlider = 0, FadingFirstColorPicker = {NewRGB(255, 255, 255), 1}, FadingSecondColorPicker = {NewRGB(0, 0, 0), 1}, FadingSpeedSlider = 20, AnimTypeDropDown = "None"}},
		["Side"] = {NewRGB(46, 45, 46), {RainbowSpeedSlider = 20, RainbowDepthSlider = 0, RainbowIntensitySlider = 0, FadingFirstColorPicker = {NewRGB(255, 255, 255), 1}, FadingSecondColorPicker = {NewRGB(0, 0, 0), 1}, FadingSpeedSlider = 20, AnimTypeDropDown = "None"}},
		["Accent"] = {NewRGB(198, 137, 142), {RainbowSpeedSlider = 20, RainbowDepthSlider = 0, RainbowIntensitySlider = 0, FadingFirstColorPicker = {NewRGB(255, 255, 255), 1}, FadingSecondColorPicker = {NewRGB(0, 0, 0), 1}, FadingSpeedSlider = 20, AnimTypeDropDown = "None"}},
		["Text"] = {NewRGB(187, 186, 187), {RainbowSpeedSlider = 20, RainbowDepthSlider = 0, RainbowIntensitySlider = 0, FadingFirstColorPicker = {NewRGB(255, 255, 255), 1}, FadingSecondColorPicker = {NewRGB(0, 0, 0), 1}, FadingSpeedSlider = 20, AnimTypeDropDown = "None"}},
		["Dark Text"] = {NewRGB(120, 120, 120), {RainbowSpeedSlider = 20, RainbowDepthSlider = 0, RainbowIntensitySlider = 0, FadingFirstColorPicker = {NewRGB(255, 255, 255), 1}, FadingSecondColorPicker = {NewRGB(0, 0, 0), 1}, FadingSpeedSlider = 20, AnimTypeDropDown = "None"}},
		["Tab Disabled"] = {NewRGB(100, 100, 100), {RainbowSpeedSlider = 20, RainbowDepthSlider = 0, RainbowIntensitySlider = 0, FadingFirstColorPicker = {NewRGB(255, 255, 255), 1}, FadingSecondColorPicker = {NewRGB(0, 0, 0), 1}, FadingSpeedSlider = 20, AnimTypeDropDown = "None"}},
		["Tab Enabled"] = {NewRGB(180, 180, 180), {RainbowSpeedSlider = 20, RainbowDepthSlider = 0, RainbowIntensitySlider = 0, FadingFirstColorPicker = {NewRGB(255, 255, 255), 1}, FadingSecondColorPicker = {NewRGB(0, 0, 0), 1}, FadingSpeedSlider = 20, AnimTypeDropDown = "None"}},
		["Tab Background"] = {NewRGB(52, 51, 52), {RainbowSpeedSlider = 20, RainbowDepthSlider = 0, RainbowIntensitySlider = 0, FadingFirstColorPicker = {NewRGB(255, 255, 255), 1}, FadingSecondColorPicker = {NewRGB(0, 0, 0), 1}, FadingSpeedSlider = 20, AnimTypeDropDown = "None"}},
		["Dark Gradient"] = {ColorSequence.new{ColorSequenceKeypoint.new(0.00, NewRGB(0, 0, 0)), ColorSequenceKeypoint.new(1.00, NewRGB(0, 0, 0))}, {RainbowSpeedSlider = 20, RainbowDepthSlider = 0, RainbowIntensitySlider = 0, FadingFirstColorPicker = {NewRGB(255, 255, 255), 1}, FadingSecondColorPicker = {NewRGB(0, 0, 0), 1}, FadingSpeedSlider = 20, AnimTypeDropDown = "None"}},
		["Light Gradient"] = {ColorSequence.new{ColorSequenceKeypoint.new(0.00, NewRGB(120, 120, 120)), ColorSequenceKeypoint.new(1.00, NewRGB(120, 120, 120))}, {RainbowSpeedSlider = 20, RainbowDepthSlider = 0, RainbowIntensitySlider = 0, FadingFirstColorPicker = {NewRGB(255, 255, 255), 1}, FadingSecondColorPicker = {NewRGB(0, 0, 0), 1}, FadingSpeedSlider = 20, AnimTypeDropDown = "None"}},
	},
	Images = {
		["Head"] = "rbxassetid://13888182116",
		["Cog"] = "rbxassetid://13706096910",
		["Eye"] = "rbxassetid://13706097687",
		["Folder"] = "rbxassetid://13706099436",
		["Sun"] = "rbxassetid://13706100199",
		["Checkers"] = "rbxassetid://13900445654",
		["Trans"] = "rbxassetid://2454009026",
		["Picker"] = "rbxassetid://13900818694",
		["Picker2"] = "rbxassetid://13900819741",
		["Saturation"] = "rbxassetid://13901004307",
	},
	ThemeObjects = {},
	Font = Enum.Font.SourceSans,
	Size = 13,
	TweenSpeed = 0.5,
	TweenType = Enum.EasingStyle.Cubic,
	ScreenGui = NewInst("ScreenGui", game.CoreGui),
	OverlayGui = NewInst("ScreenGui", game.CoreGui),
	OverlayFrame = NewInst("Frame"),
	Open = true,
	IsOpening = false,
	Fps = 0,
	User = "dev",
	Version = "0.0.1",
	Game = "Universal",
}

Library.OverlayFrame.Parent = Library.OverlayGui
Library.OverlayFrame.Size = NewUdim2(1, 0, 1, 0)
Library.OverlayFrame.BackgroundTransparency = 1

if not isfolder(Library.Folder) then
	makefolder(Library.Folder) 
end

if not isfolder(Library.Folder .. "/Configs") then
	makefolder(Library.Folder .. "/Configs") 
end

if not isfolder(Library.Folder .. "/Themes") then
	makefolder(Library.Folder .. "/Themes") 
end

function Library:GetCenter(size)
	return NewUdim2(0.5, -(size.X / 2), 0.5, -(size.Y / 2))
end	

function Library:New(class, prop, ignore)
	local obj = NewInst(class)

	if not ignore then
		table.insert(Library.Drawings, obj)
	end

	for _,v in pairs(prop) do
		if _ == "Theme" then
			if obj:IsA("UIGradient") then
				Library.ThemeObjects[obj] = v
				obj.Color = Library.Theme[v][1]
			elseif obj:IsA("ImageButton") or obj:IsA("ImageLabel") then
				Library.ThemeObjects[obj] = v
				obj.ImageColor3 = Library.Theme[v][1]
			elseif obj:IsA("TextButton") then
				Library.ThemeObjects[obj] = v
				obj.TextColor3 = Library.Theme[v][1]
			elseif obj:IsA("TextBox") then
				Library.ThemeObjects[obj] = v
				obj.TextColor3 = Library.Theme[v][1]
			elseif obj:IsA("ScrollingFrame") then
				Library.ThemeObjects[obj] = v
				obj.ScrollBarImageColor3 = Library.Theme[v][1]
			elseif obj:IsA("TextLabel") then
				Library.ThemeObjects[obj] = v
				obj.TextColor3 = Library.Theme[v][1]
			else
				Library.ThemeObjects[obj] = v
				obj.BackgroundColor3 = Library.Theme[v][1]
			end
		else
			obj[_] = v
		end
	end

	obj.Name = tostring(#Library.Drawings)

	return obj
end

function Library:Unload()
	Library.ScreenGui:Destroy()
	Library.OverlayGui:Destroy()
end

function Library:ChangeTheme(theme, color)
	Library.Theme[theme][1] = color

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

function Library:Resize(object, dragobj, size)
	local Dragging, CurrentSize

	Utility:Connect(dragobj.InputBegan, function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			Dragging = true
			ObjectPosition = object.Position
		end
	end)

	Utility:Connect(UserInputService.InputChanged, function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement and Dragging then
			local X = math.clamp(input.Position.X - object.AbsolutePosition.X, size.X, 3000)
			local Y = math.clamp(input.Position.Y - object.AbsolutePosition.Y, size.Y, 3000)
			CurrentSize = NewUdim2(0, X, 0, Y)
			object.Size = CurrentSize
		end
	end)

	Utility:Connect(UserInputService.InputEnded, function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and Dragging then
			Dragging = false
			object.Size = CurrentSize
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
			Library:Tween(obj, true, {Color = Library.Theme[theme][1]})
		elseif obj:IsA("TextButton") then
			Library.ThemeObjects[obj] = theme
			Library:Tween(obj, true, {TextColor3 = Library.Theme[theme][1]})
		elseif obj:IsA("TextBox") then
			Library.ThemeObjects[obj] = theme
			Library:Tween(obj, true, {TextColor3 = Library.Theme[theme][1]})
		elseif obj:IsA("ImageButton") or obj:IsA("ImageLabel") then
			Library.ThemeObjects[obj] = theme
			Library:Tween(obj, true, {ImageColor3 = Library.Theme[theme][1]})
		elseif obj:IsA("ScrollingFrame") then
			Library.ThemeObjects[obj] = theme
			Library:Tween(obj, true, {ScrollBarImageColor3 = Library.Theme[theme][1]})
		elseif obj:IsA("TextLabel") then
			Library.ThemeObjects[obj] = theme
			Library:Tween(obj, true, {TextColor3 = Library.Theme[theme][1]})
		else
			Library.ThemeObjects[obj] = theme
			Library:Tween(obj, true, {BackgroundColor3 = Library.Theme[theme][1]})
		end
	else
		if obj:IsA("UIGradient") then
			Library.ThemeObjects[obj] = theme
			obj.Color = Library.Theme[theme][1]
		elseif obj:IsA("ImageButton") or obj:IsA("ImageLabel") then
			Library.ThemeObjects[obj] = theme
			obj.ImageColor3 = Library.Theme[theme][1]
		elseif obj:IsA("TextButton") then
			Library.ThemeObjects[obj] = theme
			obj.TextColor3 = Library.Theme[theme][1]
		elseif obj:IsA("TextBox") then
			Library.ThemeObjects[obj] = theme
			obj.TextColor3 = Library.Theme[theme][1]
		elseif obj:IsA("ScrollingFrame") then
			Library.ThemeObjects[obj] = theme
			obj.ScrollBarImageColor3 = Library.Theme[theme][1]
		elseif obj:IsA("TextLabel") then
			Library.ThemeObjects[obj] = theme
			obj.TextColor3 = Library.Theme[theme][1]
		else
			Library.ThemeObjects[obj] = theme
			obj.BackgroundColor3 = Library.Theme[theme][1]
		end
	end
end

function Library:Default(tbl, default)
	for _,v in pairs(default) do
		if tbl[_] == nil then
			tbl[_] = v
		end
	end
end

function Library:Round(number, float)
	return float * math.round(number / float)
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

function Library:Tooltip(text, holder)
	local TextBounds = Utility:GetTextBounds(text, Library.Font, Library.Size)
	local Objects = {}
	local Canceled = false

	do	
		Objects.Holder = Library:New("Frame", {
			Parent = Library.ScreenGui,
			BackgroundTransparency = 1,
			Size = NewUdim2(0, TextBounds.X + 8, 0, TextBounds.Y + 4),
			Visible = false,
			BorderSizePixel = 0,
			ZIndex = 500,
		}, true)
		Objects.Inline = Library:New("Frame", {
			Parent = Objects.Holder,
			BackgroundTransparency = 1,
			Theme = "Inline 2",
			Position = NewUdim2(0, -23, 0, 0),
			Size = NewUdim2(1, 0, 1, 0),
			Visible = true,
			BorderSizePixel = 0,
			ZIndex = 501,
		}, true)
		Objects.Background = Library:New("Frame", {
			Parent = Objects.Inline,
			BackgroundTransparency = 1,
			Theme = "Background",
			Position = NewUdim2(0, 1, 0, 1),
			Size = NewUdim2(1, -2, 1, -2),
			Visible = true,
			BorderSizePixel = 0,
			ZIndex = 502,
		}, true)
		Objects.Outline = Library:New("Frame", {
			Position = NewUdim2(0, 0, 0, 0),
			Parent = Objects.Background,
			BackgroundTransparency = 1,
			Theme = "Outline",
			Size = NewUdim2(0, 2, 1, 0),
			Visible = true,
			BorderSizePixel = 0,
			ZIndex = 503,
		}, true)
		Objects.Outline2 = Library:New("Frame", {
			Position = NewUdim2(0, 2, 0, 0),
			Parent = Objects.Background,
			BackgroundTransparency = 1,
			Theme = "Outline",
			Size = NewUdim2(1, -2, 0, 2),
			Visible = true,
			BorderSizePixel = 0,
			ZIndex = 503,
		}, true)
		Objects.Accent = Library:New("Frame", {
			Position = NewUdim2(0, 0, 0, 0),
			Parent = Objects.Background,
			BackgroundTransparency = 1,
			Theme = "Accent",
			Size = NewUdim2(0, 1, 1, 0),
			Visible = true,
			BorderSizePixel = 0,
			ZIndex = 504,
		}, true)
		Objects.Title = Library:New("TextLabel", {
			Parent = Objects.Background,
			Theme = "Text",
			Text = text,
			TextTransparency = 1,
			TextXAlignment = Enum.TextXAlignment.Left,
			BackgroundTransparency = 1,
			Position = NewUdim2(0, 4, 0, 0),
			Font = Library.Font,
			TextSize = Library.Size,
			Size = NewUdim2(0, TextBounds.X, 0, TextBounds.Y),
			Visible = true,
			BorderSizePixel = 0,
			ZIndex = 505,
		}, true)
	end

	Utility:Connect(holder.MouseEnter, function()
		task.spawn(function()
			wait(0.5)

			Objects.Holder.Visible = true
	
			for _,v in pairs(Objects) do
				if _ ~= "Holder" then
					if v:IsA("TextLabel") then
						local Old = v.TextTransparency
						v.TextTransparency = 1
						Library:Tween(v, true, {TextTransparency = 0})
					else
						if _:find("Outline") then
							Library:Tween(v, true, {BackgroundTransparency = 0.7})
						else
							Library:Tween(v, true, {BackgroundTransparency = 0})
						end
					end
				end
			end
		end)
	end)

	Utility:Connect(holder.MouseLeave, function()
		task.spawn(function()
			for _,v in pairs(Objects) do
				if _ ~= "Holder" then
					if v:IsA("TextLabel") then
						local Old = v.TextTransparency
						v.TextTransparency = 1
						Library:Tween(v, true, {TextTransparency = 1})
					else
						if _:find("Outline") then
							Library:Tween(v, true, {BackgroundTransparency = 1})
						else
							Library:Tween(v, true, {BackgroundTransparency = 1})
						end
					end
				end
			end
	
			wait(Library.TweenSpeed)
	
			Objects.Holder.Visible = false
		end)
	end)

	Utility:Connect(UserInputService.InputChanged, function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement and Utility:InBounds(holder, input.Position) and not Objects.Holder.Visible then
			Objects.Holder.Position = NewUdim2(0, input.Position.X + 23, 0, input.Position.Y)
		end
	end)
end

function Library:Keybind(cfg, holder, count)
	local KeybindTable = {
		SideCount = 1,
		Mode = cfg.Mode,
		Key = cfg.Key,
		Toggled = false,
		Picking = false,
		IsTweening = false,
	}

	local Inline = Library:New("Frame", {
		Parent = holder,
		BackgroundTransparency = 0,
		Theme = "Inline 2",
		Position = NewUdim2(1, -(count * (count > 1 and 27 or 25)), 0, 0),
		Size = NewUdim2(0, 25, 0, 10),
		Visible = true,
		BorderSizePixel = 0,
	})
	Library:New("TextButton", {
		Parent = Inline,
		BackgroundTransparency = 1,
		Text = "",
		Position = NewUdim2(0, 1, 0, 1),
		Size = NewUdim2(1, -2, 1, -2),
		Visible = true,
		BorderSizePixel = 0,
	})
	local Background = Library:New("Frame", {
		Parent = Inline,
		BackgroundTransparency = 0,
		Theme = "Dark Background",
		Position = NewUdim2(0, 1, 0, 1),
		Size = NewUdim2(1, -2, 1, -2),
		Visible = true,
		BorderSizePixel = 0,
	})
	local Outline = Library:New("Frame", {
		Position = NewUdim2(0, 0, 0, 0),
		Parent = Background,
		BackgroundTransparency = 0.7,
		Theme = "Outline",
		Size = NewUdim2(0, 2, 1, 0),
		Visible = true,
		BorderSizePixel = 0,
	})
	local Outline2 = Library:New("Frame", {
		Position = NewUdim2(0, 2, 0, 0),
		Parent = Background,
		BackgroundTransparency = 0.7,
		Theme = "Outline",
		Size = NewUdim2(1, -2, 0, 2),
		Visible = true,
		BorderSizePixel = 0,
	})
	if cfg.Name then
		local TextBounds = Utility:GetTextBounds(cfg.Name, Library.Font, Library.Size)
		local Title = Library:New("TextLabel", {
			Parent = holder,
			Theme = "Text",
			Text = cfg.Name,
			BackgroundTransparency = 1,
			Position = NewUdim2(0, 0, 0, 0),
			Font = Library.Font,
			TextSize = Library.Size,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = NewUdim2(0, TextBounds.X, 0, TextBounds.Y - 3),
			Visible = true,
			BorderSizePixel = 0,
		})
	end
	local KeyText = Library:New("TextLabel", {
		Parent = Background,
		Theme = "Text",
		Text = cfg.Key == "" and "N/A" or cfg.Key == "Escape" and "N/A" or Keys[Enum.KeyCode[cfg.Key] or Enum.UserInputType[cfg.Key]] or cfg.Key,
		BackgroundTransparency = 1,
		Position = NewUdim2(0, 0, 0, 0),
		Font = Library.Font,
		TextSize = 10,
		Size = NewUdim2(1, 0, 1, -1),
		Visible = true,
		BorderSizePixel = 0,
	})

	local ModeObjects = {}

	ModeObjects.ModeInline = Library:New("Frame", {
		Parent = Library.OverlayFrame,
		BackgroundTransparency = 1,
		Theme = "Inline 2",
		Position = NewUdim2(0, 0, 0, 0),
		Size = NewUdim2(0, 40, 0, 50),
		Visible = false,
		BorderSizePixel = 0,
		ZIndex = 100,
	})
	ModeObjects.ModeBackground = Library:New("Frame", {
		Parent = ModeObjects.ModeInline,
		BackgroundTransparency = 1,
		Theme = "Background",
		Position = NewUdim2(0, 1, 0, 1),
		Size = NewUdim2(1, -2, 1, -2),
		Visible = true,
		BorderSizePixel = 0,
		ZIndex = 100,
	})
	Library:New("TextButton", {
		Parent = ModeObjects.ModeInline,
		BackgroundTransparency = 1,
		Text = "",
		Position = NewUdim2(0, 1, 0, 1),
		Size = NewUdim2(1, -2, 1, -2),
		Visible = true,
		BorderSizePixel = 0,
		ZIndex = 100,
	})
	ModeObjects.ModeOutline = Library:New("Frame", {
		Position = NewUdim2(0, 0, 0, 0),
		Parent = ModeObjects.ModeBackground,
		BackgroundTransparency = 1,
		Theme = "Outline",
		Size = NewUdim2(0, 2, 1, 0),
		Visible = true,
		BorderSizePixel = 0,
		ZIndex = 100,
	})
	ModeObjects.ModeOutline2 = Library:New("Frame", {
		Position = NewUdim2(0, 2, 0, 0),
		Parent = ModeObjects.ModeBackground,
		BackgroundTransparency = 1,
		Theme = "Outline",
		Size = NewUdim2(1, -2, 0, 2),
		Visible = true,
		BorderSizePixel = 0,
		ZIndex = 100,
	})
	local ModeHolder = Library:New("Frame", {
		Parent = ModeObjects.ModeInline,
		BackgroundTransparency = 1,
		Position = NewUdim2(0, 1, 0, 1),
		Size = NewUdim2(1, -2, 1, -2),
		Visible = true,
		BorderSizePixel = 0,
		ZIndex = 100,
	})

	Library:New("UIListLayout", {
		Parent = ModeHolder,
		FillDirection = Enum.FillDirection.Vertical,
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	local Modes = {
		"Toggle",
		"Hold",
		"Always",
	}

	local ModeButtons = {}

	function KeybindTable:SetOpen(bool, tween)
		if tween and KeybindTable.IsTweening then
			return
		end

		task.spawn(function()
			if bool then
				ModeObjects.ModeInline.Visible = true
				KeybindTable.IsTweening = true

				if tween then
					for _,v in pairs(ModeObjects)  do
						if v:IsA("TextLabel") then
							Library:Tween(v, true, {TextTransparency = 0})
						elseif v:IsA("Frame") then
							if _:find("Outline") then
								Library:Tween(v, true, {BackgroundTransparency = 0.7})
							else
								Library:Tween(v, true, {BackgroundTransparency = 0})
							end
						end
					end

					wait(Library.TweenSpeed - 0.1)
				end

				KeybindTable.IsTweening = false
			else
				KeybindTable.IsTweening = true

				if tween then
					for _,v in pairs(ModeObjects)  do
						if v:IsA("TextLabel") then
							Library:Tween(v, true, {TextTransparency = 1})
						elseif v:IsA("Frame") then
							Library:Tween(v, true, {BackgroundTransparency = 1})
						end
					end

					wait(Library.TweenSpeed - 0.1)
				end

				KeybindTable.IsTweening = false
				ModeObjects.ModeInline.Visible = false
			end
		end)
	end

	for _,v in pairs(Modes) do
		local ButtonTable = {};

		local Button = Library:New("TextLabel", {
			Parent = ModeHolder,
			Text = v,
			Theme = "Text",
			BackgroundTransparency = 1,
			Position = NewUdim2(0, 0, 0, 0),
			Size = NewUdim2(1, 0, 0, 15),
			Visible = true,
			BorderSizePixel = 0,
			Font = Library.Font,
			TextSize = Library.Size,
			ZIndex = 101,
		})

		ModeObjects[v] = Button

		function ButtonTable:Click()
			for _,v in pairs(ModeButtons) do
				v:Unclick()
			end

			KeybindTable.Mode = v

			Library:ChangeObjectTheme(Button, "Accent", true)

			KeybindTable:SetOpen(false, true)
		end

		function ButtonTable:Unclick()
			Library:ChangeObjectTheme(Button, "Text", true)
		end

		Utility:Connect(Button.InputBegan, function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				ButtonTable:Click()
			end
		end)

		if v == KeybindTable.Mode then
			ButtonTable:Click()
		end

		ModeButtons[v] = ButtonTable
	end

	function KeybindTable:SetValue(info)
		if info then
			if info[1] then
				local Key = info[1]
				KeyText.Text = Key == "" and "N/A" or Key
				KeybindTable.Key = Key
			end

			if info[2] then
				local Mode = info[2]
				ModeButtons[Mode]:Click()
			end
		end
	end

	function KeybindTable:GetState()
		if KeybindTable.Mode == "Always" then
			return true
		elseif KeybindTable.Mode == "Hold" then
			if KeybindTable.Key == "" then
				return false
			end

			local Key = KeybindTable.Key

			if Key == "MB1" or Key == "MB2" then
				return UserInputService:IsMouseButtonPressed(Key == "MB1" and Enum.UserInputType.MouseButton1 or Enum.UserInputType.MouseButton2)
			else
				return UserInputService:IsKeyDown(Enum.KeyCode[KeybindTable.Key])
			end
		else
			if KeybindTable.Key == "" then
				return false
			end

			return KeybindTable.Toggled
		end
	end

	Utility:Connect(Background.InputBegan, function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and not ModeObjects.ModeInline.Visible then
			KeybindTable.Picking = true

			KeyText.Text = ""

			local Break = false
			local Text = ""

			task.spawn(function()
				while not Break do
					if Text == "..." then
						Text = ""
					end

					Text = Text .. "."

					KeyText.Text = Text

					wait(0.4)
				end
			end)

			wait(0.2)

			local Event; Event = Utility:Connect(UserInputService.InputBegan, function(input)
				local Key
				local KeyName = input.KeyCode.Name == "Escape" and "N/A" or Keys[input.KeyCode] or Keys[input.UserInputType]  or input.KeyCode.Name

				if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode.Name == "Escape" then
					Key = ""
				elseif input.UserInputType == Enum.UserInputType.Keyboard then
					Key = input.KeyCode.Name
				elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
					Key = 'MB1'
				elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
					Key = 'MB2'
				end

				Break = true
				KeybindTable.Picking = false

				KeyText.Text = KeyName
				KeybindTable.Key = Key

				Event:Disconnect()
			end)
		end

		if input.UserInputType == Enum.UserInputType.MouseButton2 then
			ModeObjects.ModeInline.Position = NewUdim2(0, Inline.AbsolutePosition.X, 0, Inline.AbsolutePosition.Y)
			KeybindTable:SetOpen(not ModeObjects.ModeInline.Visible, true)
		end
	end)

	Utility:Connect(Inline.MouseEnter, function()
		Library:ChangeObjectTheme(Inline, "Inline", true)
	end)

	Utility:Connect(Inline.MouseLeave, function()
		Library:ChangeObjectTheme(Inline, "Inline 2", true)
	end)

	Utility:Connect(UserInputService.InputBegan, function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and not Utility:InBounds(ModeObjects.ModeBackground, input.Position) and ModeObjects.ModeInline.Visible then
			KeybindTable:SetOpen(false, true)
		end

		if input.UserInputType == Enum.UserInputType.MouseWheel and not Utility:InBounds(ModeObjects.ModeBackground, input.Position) and ModeObjects.ModeInline.Visible then
			KeybindTable:SetOpen(false, false)
		end

		if (input.KeyCode.Name or input.UserInputService) == KeybindTable.Key then
			cfg.Callback(KeybindTable:GetState())
			Library.Flags[cfg.Flag] = KeybindTable:GetState()
			Library.Flags[cfg.Flag .. "_info"] = {KeybindTable.Key, KeybindTable.Mode}
		end

		if not KeybindTable.Picking then
			if KeybindTable.Mode == "Toggle" then
				local Key = KeybindTable.Key

				if Key == "MB1" or Key == "MB2" then
					if Key == 'MB1' and input.UserInputType == Enum.UserInputType.MouseButton1 or Key == 'MB2' and input.UserInputType == Enum.UserInputType.MouseButton2 then
						KeybindTable.Toggled = not KeybindTable.Toggled
					end
				else
					if input.KeyCode.Name == Key then
						KeybindTable.Toggled = not KeybindTable.Toggled
					end
				end
			end
		end
	end)

	Utility:Connect(UserInputService.InputChanged, function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and not Utility:InBounds(ModeObjects.ModeBackground, input.Position) and ModeObjects.ModeInline.Visible then
			KeybindTable:SetOpen(false, true)
		end

		if input.UserInputType == Enum.UserInputType.MouseWheel and not Utility:InBounds(ModeObjects.ModeBackground, input.Position) and ModeObjects.ModeInline.Visible then
			KeybindTable:SetOpen(false, false)
		end
	end)

	Utility:Connect(UserInputService.InputEnded, function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and not Utility:InBounds(ModeObjects.ModeBackground, input.Position) and ModeObjects.ModeInline.Visible then
			KeybindTable:SetOpen(false, true)
		end

		if input.UserInputType == Enum.UserInputType.MouseWheel and not Utility:InBounds(ModeObjects.ModeBackground, input.Position) and ModeObjects.ModeInline.Visible then
			KeybindTable:SetOpen(false, false)
		end
	end)

	if cfg.Tooltip then
		Library:Tooltip(cfg.Tooltip, holder)
	end

	Library.Flags[cfg.Flag] = KeybindTable:GetState()
	Library.Flags[cfg.Flag .. "_info"] = {KeybindTable.Key, KeybindTable.Mode}

	Library.ConfigFlags[cfg.Flag .. "_info"] = function(info)
		KeybindTable:SetValue(info)
	end

	function KeybindTable:Keybind(cfg)
		cfg = cfg or {}

		Library:Default(cfg, {
			Mode = "Toggle",
			Key = "",
			Callback = function() end,
			Flag = "keybind",
		})

		KeybindTable.SideCount += 1

		local KeybindTable = Library:Keybind(cfg, holder, KeybindTable.SideCount)

		return KeybindTable
	end

	return KeybindTable
end

function Library:ColorPicker(cfg, holder, count, animations)
	local ColorPickerTable = {
		TabSections = {},
		TabButtons = {},
		TabOutlines = {},
		TabText = {},
		Transparency = 0,
		Color = nil,
		HuePosition = 0,
		SlidingSat = false,
		SlidingHue = false,
		SlidingAlpha = false,
	}

	local StartTick = tick()
	
	local Inline = Library:New("Frame", {
		Parent = holder,
		BackgroundTransparency = 0,
		Theme = "Inline 2",
		Position = NewUdim2(1, -(count * (count > 1 and 27 or 25)), 0, 0),
		Size = NewUdim2(0, 25, 0, 10),
		Visible = true,
		BorderSizePixel = 0,
	})
	local Background = Library:New("Frame", {
		Parent = Inline,
		BackgroundTransparency = 0,
		Theme = "Dark Background",
		Position = NewUdim2(0, 1, 0, 1),
		Size = NewUdim2(1, -2, 1, -2),
		Visible = true,
		BorderSizePixel = 0,
	})
	local Outline = Library:New("Frame", {
		Position = NewUdim2(0, 0, 0, 0),
		Parent = Background,
		BackgroundTransparency = 0.7,
		Theme = "Outline",
		Size = NewUdim2(0, 2, 1, 0),
		Visible = true,
		BorderSizePixel = 0,
	})
	local Outline2 = Library:New("Frame", {
		Position = NewUdim2(0, 2, 0, 0),
		Parent = Background,
		BackgroundTransparency = 0.7,
		Theme = "Outline",
		Size = NewUdim2(1, -2, 0, 2),
		Visible = true,
		BorderSizePixel = 0,
	})
	local Checkers = Library:New("ImageLabel", {
		Visible = true,
		Parent = Background,
		Image = Library.Images.Checkers,
		Position = NewUdim2(0, 0, 0, 0),
		Size = NewUdim2(1, 0, 1, 0),
		ImageColor3 = NewRGB(255, 255, 255),
		BackgroundTransparency = 1,
	})
	local ColorBackground = Library:New("Frame", {
		Parent = Background,
		BackgroundTransparency = 0,
		Position = NewUdim2(0, 0, 0, 0),
		Size = NewUdim2(1, 0, 1, 0),
		Visible = true,
		BorderSizePixel = 0,
	})
	local Button = Library:New("TextButton", {	
		Parent = Background,
		BackgroundTransparency = 1,
		Text = "",
		Position = NewUdim2(0, 0, 0, 0),
		Size = NewUdim2(1, 0, 1, 0),
		Visible = true,
		BorderSizePixel = 0,
	})
	if cfg.Name then
		local TextBounds = Utility:GetTextBounds(cfg.Name, Library.Font, Library.Size)
		local Title = Library:New("TextLabel", {
			Parent = holder,
			Theme = "Text",
			Text = cfg.Name,
			BackgroundTransparency = 1,
			Position = NewUdim2(0, 0, 0, 0),
			Font = Library.Font,
			TextSize = Library.Size,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = NewUdim2(0, TextBounds.X, 0, TextBounds.Y - 3),
			Visible = true,
			BorderSizePixel = 0,
		})
	end

	local WindowInline = Library:New("Frame", {
		Parent = Library.OverlayFrame,
		BackgroundTransparency = 0,	
		Theme = "Inline 2",
		Position = NewUdim2(0, 0, 0, 0),
		Size = NewUdim2(0, cfg.Transparency and 216 or 197, 0, 197),
		Visible = false,
		BorderSizePixel = 0,
	})
	Library:New("TextButton", {
		Parent = WindowInline,
		BackgroundTransparency = 1,
		Text = "",
		Position = NewUdim2(0, 1, 0, 1),
		Size = NewUdim2(1, -2, 1, -2),
		Visible = true,
		BorderSizePixel = 0,
	})
	local WindowBackground = Library:New("Frame", {
		Parent = WindowInline,
		BackgroundTransparency = 0,
		Theme = "Background",
		Position = NewUdim2(0, 1, 0, 1),
		Size = NewUdim2(1, -2, 1, -2),
		Visible = true,
		BorderSizePixel = 0,
	})
	local WindowTabHolder = Library:New("Frame", {
		Parent = WindowBackground,
		Theme = "Dark Background",
		Position = NewUdim2(0, 0, 0, 0),
		Size = NewUdim2(1, 0, 0, 22),
		Visible = true,
		BorderSizePixel = 0,
	})
	Library:New("UIListLayout", {
		Padding = UDim.new(0, -2),
		Parent = WindowTabHolder,
		FillDirection = Enum.FillDirection.Horizontal,
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	function ColorPickerTable:Tab(name)
		local SectionTable = {}

		local TextBounds = Utility:GetTextBounds(name, Library.Font, Library.Size)

		local ButtonOutline = Library:New("Frame", {
			BackgroundTransparency = 0,
			Parent = WindowTabHolder,
			Theme = "Outline",
			Size = NewUdim2(0, TextBounds.X + 10, 1, 0),
			Visible = true,
			BorderSizePixel = 0,
		})
		local Holder = Library:New("Frame", {
			BackgroundTransparency = 0,
			Parent = ButtonOutline,
			Theme = "Dark Background",
			Position = NewUdim2(0, 2, 0, 2),
			Size = NewUdim2(1, -4, 1, -4),
			Visible = true,
			BorderSizePixel = 0,
		})
		local Button = Library:New("TextButton", {
			BackgroundTransparency = 1,
			Parent = Holder,
			Theme = "Tab Disabled",
			Size = NewUdim2(1, 0, 1, 0),
			Visible = true,
			BorderSizePixel = 0,
			TextXAlignment = Enum.TextXAlignment.Center,
			Font = Library.Font,
			TextSize = Library.Size,
			Text = name,
		})
		local HideOutline = Library:New("Frame", {
			BackgroundTransparency = 0,
			Parent = Holder,
			Theme = "Outline",
			Position = NewUdim2(0, 0, 1, 0),
			Size = NewUdim2(1, 0, 0, 2),
			Visible = true,
			BorderSizePixel = 0,
			ZIndex = 50,
		})
		local Content = Library:New("Frame", {
			Parent = WindowBackground,
			BackgroundTransparency = 1,
			Position = NewUdim2(0, 0, 0, 22),
			Size = NewUdim2(1, 0, 1, -22),
			Visible = true,
			BorderSizePixel = 0,
		})

		SectionTable.Content = Content

		table.insert(ColorPickerTable.TabButtons, Holder)
		table.insert(ColorPickerTable.TabText, Button)
		table.insert(ColorPickerTable.TabSections, Content)
		table.insert(ColorPickerTable.TabOutlines, HideOutline)

		function SectionTable:Show()
			for _,v in pairs(ColorPickerTable.TabSections) do
				if v ~= Content then
					v.Visible = false
				end
			end

			for _,v in pairs(ColorPickerTable.TabButtons) do
				if v ~= Holder then
					Library:ChangeObjectTheme(v, "Dark Background", true)
				end
			end

			for _,v in pairs(ColorPickerTable.TabText) do
				if v ~= Button then
					Library:ChangeObjectTheme(v, "Tab Disabled", true)
				end
			end

			for _,v in pairs(ColorPickerTable.TabOutlines) do
				if v ~= HideOutline then
					Library:ChangeObjectTheme(v, "Outline", true)
				end
			end

			Library:ChangeObjectTheme(Button, "Text", true)
			Library:ChangeObjectTheme(Holder, "Background", true)
			Library:ChangeObjectTheme(HideOutline, "Background", true)
			Content.Visible = true
		end

		Utility:Connect(Button.MouseButton1Down, SectionTable.Show)

		return SectionTable
	end

	local Picker = ColorPickerTable:Tab("Picker")
	local Animation 
	if animations then
		Animation = ColorPickerTable:Tab("Animations")
	end

	-- Hue
	local HueInline = Library:New("Frame", {
		Parent = Picker.Content,
		BackgroundTransparency = 0,
		Theme = "Inline 2",
		Position = NewUdim2(0, 176, 0, 4),
		Size = NewUdim2(0, 15, 0, 146),
		Visible = true,
		BorderSizePixel = 0,
	})

	local HueGradientBackground = Library:New("Frame", {
		Parent = HueInline,
		BackgroundTransparency = 0,
		BackgroundColor3 = NewRGB(255, 255, 255),
		Position = NewUdim2(0, 1, 0, 1),
		Size = NewUdim2(1, -2, 1, -2),
		Visible = true,
		BorderSizePixel = 0,
	})

	local HueGradient = Library:New("UIGradient", {
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
		Parent = HueGradientBackground,
	})

	local HuePicker = Library:New("ImageLabel", {
		Visible = true,
		Parent = HueInline,
		Image = Library.Images.Picker,
		Position = NewUdim2(0, -1, 0, -1),
		Size = NewUdim2(0, 17, 0, 5),
		ImageColor3 = NewRGB(255, 255, 255),
		BackgroundTransparency = 1,
	})

	local HueButton = Library:New("TextButton", {	
		Parent = HueInline,
		BackgroundTransparency = 1,
		Text = "",
		Position = NewUdim2(0, 1, 0, 1),
		Size = NewUdim2(1, -2, 1, -2),
		Visible = true,
		BorderSizePixel = 0,
	})

	local AlphaInline, AlphaGradientBackground, AlphaGradient, AlphaPicker, AlphaButton

	-- Alpha
	if cfg.Transparency then
		AlphaInline = Library:New("Frame", {
			Parent = Picker.Content,
			BackgroundTransparency = 0,
			Theme = "Inline 2",
			Position = NewUdim2(0, 195, 0, 4),
			Size = NewUdim2(0, 15, 0, 146),
			Visible = true,
			BorderSizePixel = 0,
		})

		AlphaGradientBackground = Library:New("Frame", {
			Parent = AlphaInline,
			BackgroundTransparency = 0,
			BackgroundColor3 = NewRGB(255, 255, 255),
			Position = NewUdim2(0, 1, 0, 1),
			Size = NewUdim2(1, -2, 1, -2),
			Visible = true,
			BorderSizePixel = 0,
		})

		AlphaGradient = Library:New("UIGradient", {
			Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), 
				ColorSequenceKeypoint.new(0.57, Color3.fromRGB(150, 150, 150)), 
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))
			}),
			Rotation = 90,
			Parent = AlphaGradientBackground,
		})

		AlphaPicker = Library:New("ImageLabel", {
			Visible = true,
			Parent = AlphaInline,
			Image = Library.Images.Picker,
			Position = NewUdim2(0, -1, 0, -1),
			Size = NewUdim2(0, 17, 0, 5),
			ImageColor3 = NewRGB(255, 255, 255),
			BackgroundTransparency = 1,
		})

		AlphaButton = Library:New("TextButton", {	
			Parent = AlphaInline,
			BackgroundTransparency = 1,
			Text = "",
			Position = NewUdim2(0, 1, 0, 1),
			Size = NewUdim2(1, -2, 1, -2),
			Visible = true,
			BorderSizePixel = 0,
		})
	end

	-- Sat
	local SatInline = Library:New("Frame", {
		Parent = Picker.Content,
		BackgroundTransparency = 0,
		Theme = "Inline 2",
		Position = NewUdim2(0, 4, 0, 4),
		Size = NewUdim2(0, 168, 0, 146),
		Visible = true,
		BorderSizePixel = 0,
	})

	local SatBackground = Library:New("Frame", {
		Parent = SatInline,
		BackgroundTransparency = 0,
		BackgroundColor3 = NewRGB(255, 255, 255),
		Position = NewUdim2(0, 1, 0, 1),
		Size = NewUdim2(1, -2, 1, -2),
		Visible = true,
		BorderSizePixel = 0,
	})

	local SatImage = Library:New("ImageLabel", {
		Visible = true,
		Parent = SatInline,
		Image = Library.Images.Saturation,
		Position = NewUdim2(0, 1, 0, 1),
		Size = NewUdim2(1, -2, 1, -2),
		ImageColor3 = NewRGB(255, 255, 255),
		BackgroundTransparency = 1,
	})

	local SatPicker = Library:New("ImageLabel", {
		Visible = true,
		Parent = SatInline,
		Image = Library.Images.Picker2,
		Position = NewUdim2(0, -1, 0, -1),
		Size = NewUdim2(0, 5, 0, 5),
		ImageColor3 = NewRGB(255, 255, 255),
		BackgroundTransparency = 1,
	})

	local SatButton = Library:New("TextButton", {	
		Parent = SatInline,
		BackgroundTransparency = 1,
		Text = "",
		Position = NewUdim2(0, 1, 0, 1),
		Size = NewUdim2(1, -2, 1, -2),
		Visible = true,
		BorderSizePixel = 0,
	})
	
	-- Hex
	local HexHolder = Library:New("TextButton", {
		Parent = Picker.Content,
		Text = "",
		BackgroundTransparency = 1,
		Position = NewUdim2(0, 4, 0, 154),
		Size = NewUdim2(0, 60, 0, 15),
		Visible = true,
		BorderSizePixel = 0,
	})

	local HexTextBox = Library:TextBox({
		Name = "",
		Default = "#FFFFFF",
		ClearOnFocus = false,
		Center = false,
		Callback = function() end,
		Tooltip = nil,
		Flag = cfg.Flag .. "hex",
	}, HexHolder)

	-- RGB
	local RgbHolder = Library:New("TextButton", {
		Parent = Picker.Content,
		Text = "",
		BackgroundTransparency = 1,
		Position = NewUdim2(0, 68, 0, 154),
		Size = NewUdim2(0, cfg.Transparency and 123 or 104, 0, 15),
		Visible = true,
		BorderSizePixel = 0,
	})

	local RgbTextBox = Library:TextBox({
		Name = "",
		Default = "255, 255, 255, 255",
		ClearOnFocus = false,
		Center = false,
		Callback = function() end,
		Tooltip = nil,
		Flag = cfg.Flag .. "rgb",
	}, RgbHolder)

	-- Color
	local WindowColorInline = Library:New("Frame", {
		Parent = Picker.Content,
		BackgroundTransparency = 0,
		Theme = "Inline 2",
		Position = NewUdim2(0, cfg.Transparency and 195 or 176, 0, 154),
		Size = NewUdim2(0, 15, 0, 15),
		Visible = true,
		BorderSizePixel = 0,
	})

	local WindowColorBackground = Library:New("Frame", {
		Parent = WindowColorInline,
		BackgroundTransparency = 0,
		BackgroundColor3 = NewRGB(255, 255, 255),
		Position = NewUdim2(0, 1, 0, 1),
		Size = NewUdim2(1, -2, 1, -2),
		Visible = true,
		BorderSizePixel = 0,
	})

	local Hue, Sat, Val = cfg.Default:ToHSV()

	function ColorPickerTable:Set(tbl, ignore, set)
		if not cfg.Transparency then
			ColorPickerTable.Transparency = 1
		end

        if type(tbl[1]) == "string" then
            tbl[1] = Color3.fromHex(tbl[1])
        end

		Hue, Sat, Val = tbl[1]:ToHSV()

		if ColorPickerTable.Color ~= tbl[1] or cfg.Transparency ~= tbl[2] then
			ColorPickerTable.Color = tbl[1]
			ColorPickerTable.Transparency = tbl[2]
			
			if cfg.Transparency then
				ColorBackground.BackgroundTransparency = 1 - tbl[2]
				AlphaPicker.Position = NewUdim2(0, -1, 0, math.clamp((1 - tbl[2]) * AlphaGradientBackground.AbsoluteSize.Y, 0, AlphaGradientBackground.AbsoluteSize.Y))
			end

			SatBackground.BackgroundColor3 = NewHSV(ColorPickerTable.HuePosition, 1, 1)

			ColorBackground.BackgroundColor3 = tbl[1]
			WindowColorBackground.BackgroundColor3 = tbl[1]

			if not ignore then
				ColorPickerTable.HuePosition = Hue
				HuePicker.Position = NewUdim2(0, -1, 1 - Hue, -1)
			end

			SatPicker.Position = NewUdim2(0, math.clamp(Sat * SatImage.AbsoluteSize.X, 0, SatImage.AbsoluteSize.X) - 1, 0, math.clamp(SatImage.AbsoluteSize.Y - Val * SatImage.AbsoluteSize.Y, 0, SatImage.AbsoluteSize.Y) - 1)

			HexTextBox:Set(tostring(Utility:ToHex(tbl[1])))

			if cfg.Transparency then
				RgbTextBox:Set(("%s, %s, %s, %s"):format(math.round(tbl[1].R * 255), math.round(tbl[1].G * 255), math.round(tbl[1].B * 255), math.round(tbl[2] * 255)))
			else
				RgbTextBox:Set(("%s, %s, %s"):format(math.round(tbl[1].R * 255), math.round(tbl[1].G * 255), math.round(tbl[1].B * 255)))
			end

			if cfg.Transparency then
				Library.Flags[cfg.Flag] = {tbl[1], tbl[2]}
				cfg.Callback({tbl[1], tbl[2]}, set)
			else
				Library.Flags[cfg.Flag] = {tbl[1]}
				cfg.Callback({tbl[1]}, set)
			end
		end
	end

	function ColorPickerTable:Get()
		return {ColorPickerTable.Color, ColorPickerTable.Transparency}
	end

	-- Animations
	local RainbowSpeedSlider, RainbowDepthSlider, RainbowIntensitySlider, FadingFirstColorPicker, FadingSecondColorPicker, FadingSpeedSlider, AnimTypeDropDown
	if animations then
		local AnimOutline = Library:New("Frame", {
			Parent = Animation.Content,
			BackgroundTransparency = 0,
			Theme = "Outline",
			Position = NewUdim2(0, 4, 0, 41),
			Size = NewUdim2(1, -8, 0, 3),
			Visible = true,
			BorderSizePixel = 0,
		})
		local AnimBackground = Library:New("Frame", {
			Parent = Animation.Content,
			BackgroundTransparency = 0,
			Theme = "Outline",
			Position = NewUdim2(0, 4, 0, 48),
			Size = NewUdim2(1, -8, 0, 121),
			Visible = true,
			BorderSizePixel = 0,
		})
		local AnimText = Library:New("TextLabel", {
			Parent = AnimBackground,
			Theme = "Text",
			Text = "Settings\nNot Supported",
			BackgroundTransparency = 1,
			Position = NewUdim2(0, 0, 0, 0),
			Font = Library.Font,
			TextSize = Library.Size,
			TextXAlignment = Enum.TextXAlignment.Center,
			Size = NewUdim2(1, 0, 1, 0),
			Visible = true,
			BorderSizePixel = 0,
		})

		-- Rainbow
		local RainbowHolder = Library:New("Frame", {
			Parent = AnimBackground,
			BackgroundTransparency = 1,
			Position = NewUdim2(0, 0, 0, 0),
			Size = NewUdim2(1, 0, 1, 0),
			Visible = true,
			BorderSizePixel = 0,
		})
		Library:New("UIListLayout", {
			Padding = UDim.new(0, 4),
			Parent = RainbowHolder,
			FillDirection = Enum.FillDirection.Vertical,
			SortOrder = Enum.SortOrder.LayoutOrder,
		})

		-- Speed
		local RainbowSpeedHolder = Library:New("TextButton", {
			Parent = RainbowHolder,
			Text = "",
			BackgroundTransparency = 1,
			Position = NewUdim2(0, 0, 0, 0),
			Size = NewUdim2(1, 0, 0, 23),
			Visible = true,
			BorderSizePixel = 0,
		})
		RainbowSpeedSlider = Library:Slider({
			Name = "Speed",
			Min = 0,
			Max = 500,
			Float = 1,
			Default = 20,
			Ignore = cfg.Ignore,
			Flag = cfg.Flag .. "rainbow speed",
			Tooltip = nil,
			Callback = function() end,
		}, RainbowSpeedHolder)

		-- Depth
		local RainbowDepthHolder = Library:New("TextButton", {
			Parent = RainbowHolder,
			Text = "",
			BackgroundTransparency = 1,
			Position = NewUdim2(0, 0, 0, 0),
			Size = NewUdim2(1, 0, 0, 23),
			Visible = true,
			BorderSizePixel = 0,
		})
		RainbowDepthSlider = Library:Slider({
			Name = "Depth",
			Min = 0,
			Max = 100,
			Float = 1,
			Default = 0,
			Ignore = cfg.Ignore,
			Flag = cfg.Flag .. "rainbow depth",
			Tooltip = nil,
			Callback = function() end,
		}, RainbowDepthHolder)

		-- Intensity
		local RainbowIntensityHolder = Library:New("TextButton", {
			Parent = RainbowHolder,
			Text = "",
			BackgroundTransparency = 1,
			Position = NewUdim2(0, 0, 0, 0),
			Size = NewUdim2(1, 0, 0, 23),
			Visible = true,
			BorderSizePixel = 0,
		})
		RainbowIntensitySlider = Library:Slider({
			Name = "Intensity",
			Min = 0,
			Max = 10,
			Float = 1,
			Default = 0,
			Flag = cfg.Flag .. "rainbow intensity",
			Ignore = cfg.Ignore,
			Tooltip = nil,
			Callback = function() end,
		}, RainbowIntensityHolder)

		local AnimTypeHolder = Library:New("TextButton", {
			Parent = Animation.Content,
			Text = "",
			BackgroundTransparency = 1,
			Position = NewUdim2(0, 4, 0, 4),
			Size = NewUdim2(0, 150, 0, 33),
			Visible = true,
			BorderSizePixel = 0,
		})

		-- Fading
		local FadingHolder = Library:New("Frame", {
			Parent = AnimBackground,
			BackgroundTransparency = 1,
			Position = NewUdim2(0, 0, 0, 0),
			Size = NewUdim2(1, 0, 1, 0),
			Visible = true,
			BorderSizePixel = 0,
		})
		Library:New("UIListLayout", {
			Padding = UDim.new(0, 4),
			Parent = FadingHolder,
			FillDirection = Enum.FillDirection.Vertical,
			SortOrder = Enum.SortOrder.LayoutOrder,
		})

		-- First Color
		local FadingFirstHolder = Library:New("TextButton", {
			Parent = FadingHolder,
			Text = "",
			BackgroundTransparency = 1,
			Position = NewUdim2(0, 0, 0, 0),
			Size = NewUdim2(1, 0, 0, 10),
			Visible = true,
			BorderSizePixel = 0,
		})
		FadingFirstColorPicker = Library:ColorPicker({
			Name = "First Color",
			Tooltip = nil,
			Default = NewRGB(255, 255, 255),
			Transparency = cfg.Transparency and 1 or nil,
			Ignore = cfg.Ignore,
			Flag = cfg.Flag .. "fading first",
			Callback = function() end,
		}, FadingFirstHolder, 1, false)

		-- Second Color
		local FadingSecondHolder = Library:New("TextButton", {
			Parent = FadingHolder,
			Text = "",
			BackgroundTransparency = 1,
			Position = NewUdim2(0, 0, 0, 0),
			Size = NewUdim2(1, 0, 0, 10),
			Visible = true,
			BorderSizePixel = 0,
		})
		FadingSecondColorPicker = Library:ColorPicker({
			Name = "Second Color",
			Tooltip = nil,
			Default = NewRGB(0, 0, 0),
			Transparency = cfg.Transparency and 1 or nil,
			Flag = cfg.Flag .. "fading second",
			Ignore = cfg.Ignore,
			Callback = function() end,
		}, FadingSecondHolder, 1, false)		

		-- Speed
		local FadingSpeedHolder = Library:New("TextButton", {
			Parent = FadingHolder,
			Text = "",
			BackgroundTransparency = 1,
			Position = NewUdim2(0, 0, 0, 0),
			Size = NewUdim2(1, 0, 0, 23),
			Visible = true,
			BorderSizePixel = 0,
		})
		FadingSpeedSlider = Library:Slider({
			Name = "Speed",
			Min = 0,
			Max = 500,
			Float = 1,
			Default = 20,
			Flag = cfg.Flag .. "fading speed",
			Ignore = cfg.Ignore,
			Tooltip = nil,
			Callback = function() end,
		}, FadingSpeedHolder)

		local function SetOpen(v)
			if v then
				AnimText.Visible = false
				AnimBackground.BackgroundTransparency = 1
			else
				AnimText.Visible = true
				AnimBackground.BackgroundTransparency = 0
			end
		end

		AnimTypeDropDown = Library:Dropdown({
			Name = "Animation Type",
			Content = {"None", "Rainbow", "Fading"},
			Default = "None",
			Multi = false,
			Callback = function(v)
				if v == "None" then
					SetOpen(false)
					RainbowHolder.Visible = false
					FadingHolder.Visible = false
				elseif v == "Rainbow" then
					RainbowHolder.Visible = true
					FadingHolder.Visible = false
					SetOpen(true)
				elseif v == "Fading" then
					RainbowHolder.Visible = false
					FadingHolder.Visible = true
					SetOpen(true)
				end
			end,
			Tooltip = nil,
			Ignore = cfg.Ignore,
			Flag = cfg.Flag .. "type",
		}, AnimTypeHolder, "Left")

		task.spawn(function()
			while task.wait() do
				local Color = nil
				local Alpha = nil
				if Library.Flags[cfg.Flag .. "type"] == "Rainbow" then
					local SinWave = math.abs((1 - Library.Flags[cfg.Flag .. "rainbow depth"] / 100) * (math.cos((tick() - StartTick) * math.pi * (Library.Flags[cfg.Flag .. "rainbow speed"] / 100)) ^ (Library.Flags[cfg.Flag .. "rainbow intensity"])) + Library.Flags[cfg.Flag .. "rainbow depth"]/ 100) or 1
					Color = NewHSV(SinWave, 1, 1)
				elseif Library.Flags[cfg.Flag .. "type"] == "Fading" then 
					local SinWave = math.abs(math.sin(os.clock() * (Library.Flags[cfg.Flag .. "fading speed"] / 50)))
					Color = Utility:ColorRange(SinWave, {
						[1] = {
							start = 0,
							color = Library.Flags[cfg.Flag .. "fading first"][1],
						},
						[2] = {
							start = 1,
							color = Library.Flags[cfg.Flag .. "fading second"][1],
						},
					})	
					
					if cfg.Transparency then
						Alpha = Utility:NumberLerp(SinWave, {
							[1] = {
								start = 0.1,
								number = Library.Flags[cfg.Flag .. "fading first"][2],
							},
							[2] = {
								start = 1,
								number = Library.Flags[cfg.Flag .. "fading second"][2],
							},
						})	
					end
				end
				if Color ~= nil then 
					ColorPickerTable:Set({Color, Alpha and Alpha or ColorPickerTable.Transparency}, false, true)
				end
			end
		end)
	end

	function ColorPickerTable:SetTheme(theme)
		Library.Theme[theme][2] = {RainbowSpeedSlider = RainbowSpeedSlider.Get(), RainbowDepthSlider = RainbowDepthSlider.Get(), RainbowIntensitySlider = RainbowIntensitySlider.Get(), FadingFirstColorPicker = FadingFirstColorPicker:Get(), FadingSecondColorPicker = FadingSecondColorPicker:Get(), FadingSpeedSlider = FadingSpeedSlider.Get(), AnimTypeDropDown = AnimTypeDropDown:Get()}
	end

	Library.Flags[cfg.Flag .. " theme"] = function(theme)
		ColorPickerTable:SetTheme(theme)
	end

	if animations then
		function ColorPickerTable:SetAnim(tbl)
			RainbowSpeedSlider.Set(tbl.RainbowSpeedSlider)
			RainbowDepthSlider.Set(tbl.RainbowDepthSlider)
			RainbowIntensitySlider.Set(tbl.RainbowIntensitySlider)
			FadingFirstColorPicker:Set(tbl.FadingFirstColorPicker)
			FadingSecondColorPicker:Set(tbl.FadingSecondColorPicker)
			FadingSpeedSlider.Set(tbl.FadingSpeedSlider)
			AnimTypeDropDown:Set(tbl.AnimTypeDropDown)
		end

		Library.Flags[cfg.Flag .. " anim"] = function(tbl)
			ColorPickerTable:SetAnim(tbl)
		end
	end

	Picker:Show()

	ColorPickerTable:Set({cfg.Default, cfg.Transparency})

	local function SlideSaturation(input)
		local SizeX = math.clamp((input.Position.X - SatImage.AbsolutePosition.X) / SatImage.AbsoluteSize.X, 0, 1)
		local SizeY = math.clamp(1 - (input.Position.Y - SatImage.AbsolutePosition.Y) / SatImage.AbsoluteSize.Y, 0, 1)

		ColorPickerTable:Set({NewHSV(ColorPickerTable.HuePosition, SizeX, SizeY), ColorPickerTable.Transparency}, true)
	end

	Utility:Connect(SatButton.MouseButton1Down, function()
		ColorPickerTable.SlidingSat = true
		SlideSaturation({Position = UserInputService:GetMouseLocation() - NewVector(0, 36)})
	end)

	local function SlideHue(input)
		local SizeY = 1 - math.clamp((input.Position.Y - HueGradientBackground.AbsolutePosition.Y) / HueGradientBackground.AbsoluteSize.Y, 0, 1)
		local PosY = math.clamp(((input.Position.Y - HueGradientBackground.AbsolutePosition.Y) / HueGradientBackground.AbsoluteSize.Y) * HueGradientBackground.AbsoluteSize.Y, 0, HueGradientBackground.AbsoluteSize.Y - 1)
	
		HuePicker.Position = NewUdim2(0, -1, 0, PosY - 1)
		ColorPickerTable.HuePosition = SizeY

		ColorPickerTable:Set({NewHSV(SizeY, Sat, Val), ColorPickerTable.Transparency})
	end

	Utility:Connect(HueButton.MouseButton1Down, function()
		ColorPickerTable.SlidingHue = true
		SlideHue({Position = UserInputService:GetMouseLocation() - NewVector(0, 36)})
	end)

	local function SlideTrans(input)
		local SizeY = 1 - math.clamp((input.Position.Y - AlphaGradientBackground.AbsolutePosition.Y) / AlphaGradientBackground.AbsoluteSize.Y, 0, 1)
	
		ColorPickerTable:Set({NewHSV(ColorPickerTable.HuePosition, Sat, Val), SizeY}, true)
	end

	if cfg.Transparency then
		Utility:Connect(AlphaButton.MouseButton1Down, function()
			ColorPickerTable.SlidingAlpha = true
			SlideTrans({Position = UserInputService:GetMouseLocation() - NewVector(0, 36)})
		end)
	end

	Utility:Connect(Button.MouseButton1Down, function()
		WindowInline.Position = NewUdim2(0, Inline.AbsolutePosition.X + 1, 0, Inline.AbsolutePosition.Y + 9)
		WindowInline.Visible = not WindowInline.Visible
	end)

	Utility:Connect(UserInputService.InputBegan, function(input)
		if input.UserInputType == Enum.UserInputType.MouseWheel and not (Utility:InBounds(WindowInline, input.Position) or Utility:InBounds(Background, input.Position)) and WindowInline.Visible then
			WindowInline.Visible = false
		end
	end)

	Utility:Connect(UserInputService.InputEnded, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            ColorPickerTable.SlidingSat, ColorPickerTable.SlidingHue, ColorPickerTable.SlidingAlpha = false, false, false
        end
    end)

	Utility:Connect(UserInputService.InputChanged, function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            if ColorPickerTable.SlidingSat then
                SlideSaturation(input)
            elseif ColorPickerTable.SlidingHue then
                SlideHue(input)
            elseif ColorPickerTable.SlidingAlpha then
                SlideTrans(input)
            end

			if WindowInline.Visible then
				WindowInline.Position = NewUdim2(0, Inline.AbsolutePosition.X + 1, 0, Inline.AbsolutePosition.Y + 9)
			end
        end

		if input.UserInputType == Enum.UserInputType.MouseWheel and not (Utility:InBounds(WindowInline, input.Position) or Utility:InBounds(Background, input.Position)) and WindowInline.Visible then
			WindowInline.Visible = false
		end
    end)

	local WindowOutline = Library:New("Frame", {
		Position = NewUdim2(0, 0, 0, 0),
		Parent = WindowBackground,
		BackgroundTransparency = 0,
		Theme = "Outline",
		Size = NewUdim2(0, 2, 1, 0),
		Visible = true,
		BorderSizePixel = 0,
	})
	local WindowOutline2 = Library:New("Frame", {
		Position = NewUdim2(0, 2, 0, 0),
		Parent = WindowBackground,
		BackgroundTransparency = 0,
		Theme = "Outline",
		Size = NewUdim2(1, -2, 0, 2),
		Visible = true,
		BorderSizePixel = 0,
	})
	local WindowOutline4 = Library:New("Frame", {
		Position = NewUdim2(0, 0, 0, 20),
		Parent = WindowBackground,
		BackgroundTransparency = 0,
		Theme = "Outline",
		Size = NewUdim2(1, 0, 0, 2),
		Visible = true,
		BorderSizePixel = 0,
	})

	--[[Utility:Connect(UserInputService.InputEnded, function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and not (Utility:InBounds(WindowInline, input.Position) or Utility:InBounds(Background, input.Position)) and WindowInline.Visible then
			WindowInline.Visible = false
		end

		if input.UserInputType == Enum.UserInputType.MouseWheel and not (Utility:InBounds(WindowInline, input.Position) or Utility:InBounds(Background, input.Position)) and WindowInline.Visible then
			WindowInline.Visible = false
		end
	end)]]

	Utility:Connect(RgbTextBox.TextBox.FocusLost, function()
		local Alpha = 0
		local Color = RgbTextBox.TextBox.Text
		if cfg.Transparency then
			if Color:find("%d+[, ]%s?%d+[, ]%s?%d+[, ]%s?%d+") then
				local Colors = {}
		
				for v in Color:gmatch("%d+") do
					Colors[#Colors + 1] = math.clamp(tonumber(v), 0, 255)
				end

				Alpha = math.clamp(tonumber(Colors[4]), 0, 255)

				ColorPickerTable:Set({NewRGB(Colors[1], Colors[2], Colors[3]), Alpha / 255})
			end
		else
			local Color = RgbTextBox.TextBox.Text
			if Color:find("%d+[, ]%s?%d+[, ]%s?%d+") then
				local Colors = {}
		
				for v in Color:gmatch("%d+") do
					Colors[#Colors + 1] = math.clamp(tonumber(v), 0, 255)
				end
	
				ColorPickerTable:Set({NewRGB(Colors[1], Colors[2], Colors[3]), 1})
			end	
		end
	end)
	
	Utility:Connect(HexTextBox.TextBox.FocusLost, function()
		local Color = HexTextBox.TextBox.Text

		if Color:find("#[0-9A-Fa-f]+") then
			Color = Color:gsub("#", "")
			local Colors = {}

			for i = 1, 6, 2 do
				local Value = tonumber(Color:sub(i, i+1), 16)
				Colors[#Colors + 1] = math.clamp(Value, 0, 255)
			end
			
			ColorPickerTable:Set({NewRGB(Colors[1], Colors[2], Colors[3]), 1})
		end
	end)

	if not cfg.Ignore then
		Library.ConfigFlags[cfg.Flag] = function(tbl)
			ColorPickerTable:Set(tbl)
		end
	end

	return ColorPickerTable
end

function Library:Toggle(cfg, holder)
	local ToggleTable = {
		Toggled = false,
		SideCount = 0,
		DownCount = 0,
	}

	local TextBounds = Utility:GetTextBounds(cfg.Name, Library.Font, Library.Size)

	local Inline = Library:New("Frame", {
		Parent = holder,
		BackgroundTransparency = 0,
		Theme = "Inline 2",
		Position = NewUdim2(0, 0, 0, 0),
		Size = NewUdim2(0, 10, 0, 10),
		Visible = true,
		BorderSizePixel = 0,
	})
	local Background = Library:New("Frame", {
		Parent = Inline,
		BackgroundTransparency = 0,
		Theme = "Background",
		Position = NewUdim2(0, 1, 0, 1),
		Size = NewUdim2(1, -2, 1, -2),
		Visible = true,
		BorderSizePixel = 0,
	})
	local Outline = Library:New("Frame", {
		Position = NewUdim2(0, 0, 0, 0),
		Parent = Background,
		BackgroundTransparency = 0.7,
		Theme = "Outline",
		Size = NewUdim2(0, 2, 1, 0),
		Visible = true,
		BorderSizePixel = 0,
	})
	local Outline2 = Library:New("Frame", {
		Position = NewUdim2(0, 2, 0, 0),
		Parent = Background,
		BackgroundTransparency = 0.7,
		Theme = "Outline",
		Size = NewUdim2(1, -2, 0, 2),
		Visible = true,
		BorderSizePixel = 0,
	})
	local Title = Library:New("TextLabel", {
		Parent = holder,
		Theme = "Text",
		Text = cfg.Name,
		BackgroundTransparency = 1,
		Position = NewUdim2(0, 15, 0, -2),
		Font = Library.Font,
		TextSize = Library.Size,
		Size = NewUdim2(0, TextBounds.X, 0, TextBounds.Y),
		Visible = true,
		BorderSizePixel = 0,
	})

	function ToggleTable:Set(bool)
		ToggleTable.Toggled = bool

		Library:ChangeObjectTheme(Background, ToggleTable.Toggled and "Accent" or "Dark Background", true)

		Library:ChangeObjectTheme(Inline, ToggleTable.Toggled and "Accent" or "Inline 2", true)

		Library.Flags[cfg.Flag] = ToggleTable.Toggled

		cfg.Callback(ToggleTable.Toggled)
	end

	function ToggleTable:Toggle()
		ToggleTable.Toggled = not ToggleTable.Toggled

		Library:ChangeObjectTheme(Background, ToggleTable.Toggled and "Accent" or "Dark Background", true)

		Library:ChangeObjectTheme(Inline, ToggleTable.Toggled and "Accent" or "Inline 2", true)

		Library.Flags[cfg.Flag] = ToggleTable.Toggled

		cfg.Callback(ToggleTable.Toggled)
	end

	ToggleTable:Set(cfg.State)

	Utility:Connect(holder.MouseButton1Down, ToggleTable.Toggle)

	Utility:Connect(holder.MouseEnter, function()
		Library:ChangeObjectTheme(Inline, ToggleTable.Toggled and "Accent" or "Inline", true)
	end)

	Utility:Connect(holder.MouseLeave, function()
		Library:ChangeObjectTheme(Inline, ToggleTable.Toggled and "Accent" or "Inline 2", true)
	end)

	if cfg.Tooltip then
		Library:Tooltip(cfg.Tooltip, holder)
	end

	Library.ConfigFlags[cfg.Flag] = function(bool)
		ToggleTable:Set(bool)
	end

	function ToggleTable:Keybind(cfg)
		cfg = cfg or {}

		Library:Default(cfg, {
			Mode = "Toggle",
			Key = "",
			Callback = function() end,
			Flag = "keybind",
		})

		ToggleTable.SideCount += 1

		local KeybindTable = Library:Keybind(cfg, holder, ToggleTable.SideCount)

		return KeybindTable
	end

	function ToggleTable:ColorPicker(cfg)
		cfg = cfg or {}
		local ColorTable = {}

		Library:Default(cfg, {
			Tooltip = nil,
			Default = NewRGB(0, 0, 0),
			Transparency = nil,
			Flag = "colorpicker",
			Callback = function() end,
		})

		ToggleTable.SideCount += 1

		local ColorPickerTable = Library:ColorPicker(cfg, holder, ToggleTable.SideCount, true)

		return ColorPickerTable
	end

	function ToggleTable:Slider(cfg)
		cfg = cfg or {}

		Library:Default(cfg, {
			Min = 0,
			Max = 100,
			Float = 1,
			Default = 50,
			Flag = "slider",
			Callback = function() end,
		})

		ToggleTable.DownCount += 1

		holder.Size += NewUdim2(0, 0, 0, 14)

		local SliderTable = Library:Slider(cfg, holder, ToggleTable.DownCount)
	end

	return ToggleTable
end

function Library:Slider(cfg, holder, count)
	cfg = cfg or {}

	count = count or nil

	local SliderTable = {
		Value = 0,
		Sliding = false,
	}

	local Inline = Library:New("Frame", {
		Parent = holder,
		BackgroundTransparency = 0,
		Theme = "Inline 2",
		Position = NewUdim2(0, 0, 0, not count and 15 or count * 14),
		Size = NewUdim2(1, 0, 0, 8),
		Visible = true,
		BorderSizePixel = 0,
	})
	Library:New("TextButton", {
		Parent = Inline,
		BackgroundTransparency = 1,
		Text = "",
		Position = NewUdim2(0, 1, 0, 1),
		Size = NewUdim2(1, -2, 1, -2),
		Visible = true,
		BorderSizePixel = 0,
	})
	local Background = Library:New("Frame", {
		Parent = Inline,
		BackgroundTransparency = 0,
		Theme = "Dark Background",
		Position = NewUdim2(0, 1, 0, 1),
		Size = NewUdim2(1, -2, 1, -2),
		Visible = true,
		BorderSizePixel = 0,
	})
	local Accent = Library:New("Frame", {
		Parent = Background,
		BackgroundTransparency = 0,
		Theme = "Accent",
		Position = NewUdim2(0, 0, 0, 0),
		Size = NewUdim2(0, 0, 1, 0),
		Visible = true,
		BorderSizePixel = 0,
	})
	local Outline = Library:New("Frame", {
		Position = NewUdim2(0, 0, 0, 0),
		Parent = Background,
		BackgroundTransparency = 0.7,
		Theme = "Outline",
		Size = NewUdim2(0, 2, 1, 0),
		Visible = true,
		BorderSizePixel = 0,
	})
	local Outline2 = Library:New("Frame", {
		Position = NewUdim2(0, 2, 0, 0),
		Parent = Background,
		BackgroundTransparency = 0.7,
		Theme = "Outline",
		Size = NewUdim2(1, -2, 0, 2),
		Visible = true,
		BorderSizePixel = 0,
	})
	if cfg.Name then
		local TextBounds = Utility:GetTextBounds(cfg.Name, Library.Font, Library.Size)
		local Title = Library:New("TextLabel", {
			Parent = holder,
			Theme = "Text",
			Text = cfg.Name,
			BackgroundTransparency = 1,
			Position = NewUdim2(0, 0, 0, 0),
			Font = Library.Font,
			TextSize = Library.Size,
			Size = NewUdim2(0, TextBounds.X, 0, TextBounds.Y),
			Visible = true,
			BorderSizePixel = 0,
		})
	end
	local ValueText = Library:New("TextLabel", {
		Parent = Background,
		Theme = "Text",
		Text = "",
		TextTransparency = 1,
		BackgroundColor3 = NewRGB(60, 60, 60),
		BackgroundTransparency = 1,
		Position = NewUdim2(0, 0, 0, 2),
		Font = Library.Font,
		TextSize = Library.Size,
		Size = NewUdim2(0, 0, 1, 0),
		Visible = true,
		BorderSizePixel = 0,
	})
	local Drag = Library:New("Frame", {
		Parent = Background,
		BackgroundTransparency = 1,
		Position = NewUdim2(0, 0, 0, 0),
		Size = NewUdim2(1, 0, 1, 0),
		Visible = true,
		BorderSizePixel = 0,
	})

	local function Set(value)
		value = math.clamp(Library:Round(value, cfg.Float), cfg.Min, cfg.Max)

		local Size = (value - cfg.Min) / (cfg.Max - cfg.Min)

		if value ~= SliderTable.Value then
			SliderTable.Value = value
			Library:Tween(Accent, true, {Size = NewUdim2(Size, 0, 1, 0)})
		end

		Library:ChangeObjectTheme(Inline, SliderTable.Value > cfg.Min and "Accent" or "Inline 2", true)

		Library.Flags[cfg.Flag] = value
		cfg.Callback(value)
		
		local TextBounds = Utility:GetTextBounds(string.format("%.14g", SliderTable.Value), Library.Font, Library.Size)

		Library:Tween(ValueText, true, {Position = NewUdim2(Size, -((TextBounds.X + 4) / 2), 0, 2), Size = NewUdim2(0, TextBounds.X + 3, 1, 2)})
		ValueText.Text = string.format("%.14g", SliderTable.Value)
	end

	local function Slide(input)
		local Size = (input.Position.X - Background.AbsolutePosition.X) / Background.AbsoluteSize.X
		local value = math.clamp((cfg.Max - cfg.Min) * Size + cfg.Min, cfg.Min, cfg.Max)

		Library:ChangeObjectTheme(Inline, SliderTable.Value > cfg.Min and "Accent" or "Inline 2", true)

		Set(value)
	end

	local function Get()
		return SliderTable.Value
	end

	Set(cfg.Default)

	Utility:Connect(Drag.InputBegan, function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			SliderTable.Sliding = true
			Slide(input)
		end
	end)

	Utility:Connect(Drag.InputEnded, function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			SliderTable.Sliding = false
		end
	end)

	Utility:Connect(UserInputService.InputChanged, function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement and SliderTable.Sliding then
			Slide(input)
		end
	end)

	Utility:Connect(Inline.MouseEnter, function()
		Library:ChangeObjectTheme(Inline, SliderTable.Value > cfg.Min and "Accent" or "Inline", true)
		Library:Tween(ValueText, true, {TextTransparency = 0, BackgroundTransparency = 0.2})
	end)

	Utility:Connect(Inline.MouseLeave, function()
		Library:Tween(ValueText, true, {TextTransparency = 1, BackgroundTransparency = 1})
		Library:ChangeObjectTheme(Inline, SliderTable.Value > cfg.Min and "Accent" or "Inline 2", true)
	end)

	if cfg.Tooltip then
		Library:Tooltip(cfg.Tooltip, holder)
	end

	if not cfg.Ignore then
		Library.ConfigFlags[cfg.Flag] = Set
	end
	SliderTable.Set = Set
	SliderTable.Get = Get

	return SliderTable
end

function Library:Dropdown(cfg, holder, side)
	local DropdownTable = {
		Values = cfg.Content,
		Value = cfg.Multi and {} or nil,
		Multi = cfg.Multi,
		IsTweening = false,
	}
	local TextBounds = Utility:GetTextBounds(cfg.Name, Library.Font, Library.Size)

	local Inline = Library:New("Frame", {
		Parent = holder,
		BackgroundTransparency = 0,
		Theme = "Inline 2",
		Position = NewUdim2(0, 0, 1, -18),
		Size = NewUdim2(1, 0, 1, -15),
		Visible = true,
		BorderSizePixel = 0,
	})
	local Background = Library:New("Frame", {
		Parent = Inline,
		BackgroundTransparency = 0,
		Theme = "Dark Background",
		Position = NewUdim2(0, 1, 0, 1),
		Size = NewUdim2(1, -2, 1, -2),
		Visible = true,
		BorderSizePixel = 0,
	})
	local BackgroundButton = Library:New("TextButton", {
		Parent = Inline,
		BackgroundTransparency = 1,
		Position = NewUdim2(0, 0, 0, 0),
		Size = NewUdim2(1, 0, 1, 0),
		Visible = true,
		Text = "",
		BorderSizePixel = 0,
	})
	local Outline = Library:New("Frame", {
		Position = NewUdim2(0, 0, 0, 0),
		Parent = Background,
		BackgroundTransparency = 0.7,
		Theme = "Outline",
		Size = NewUdim2(0, 2, 1, 0),
		Visible = true,
		BorderSizePixel = 0,
	})
	local Outline2 = Library:New("Frame", {
		Position = NewUdim2(0, 2, 0, 0),
		Parent = Background,
		BackgroundTransparency = 0.7,
		Theme = "Outline",
		Size = NewUdim2(1, -2, 0, 2),
		Visible = true,
		BorderSizePixel = 0,
	})
	local Title = Library:New("TextLabel", {
		Parent = holder,
		Theme = "Text",
		Text = cfg.Name,
		BackgroundTransparency = 1,
		Position = NewUdim2(0, 0, 0, 0),
		Font = Library.Font,
		TextSize = Library.Size,
		Size = NewUdim2(0, TextBounds.X, 0, TextBounds.Y),
		Visible = true,
		BorderSizePixel = 0,
	})
	local ValuesText = Library:New("TextLabel", {
		Parent = Background,
		Theme = "Text",
		Text = "-",
		BackgroundTransparency = 1,
		Position = NewUdim2(0, 5, 0, 0),
		Font = Library.Font,
		TextSize = Library.Size,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = NewUdim2(1, -5, 1, -2),
		Visible = true,
		BorderSizePixel = 0,
	})
	local ArrowIcon = Library:New("ImageLabel", {
		Visible = true,
		Parent = Background,
		Image = 'http://www.roblox.com/asset/?id=6282522798',
		Position = NewUdim2(1, -14, 0.5, -4),
		Size = NewUdim2(0, 8, 0, 8),
		ImageColor3 = NewRGB(255, 255, 255),
		BackgroundTransparency = 1,
	})
	
	local Objects = {
		Default = {}
	}
	local MaxVisibleContent = 4

	Objects.Default.ContentInline = Library:New("Frame", {
		Parent = Library.OverlayFrame,
		BackgroundTransparency = 1,
		Theme = "Inline 2",
		Size = NewUdim2(0, Inline.AbsoluteSize.X, 0, 0),
		Visible = false,
		BorderSizePixel = 0,
		ClipsDescendants = true,
	})
	Objects.Default.ContentBackground = Library:New("Frame", {
		Parent = Objects.Default.ContentInline,
		BackgroundTransparency = 1,
		Theme = "Dark Background",
		Position = NewUdim2(0, 1, 0, 1),
		Size = NewUdim2(1, -2, 1, -2),
		Visible = true,
		BorderSizePixel = 0,
	})
	Objects.Default.ContentOutline = Library:New("Frame", {
		Position = NewUdim2(0, 0, 0, 0),
		Parent = Objects.Default.ContentBackground,
		BackgroundTransparency = 1,
		Theme = "Outline",
		Size = NewUdim2(0, 2, 1, 0),
		Visible = true,
		BorderSizePixel = 0,
	})
	Objects.Default.ContentOutline2 = Library:New("Frame", {
		Position = NewUdim2(0, 2, 0, 0),
		Parent = Objects.Default.ContentBackground,
		BackgroundTransparency = 1,
		Theme = "Outline",
		Size = NewUdim2(1, -2, 0, 2),
		Visible = true,
		BorderSizePixel = 0,
	})
	Objects.Default.Content = Library:New("ScrollingFrame", {
		Theme = "Accent",
		Parent = Objects.Default.ContentBackground,
		BackgroundTransparency = 1,
		Position = NewUdim2(0, 0, 0, 0),
		Size = NewUdim2(1, 0, 1, 0),
		CanvasSize = NewUdim2(0, 0, 0, 0),
		Visible = true,
		BorderSizePixel = 0,
		MidImage = "rbxassetid://12776289446",
		BottomImage = "rbxassetid://12776289446",
		TopImage = "rbxassetid://12776289446",
		ScrollBarThickness = 2,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
	})
	Library:New("UIListLayout", {
		Parent = Objects.Default.Content,
		Padding = NewUdim(0, 0),
		FillDirection = Enum.FillDirection.Vertical,
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	local function Display()
		if DropdownTable.Multi then
			local CurrentText = {}

			if #DropdownTable.Value > 0 then
				for _,v in pairs(DropdownTable.Value) do
					CurrentText[#CurrentText + 1] = v

					local Text = table.concat(CurrentText, ", ")
					ValuesText.Text = Text

					local Size = Utility:GetTextBounds(Text, Library.Font, Library.Size)

					if Size.X > Objects.Default.ContentBackground.AbsoluteSize.X - 20 then
						table.remove(CurrentText, #CurrentText)

						ValuesText.Text = table.concat(CurrentText, ", ") .. ", ..."
						return
					end
				end
			else
				ValuesText.Text = "-"
			end
		else
			ValuesText.Text = DropdownTable.Value or "-"
		end
	end

	function DropdownTable:Set(chosen, ignore)
		if DropdownTable.Multi then
			if typeof(chosen) == "table" then
				for _,v in pairs(chosen) do
					if not table.find(DropdownTable.Value, v) then
						DropdownTable:Set(v, true)
					end
				end

				local RemovedButtons = {}

				for _,v in pairs(DropdownTable.Value) do
					if not table.find(chosen, v) then
						RemovedButtons[#RemovedButtons + 1] = v
					end
				end

				for _,v in pairs(RemovedButtons) do
					DropdownTable:Set(v)
				end

				Library.Flags[cfg.Flag] = DropdownTable.Value
				cfg.Callback(DropdownTable.Value)

				return
			end

			local Index = table.find(DropdownTable.Value, chosen)

			if Index then
				table.remove(DropdownTable.Value, Index)
				
				Display()
				
				Objects[chosen].Chosen = false

				Library:ChangeObjectTheme(Objects[chosen].Text, "Text", true)

				Library.Flags[cfg.Flag] = DropdownTable.Value
				cfg.Callback(DropdownTable.Value)
			else
				DropdownTable.Value[#DropdownTable.Value + 1] = chosen	

				Display()

				Objects[chosen].Chosen = true

				Library:ChangeObjectTheme(Objects[chosen].Text, "Accent", true)

				if not ignore then
					Library.Flags[cfg.Flag] = DropdownTable.Value
					cfg.Callback(DropdownTable.Value)
				end
			end
		else
			if chosen ~= DropdownTable.Value then
				DropdownTable.Value = chosen

				for _,v in pairs(Objects) do
					if _ ~= "Default" and _ ~= chosen and v.Chosen then
						v.Chosen = false
						Library:ChangeObjectTheme(v.Text, "Text", true)
					end
				end

				Display()

				local Option = Objects[chosen]

				if Option then
					Option.Chosen = true

					Library:ChangeObjectTheme(Option.Text, "Accent", true)

					Library.Flags[cfg.Flag] = chosen
					cfg.Callback(chosen)
				end
			end
		end
	end

	local Count = 0
	function DropdownTable:Add(name)
		local Button = Library:New("TextButton", {
			Parent = Objects.Default.Content,
			Text = "",
			BackgroundTransparency = 1,
			Position = NewUdim2(0, 0, 0, 0),
			Size = NewUdim2(1, 0, 0, 18),
			Visible = true,
			BorderSizePixel = 0,
		})
		local Name = Library:New("TextLabel", {
			Parent = Button,
			Theme = "Text",
			Text = name,
			BackgroundTransparency = 1,
			Position = NewUdim2(0, 3, 0, 0),
			Font = Library.Font,
			TextSize = Library.Size,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = NewUdim2(1, -3, 1, -2),
			Visible = true,
			BorderSizePixel = 0,
		})

		local Option = {
			Button = Button,
			Text = Name,
			Chosen = false,
		}

		Objects[name] = Option
		Count += 1

		Utility:Connect(Button.MouseButton1Down, function()
			DropdownTable:Set(name)
		end)

		return Option
	end

	function DropdownTable:Remove(name)
		Objects[name].Button:Destroy()
		Objects[name] = nil
		Count -= 1

		if DropdownTable.Multi then
			local Index = table.find(DropdownTable.Value, name)

			if Index then
				table.remove(DropdownTable.Value, Index)

				Display()

				Library.Flags[cfg.Flag] = DropdownTable.Value
				cfg.Callback(DropdownTable.Value)
			end
		else
			if DropdownTable.Value == name then
				DropdownTable.Value = nil

				Display()

				Library.Flags[cfg.Flag] = DropdownTable.Value
				cfg.Callback(DropdownTable.Value)
			end
		end
	end

	function DropdownTable:Refresh(tbl)
		if DropdownTable.Multi then
			for _,v in pairs(Objects) do
				if _ ~= "Default" then
					v.Button:Destroy()
					v = nil
				end
			end

			table.clear(DropdownTable.Value)
			Count = 0

			for _,v in pairs(tbl) do
				DropdownTable:Add(v)
			end

			Display()

			Library.Flags[cfg.Flag] = DropdownTable.Value
			cfg.Callback(DropdownTable.Value)
		else
			for _,v in pairs(Objects) do
				if _ ~= "Default" then
					v.Button:Destroy()
					v = nil
				end
			end

			Count = 0

			for _,v in pairs(tbl) do
				DropdownTable:Add(v)
			end

			DropdownTable.Value = nil
			Display()

			Library.Flags[cfg.Flag] = DropdownTable.Value
			cfg.Callback(DropdownTable.Value)
		end
	end

	function DropdownTable:Get()
		return DropdownTable.Value
	end

	local function SetVisible(bool, tween)
		if tween and DropdownTable.IsTweening then
			return
		end

		task.spawn(function()
			if bool then
				Objects.Default.ContentInline.Position = NewUdim2(0, Inline.AbsolutePosition.X, 0, Inline.AbsolutePosition.Y + Inline.AbsoluteSize.Y - 1)
				Objects.Default.ContentInline.Visible = true
				DropdownTable.IsTweening = true
								
				Library:Tween(ArrowIcon, true, {Rotation = 180})
				
				if tween then
					Objects.Default.ContentInline.Size = UDim2.new(0, Inline.AbsoluteSize.X, 0, 0)
					if Count <= MaxVisibleContent then
						Library:Tween(Objects.Default.ContentInline, true, {Size = UDim2.new(0, Inline.AbsoluteSize.X, 0, Count * 18)})
					else
						Library:Tween(Objects.Default.ContentInline, true, {Size = UDim2.new(0, Inline.AbsoluteSize.X, 0, MaxVisibleContent * 18)})
					end

					for __,a in pairs(Objects) do
						for _,v in pairs(a) do
							if _ ~= "Chosen" then
								if v:IsA("TextLabel") then
									Library:Tween(v, true, {TextTransparency = 0})
								elseif v:IsA("ScrollingFrame") then
									Library:Tween(v, true, {ScrollBarImageTransparency = 0})
								elseif v:IsA("Frame") then
									if _:find("Outline") then
										Library:Tween(v, true, {BackgroundTransparency = 0.7})
									else
										Library:Tween(v, true, {BackgroundTransparency = 0})
									end
								end
							end
						end
					end

					wait(Library.TweenSpeed)
				else
					if Count <= MaxVisibleContent then
						Objects.Default.ContentInline.Size = UDim2.new(0, Inline.AbsoluteSize.X, 0, Count * 18)
					else
						Objects.Default.ContentInline.Size = UDim2.new(0, Inline.AbsoluteSize.X, 0, MaxVisibleContent * 18)
					end
				end

				DropdownTable.IsTweening = false
			else
				Objects.Default.ContentInline.Position = NewUdim2(0, Inline.AbsolutePosition.X, 0, Inline.AbsolutePosition.Y + Inline.AbsoluteSize.Y - 1)
				DropdownTable.IsTweening = true
				
				Library:Tween(ArrowIcon, true, {Rotation = 0})
				
				if tween then
					if Count <= MaxVisibleContent then
						Objects.Default.ContentInline.Size = UDim2.new(0, Inline.AbsoluteSize.X, 0, Count * 18)
					else
						Objects.Default.ContentInline.Size = UDim2.new(0, Inline.AbsoluteSize.X, 0, MaxVisibleContent * 18)
					end

					Library:Tween(Objects.Default.ContentInline, true, {Size = UDim2.new(0, Inline.AbsoluteSize.X, 0, 0)})

					for __,a in pairs(Objects) do
						for _,v in pairs(a) do
							if _ ~= "Chosen" then
								if v:IsA("TextLabel") then
									Library:Tween(v, true, {TextTransparency = 1})
								elseif v:IsA("ScrollingFrame") then
									Library:Tween(v, true, {ScrollBarImageTransparency = 1})
								elseif v:IsA("Frame") then
									if _:find("Outline") then
										Library:Tween(v, true, {BackgroundTransparency = 1})
									else
										Library:Tween(v, true, {BackgroundTransparency = 1})
									end
								end
							end
						end
					end

					wait(Library.TweenSpeed)
				else
					Objects.Default.ContentInline.Size = UDim2.new(0, Inline.AbsoluteSize.X, 0, 0)
				end

				DropdownTable.IsTweening = false
				Objects.Default.ContentInline.Visible = false
			end
		end)
	end

	for _,v in pairs(DropdownTable.Values) do
		DropdownTable:Add(v)
	end

	Utility:Connect(BackgroundButton.MouseButton1Down, function()
		SetVisible(not Objects.Default.ContentInline.Visible, true)
	end)

	Utility:Connect(UserInputService.InputBegan, function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and not (Utility:InBounds(Background, input.Position) or Utility:InBounds(Objects.Default.ContentBackground, input.Position)) and Objects.Default.ContentInline.Visible then
			SetVisible(false, true)
		end

		if input.UserInputType == Enum.UserInputType.MouseWheel and not Utility:InBounds(Objects.Default.ContentInline, input.Position) and Objects.Default.ContentInline.Visible then
			SetVisible(false, false)
		end
	end)

	Utility:Connect(UserInputService.InputChanged, function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and not (Utility:InBounds(Background, input.Position) or Utility:InBounds(Objects.Default.ContentBackground, input.Position)) and Objects.Default.ContentInline.Visible then
			SetVisible(false, true)
		end

		if input.UserInputType == Enum.UserInputType.MouseWheel and not Utility:InBounds(Objects.Default.ContentInline, input.Position) and Objects.Default.ContentInline.Visible then
			SetVisible(false, false)
		end
	end)

	Utility:Connect(UserInputService.InputEnded, function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and not (Utility:InBounds(Background, input.Position) or Utility:InBounds(Objects.Default.ContentBackground, input.Position)) and Objects.Default.ContentInline.Visible then
			SetVisible(false, true)
		end

		if input.UserInputType == Enum.UserInputType.MouseWheel and not Utility:InBounds(Objects.Default.ContentInline, input.Position) and Objects.Default.ContentInline.Visible then
			SetVisible(false, false)
		end
	end)

	if not cfg.Ignore then
		Library.ConfigFlags[cfg.Flag] = function(chosen)
			DropdownTable:Set(chosen)
		end
	end

	if cfg.Tooltip then
		Library:Tooltip(cfg.Tooltip, holder)
	end

	if cfg.Default then
		DropdownTable:Set(cfg.Default)
	else
		Library.Flags[cfg.Flag] = DropdownTable.Multi and {} or nil
		cfg.Callback(DropdownTable.Multi and {} or nil)
	end
	
	return DropdownTable
end

function Library:Button(cfg, holder)
	local ButtonTable = {
		Clicked = false,
		Counting = false,
	}

	local Inline = Library:New("Frame", {
		Parent = holder,
		BackgroundTransparency = 0,
		Theme = "Inline 2",
		Position = NewUdim2(0, 0, 0, 0),
		Size = NewUdim2(1, 0, 1, 0),
		Visible = true,
		BorderSizePixel = 0,
	})
	local Background = Library:New("Frame", {
		Parent = Inline,
		BackgroundTransparency = 0,
		Theme = "Dark Background",
		Position = NewUdim2(0, 1, 0, 1),
		Size = NewUdim2(1, -2, 1, -2),
		Visible = true,
		BorderSizePixel = 0,
	})
	local Accent = Library:New("Frame", {
		Parent = Background,
		BackgroundTransparency = 0,
		Theme = "Accent",
		Position = NewUdim2(0, 0, 0, 0),
		Size = NewUdim2(0, 0, 1, 0),
		Visible = true,
		BorderSizePixel = 0,
	})
	local Outline = Library:New("Frame", {
		Position = NewUdim2(0, 0, 0, 0),
		Parent = Background,
		BackgroundTransparency = 0.7,
		Theme = "Outline",
		Size = NewUdim2(0, 2, 1, 0),
		Visible = true,
		BorderSizePixel = 0,
	})
	local Outline2 = Library:New("Frame", {
		Position = NewUdim2(0, 2, 0, 0),
		Parent = Background,
		BackgroundTransparency = 0.7,
		Theme = "Outline",
		Size = NewUdim2(1, -2, 0, 2),
		Visible = true,
		BorderSizePixel = 0,
	})
	local Title = Library:New("TextLabel", {
		Parent = Background,
		Theme = "Text",
		Text = cfg.Name,
		TextXAlignment = cfg.Center and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left,
		BackgroundTransparency = 1,
		Position = NewUdim2(0, cfg.Center and 0 or 4, 0, 0),
		Font = Library.Font,
		TextSize = Library.Size,
		Size = NewUdim2(1, 0, 1, -2),
		Visible = true,
		BorderSizePixel = 0,
	})

	Utility:Connect(holder.MouseEnter, function()
		Library:ChangeObjectTheme(Inline, "Inline", true)
	end)

	Utility:Connect(holder.MouseLeave, function()
		Library:ChangeObjectTheme(Inline, "Inline 2", true)
	end)

	local function Click()
		spawn(function()
			if cfg.Confirm then
				if ButtonTable.Clicked then
					ButtonTable.Clicked = false
					ButtonTable.Counting = false
					Title.Text = cfg.Name
					Library:ChangeObjectTheme(Title, "Text", true)
					cfg.Callback()
				else
					ButtonTable.Clicked = true
					ButtonTable.Counting = true

					for i = 1, 3 do
						if not ButtonTable.Counting then
							return
						end

						Title.Text = "Confirm " .. cfg.Name .. "? " .. 4 - i .. "s"
						Library:ChangeObjectTheme(Title, "Accent", true)
						wait(1)
					end

					ButtonTable.Clicked = false
					ButtonTable.Counting = false
					Title.Text = cfg.Name
					Library:ChangeObjectTheme(Title, "Text", true)
				end
			else
				cfg.Callback()
			end
		end)
	end

	if cfg.Tooltip then
		Library:Tooltip(cfg.Tooltip, holder)
	end

	Utility:Connect(holder.MouseButton1Down, function()
		Library:ChangeObjectTheme(Background, "Background", true)
	end)

	Utility:Connect(holder.MouseButton1Up, function()
		Library:ChangeObjectTheme(Background, "Dark Background", true)

		Click()
	end)

	return ButtonTable
end

function Library:ButtonHolder(cfg, holder)
	local ButtonTable = {}

	for i = 1, #cfg.Buttons do
		local NewCfg = cfg.Buttons[i]
		local NewButtonTable = {
			Clicked = false,
			Counting = false,
		}

		local Holder = Library:New("TextButton", {
			Parent = holder,
			Text = "",
			BackgroundTransparency = 1,
			Size = NewUdim2(1 / #cfg.Buttons, -(#cfg.Buttons / 2), 0, 18),
			Visible = true,
			BorderSizePixel = 0,
		})
		local Inline = Library:New("Frame", {
			Parent = Holder,
			BackgroundTransparency = 0,
			Theme = "Inline 2",
			Position = NewUdim2(0, 0, 0, 0),
			Size = NewUdim2(1, 0, 1, 0),
			Visible = true,
			BorderSizePixel = 0,
		})
		local Background = Library:New("Frame", {
			Parent = Inline,
			BackgroundTransparency = 0,
			Theme = "Dark Background",
			Position = NewUdim2(0, 1, 0, 1),
			Size = NewUdim2(1, -2, 1, -2),
			Visible = true,
			BorderSizePixel = 0,
		})
		local Accent = Library:New("Frame", {
			Parent = Background,
			BackgroundTransparency = 0,
			Theme = "Accent",
			Position = NewUdim2(0, 0, 0, 0),
			Size = NewUdim2(0, 0, 1, 0),
			Visible = true,
			BorderSizePixel = 0,
		})
		local Outline = Library:New("Frame", {
			Position = NewUdim2(0, 0, 0, 0),
			Parent = Background,
			BackgroundTransparency = 0.7,
			Theme = "Outline",
			Size = NewUdim2(0, 2, 1, 0),
			Visible = true,
			BorderSizePixel = 0,
		})
		local Outline2 = Library:New("Frame", {
			Position = NewUdim2(0, 2, 0, 0),
			Parent = Background,
			BackgroundTransparency = 0.7,
			Theme = "Outline",
			Size = NewUdim2(1, -2, 0, 2),
			Visible = true,
			BorderSizePixel = 0,
		})
		local Title = Library:New("TextLabel", {
			Parent = Background,
			Theme = "Text",
			Text = NewCfg.Name,
			BackgroundTransparency = 1,
			TextXAlignment = NewCfg.Center and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left,
			Position = NewUdim2(0, NewCfg.Center and 0 or 4, 0, 0),
			Font = Library.Font,
			TextSize = Library.Size,
			Size = NewUdim2(1, 0, 1, -2),
			Visible = true,
			BorderSizePixel = 0,
		})

		Utility:Connect(Holder.MouseEnter, function()
			Library:ChangeObjectTheme(Inline, "Inline", true)
		end)

		Utility:Connect(Holder.MouseLeave, function()
			Library:ChangeObjectTheme(Inline, "Inline 2", true)
		end)

		local function Click()
			spawn(function()
				if NewCfg.Confirm then
					if NewButtonTable.Clicked then
						NewButtonTable.Clicked = false
						NewButtonTable.Counting = false
						Title.Text = cfg.Name
						Library:ChangeObjectTheme(Title, "Text", true)
						cfg.Callback()
					else
						NewButtonTable.Clicked = true
						NewButtonTable.Counting = true

						for i = 1, 3 do
							if not NewButtonTable.Counting then
								return
							end

							Title.Text = "Confirm " .. cfg.Name .. "? " .. 4 - i .. "s"
							Library:ChangeObjectTheme(Title, "Accent", true)
							wait(1)
						end

						ButtonTable.Clicked = false
						ButtonTable.Counting = false
						Title.Text = cfg.Name
						Library:ChangeObjectTheme(Title, "Text", true)
					end
				else
					NewCfg.Callback()
				end
			end)
		end

		if NewCfg.Tooltip then
			Library:Tooltip(NewCfg.Tooltip, Holder)
		end

		Utility:Connect(Holder.MouseButton1Down, function()
			Library:ChangeObjectTheme(Background, "Background", true)
		end)

		Utility:Connect(Holder.MouseButton1Up, function()
			Library:ChangeObjectTheme(Background, "Dark Background", true)

			Click()
		end)
	end

	return ButtonTable
end

function Library:TextBox(cfg, holder)
	local TextBoxTable = {}

	local Inline = Library:New("Frame", {
		Parent = holder,
		BackgroundTransparency = 0,
		Theme = "Inline 2",
		Position = NewUdim2(0, 0, 0, 0),
		Size = NewUdim2(1, 0, 1, 0),
		Visible = true,
		BorderSizePixel = 0,
	})
	local Background = Library:New("Frame", {
		Parent = Inline,
		BackgroundTransparency = 0,
		Theme = "Dark Background",
		Position = NewUdim2(0, 1, 0, 1),
		Size = NewUdim2(1, -2, 1, -2),
		Visible = true,
		BorderSizePixel = 0,
	})
	local Outline = Library:New("Frame", {
		Position = NewUdim2(0, 0, 0, 0),
		Parent = Background,
		BackgroundTransparency = 0.7,
		Theme = "Outline",
		Size = NewUdim2(0, 2, 1, 0),
		Visible = true,
		BorderSizePixel = 0,
	})
	local Outline2 = Library:New("Frame", {
		Position = NewUdim2(0, 2, 0, 0),
		Parent = Background,
		BackgroundTransparency = 0.7,
		Theme = "Outline",
		Size = NewUdim2(1, -2, 0, 2),
		Visible = true,
		BorderSizePixel = 0,
	})
	local TextBox = Library:New("TextBox", {
		Parent = Background,
		Position = NewUdim2(0, not cfg.Center and 2 or 0, 0, 0),
		Size = NewUdim2(1, 0, 1, -2),
		BackgroundTransparency = 1,
		Theme = "Text",
		ClearTextOnFocus = cfg.ClearOnFocus,
		Font = Library.Font,
		TextSize = Library.Size,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		TextXAlignment = cfg.Center and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left,
	})
	local PlaceHolder = Library:New("TextLabel", {
		Parent = Background,
		Theme = "Dark Text",
		Text = cfg.Name,
		BackgroundTransparency = 1,
		Position = NewUdim2(0, 0, 0, 0),
		Font = Library.Font,
		TextSize = Library.Size,
		Size = NewUdim2(1, 0, 1, -2),
		Visible = false,
		BorderSizePixel = 0,
	})

	TextBoxTable.TextBox = TextBox

	function TextBoxTable:Set(text)
		text = text or ""

		if text == "" then
			PlaceHolder.Visible = true
		else
			PlaceHolder.Visible = false
		end

		TextBox.Text = text

		Library.Flags[cfg.Flag] = text
		cfg.Callback(text)
	end

	Utility:Connect(TextBox.Focused, function()
		PlaceHolder.Visible = false
	end)

	Utility:Connect(TextBox.FocusLost, function()
		TextBoxTable:Set(TextBox.Text)
	end)

	TextBoxTable:Set(cfg.Default)

	Library.ConfigFlags[cfg.Flag] = function(text)
		TextBoxTable:Set(text)
	end

	return TextBoxTable
end

function Library:Window(position, size, name, holder)	
	position = typeof(position) == "Vector2" and Utility:ConvertVector2(position) or position
	size = typeof(size) == "Vector2" and Utility:ConvertVector2(size) or size
	local Objects = {}

	do
		Objects.Outline = Library:New("Frame", {
			Parent = holder,
			BackgroundTransparency = 0.5,
			Theme = "Outline",
			Position = position,
			Size = size,
			Visible = true,
			BorderSizePixel = 0,
		})
		Objects.Background = Library:New("Frame", {
			Parent = Objects.Outline,
			Theme = "Background",
			Position = NewUdim2(0, 1, 0, 1),
			Size = NewUdim2(1, -2, 1, -2),
			Visible = true,
			BorderSizePixel = 0,
		})
		Objects.ResizeObj = Library:New("Frame", {
			Parent = Objects.Background,
			BackgroundTransparency = 0.5,
			Position = NewUdim2(1, -5, 1, -5),
			Size = NewUdim2(0, 5, 0, 5),
			Visible = true,
			BorderSizePixel = 0,
		})
		Objects.BackgroundGradientPart = Library:New("Frame", {
			Parent = Objects.Background,
			BackgroundColor3 = NewRGB(255, 255, 255),
			Position = NewUdim2(0, 60, 0, 25),
			Size = NewUdim2(1, -60, 0, 20),
			Visible = true,
			BorderSizePixel = 0,
		})
		Objects.BackgroundGradient = Library:New("UIGradient", {
			Theme = "Dark Gradient",
			Rotation = -90,
			Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 1), NumberSequenceKeypoint.new(0.4, 1), NumberSequenceKeypoint.new(1.00, 0.9)},
			Parent = Objects.BackgroundGradientPart,
		})
		Objects.Header = Library:New("Frame", {
			Parent = Objects.Background,
			Theme = "Background",
			Position = NewUdim2(0, 0, 0, 0),
			Size = NewUdim2(1, 0, 0, 25),
			Visible = true,
			BorderSizePixel = 0,
		})
		Objects.HeaderGradientPart = Library:New("Frame", {
			Parent = Objects.Header,
			BackgroundColor3 = NewRGB(255, 255, 255),
			Position = NewUdim2(0, 0, 0, 0),
			Size = NewUdim2(1, 0, 1, 0),
			Visible = true,
			BorderSizePixel = 0,
		})
		Objects.HeaderGradient = Library:New("UIGradient", {
			Theme = "Dark Gradient",
			Rotation = 90,
			Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 1), NumberSequenceKeypoint.new(0.60, 1), NumberSequenceKeypoint.new(1.00, 0.9)},
			Parent = Objects.HeaderGradientPart,
		})
		Objects.Title = Library:New("TextLabel", {
			Parent = Objects.Header,
			Theme = "Text",
			Text = name,
			BackgroundTransparency = 1,
			Position = NewUdim2(0, 5, 0, 0),
			Font = Library.Font,
			TextSize = Library.Size,
			Size = NewUdim2(0, Utility:GetTextBounds(name, Library.Font, Library.Size).X, 1, 0),
			Visible = true,
			BorderSizePixel = 0,
		})
		Objects.AccentOutline = Library:New("Frame", {
			Parent = Objects.Background,
			Theme = "Outline",
			Position = NewUdim2(0, 0, 0, 25),
			Size = NewUdim2(1, 0, 0, 1),
			Visible = true,
			BorderSizePixel = 0,
		})
		Objects.Accent = Library:New("Frame", {
			Parent = Objects.Background,
			Theme = "Accent",
			Position = NewUdim2(0, 0, 0, 25),
			Size = NewUdim2(1, 0, 0, 1),
			Visible = true,
			BorderSizePixel = 0,
		})
		Objects.TabHolder = Library:New("Frame", {
			Parent = Objects.Background,
			Theme = "Side",
			Position = NewUdim2(0, 0, 0, 26),
			Size = NewUdim2(0, 60, 1, -26),
			Visible = true,
			BorderSizePixel = 0,
		})
		Objects.TabGradientPart = Library:New("Frame", {
			Parent = Objects.Background,
			BackgroundColor3 = NewRGB(255, 255, 255),
			Position = NewUdim2(0, 0, 0, 26),
			Size = NewUdim2(0, 60, 0, 12),
			Visible = true,
			BorderSizePixel = 0,
		})
		Objects.TabGradient = Library:New("UIGradient", {
			Theme = "Light Gradient",
			Rotation = 90,
			Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.90), NumberSequenceKeypoint.new(1.00, 1.00)},
			Parent = Objects.TabGradientPart,
		})
		Objects.TabHolderOutline = Library:New("Frame", {
			Parent = Objects.Background,
			Theme = "Outline",
			Position = NewUdim2(0, 60, 0, 26),
			Size = NewUdim2(0, 1, 1, -26),
			Visible = true,
			BorderSizePixel = 0,
		})
		Objects.ListLayout = Library:New("UIListLayout", {
			Parent = Objects.TabHolder,
			Padding = NewUdim(0, 5),
			SortOrder = Enum.SortOrder.LayoutOrder,
			FillDirection = Enum.FillDirection.Vertical,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
		})
	end

	return Objects
end

function Library:Menu(cfg)
	cfg = cfg or {}
	local WindowTable = {
		TabButtons = {},
		TabPages = {},
		TabHolders = {},
	}

	Library:Default(cfg, {
		Size = NewVector(483, 340),
		Position = NewUdim2(0, 0, 0, 0),
		Name = "roblox cheat",
	})

	cfg.Position = Library:GetCenter(cfg.Size)

	local Window = Library:Window(cfg.Position, cfg.Size, cfg.Name, Library.ScreenGui)

	Library.MainWindow = Window

	local TabHolder = Window.TabHolder
	Library:Drag(Window.Outline, Window.Header)
	Library:Resize(Window.Outline, Window.ResizeObj, cfg.Size)

	local NotifyHolder = Library:New("Frame", {
		Parent = Library.ScreenGui,
		BackgroundTransparency = 1,
		Position = NewUdim2(0, 20, 0, 50),
		Size = NewUdim2(1, 0, 1, 0),
		Visible = true,
		BorderSizePixel = 0,
	})

	Library:New("UIListLayout", {
		Parent = NotifyHolder,
		Padding = NewUdim(0, 5),
		FillDirection = Enum.FillDirection.Vertical,
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	function WindowTable:Tab(image)
		image = image or Library.Images["Cog"]
		local TabTable = {}

		local Holder = Library:New("Frame", {
			Parent = TabHolder,
			Theme = "Side",
			BackgroundTransparency = 0,
			Size = NewUdim2(0, 40, 0, 40),
			Visible = true,
			BorderSizePixel = 0,
		})

		table.insert(WindowTable.TabHolders, Holder)

		Library:New("UICorner", {
			Parent = Holder,
			CornerRadius = NewUdim(0, 8),
		})

		local Button = Library:New("ImageButton", {
			BackgroundTransparency = 1,
			Parent = Holder,
			Theme = "Tab Disabled",
			Position = NewUdim2(0, 5, 0, 5),
			Size = NewUdim2(0, 30, 0, 30),
			Visible = true,
			BorderSizePixel = 0,
			Image = image,
		})

		table.insert(WindowTable.TabButtons, Button)

		local Page = Library:New("Frame", {
			Parent = Window.Background,
			BackgroundTransparency = 1,
			Position = NewUdim2(0, 61, 0, 26),
			Size = NewUdim2(1, -61, 1, -26),
			Visible = true,
			BorderSizePixel = 0,
		})

		table.insert(WindowTable.TabPages, Page)

		local Left = Library:New("Frame", {
			Parent = Page,
			BackgroundTransparency = 1,
			Position = NewUdim2(0, 8, 0, 8),
			Size = NewUdim2(0.5, -8, 1, -16),
			Visible = true,
			BorderSizePixel = 0,
		})

		Library:New("UIListLayout", {
			Padding = UDim.new(0, 7),
			Parent = Left,
			FillDirection = Enum.FillDirection.Vertical,
			SortOrder = Enum.SortOrder.LayoutOrder,
		})

		local Right = Library:New("Frame", {
			Parent = Page,
			BackgroundTransparency = 1,
			Position = NewUdim2(0.5, 4, 0, 8),
			Size = NewUdim2(0.5, -8, 1, -16),
			Visible = true,
			BorderSizePixel = 0,
		})

		Library:New("UIListLayout", {
			Padding = UDim.new(0, 7),
			Parent = Right,
			FillDirection = Enum.FillDirection.Vertical,
			SortOrder = Enum.SortOrder.LayoutOrder,
		})

		function TabTable:Show()
			for _,v in pairs(WindowTable.TabButtons) do
				if v ~= Button then
					Library:ChangeObjectTheme(v, "Tab Disabled", true)
				end
			end

			for _,v in pairs(WindowTable.TabHolders) do
				if v ~= Holder then
					Library:ChangeObjectTheme(v, "Side", true)
				end
			end

			for _,v in pairs(WindowTable.TabPages) do
				if v ~= Page then
					v.Visible = false
				end
			end

			Library:ChangeObjectTheme(Button, "Tab Enabled", true)
			Library:ChangeObjectTheme(Holder, "Tab Background", true)
			Page.Visible = true
		end

		Utility:Connect(Button.MouseButton1Down, TabTable.Show)

		function TabTable:Section(cfg)
			cfg = cfg or {}
			local SectionTable = {}

			Library:Default(cfg, {
				Name = "New Section",
				Side = "Left",
				ScaleSize = 1,
				Size = 0,
			})

			local Side = cfg.Side

			cfg.Side = cfg.Side == "Left" and Left or Right

			local TextSize = Utility:GetTextBounds(cfg.Name, Library.Font, Library.Size)

			local Holder = Library:New("Frame", {
				Parent = cfg.Side,
				BackgroundTransparency = 1,
				Size = NewUdim2(1, -4, cfg.ScaleSize, (cfg.Size) - 4),
				Visible = true,
				BorderSizePixel = 0,
			})
			local Inline = Library:New("Frame", {
				Parent = Holder,
				BackgroundTransparency = 0,
				Theme = "Inline",
				Position = NewUdim2(0, 0, 0, 4),
				Size = NewUdim2(1, 0, 1, 0),
				Visible = true,
				BorderSizePixel = 0,
			})
			local Background = Library:New("Frame", {
				Parent = Inline,
				Theme = "Background",
				Position = NewUdim2(0, 1, 0, 1),
				Size = NewUdim2(1, -2, 1, -2),
				Visible = true,
				BorderSizePixel = 0,
			})
			local Outline = Library:New("Frame", {
				Position = NewUdim2(0, 0, 0, 0),
				Parent = Background,
				BackgroundTransparency = 0,
				Theme = "Outline",
				Size = NewUdim2(0, 2, 1, 0),
				Visible = true,
				BorderSizePixel = 0,
			})
			local Outline2 = Library:New("Frame", {
				Position = NewUdim2(0, 0, 0, 0),
				Parent = Background,
				BackgroundTransparency = 0,
				Theme = "Outline",
				Size = NewUdim2(1, 0, 0, 2),
				Visible = true,
				BorderSizePixel = 0,
			})
			local Outline3 = Library:New("Frame", {
				Position = NewUdim2(1, -4, 0, 0),
				Parent = Background,
				BackgroundTransparency = 0,
				Theme = "Outline",
				Size = NewUdim2(0, 4, 1, 0),
				Visible = true,
				BorderSizePixel = 0,
			})
			local BackgroundOverlay = Library:New("Frame", {
				Parent = Holder,
				Theme = "Background",
				Position = NewUdim2(0, 5, 0, -3),
				Size = NewUdim2(0, TextSize.X + 2, 0, TextSize.Y + 1),
				Visible = true,
				BorderSizePixel = 0,
			})
			local Title = Library:New("TextLabel", {
				Parent = BackgroundOverlay,
				Theme = "Text",
				Text = cfg.Name,
				BackgroundTransparency = 1,
				Position = NewUdim2(0, 0, 0, 0),
				Font = Library.Font,
				TextSize = Library.Size,
				Size = NewUdim2(1, 0, 1, 0),
				Visible = true,
				BorderSizePixel = 0,
			})
			local ScrollSection = Library:New("ScrollingFrame", {
				Theme = "Accent",
				Parent = Background,
				BackgroundTransparency = 1,
				Position = NewUdim2(0, 0, 0, 2),
				Size = NewUdim2(1, -1, 1, -4),
				CanvasSize = NewUdim2(0, 0, 0, 0),
				Visible = true,
				BorderSizePixel = 0,
				MidImage = "rbxassetid://12776289446",
				BottomImage = "rbxassetid://12776289446",
				TopImage = "rbxassetid://12776289446",
				ScrollBarThickness = 2,
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
			})
			local Content = Library:New("Frame", {
				Parent = ScrollSection,
				BackgroundTransparency = 1,
				Position = NewUdim2(0, 9, 0, 10),
				Size = NewUdim2(1, -22, 0, 0),
				Visible = true,
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.Y,
			})

			Library:New("UIListLayout", {
				Padding = UDim.new(0, 4),
				Parent = Content,
				FillDirection = Enum.FillDirection.Vertical,
				SortOrder = Enum.SortOrder.LayoutOrder,
			})

			function SectionTable:Toggle(cfg)
				cfg = cfg or {}

				Library:Default(cfg, {
					Name = "New Toggle",
					State = false,
					Flag = "toggle",
					Tooltip = nil,
					Callback = function() end,
				})

				local Holder = Library:New("TextButton", {
					Parent = Content,
					Text = "",
					BackgroundTransparency = 1,
					Position = NewUdim2(0, 0, 0, 0),
					Size = NewUdim2(1, 0, 0, 10),
					Visible = true,
					BorderSizePixel = 0,
				})

				local ToggleTable = Library:Toggle(cfg, Holder)

				return ToggleTable
			end

			function SectionTable:Slider(cfg)
				cfg = cfg or {}
			
				Library:Default(cfg, {
					Name = "New Slider",
					Min = 0,
					Max = 100,
					Float = 1,
					Ignore = false,
					Default = 50,
					Flag = "slider",
					Tooltip = nil,
					Callback = function() end,
				})

				local Holder = Library:New("TextButton", {
					Parent = Content,
					Text = "",
					BackgroundTransparency = 1,
					Position = NewUdim2(0, 0, 0, 0),
					Size = NewUdim2(1, 0, 0, 23),
					Visible = true,
					BorderSizePixel = 0,
				})

				local SliderTable = Library:Slider(cfg, Holder)

				return SliderTable
			end

			function SectionTable:Button(cfg)
				cfg = cfg or {}

				Library:Default(cfg, {
					Name = "New Button",
					Callback = function() end,
					Center = true,
					Tooltip = nil,
					Confirm = false,
				})

				local Holder = Library:New("TextButton", {
					Parent = Content,
					Text = "",
					BackgroundTransparency = 1,
					Position = NewUdim2(0, 0, 0, 0),
					Size = NewUdim2(1, 0, 0, 18),
					Visible = true,
					BorderSizePixel = 0,
				})

				local ButtonTable = Library:Button(cfg, Holder)

				return ButtonTable
			end

			function SectionTable:ButtonHolder(cfg)
				cfg = cfg or {}

				Library:Default(cfg, {
					Buttons = {
						[1] = {
							Name = "New Button",
							Callback = function() end,
							Tooltip = nil,
							Center = true,
						},
						[2] = {
							Name = "New Button",
							Callback = function() end,
							Tooltip = nil,
							Center = true,
						},
					},
				})

				local ButtonHolder = Library:New("TextButton", {
					Parent = Content,
					Text = "",
					BackgroundTransparency = 1,
					Position = NewUdim2(0, 0, 0, 0),
					Size = NewUdim2(1, 0, 0, 18),
					Visible = true,
					BorderSizePixel = 0,
				})

				Library:New("UIListLayout", {
					Parent = ButtonHolder,
					Padding = NewUdim(0, 2),
					FillDirection = Enum.FillDirection.Horizontal,
					SortOrder = Enum.SortOrder.LayoutOrder,
				})

				local ButtonTable = Library:ButtonHolder(cfg, ButtonHolder)

				return ButtonTable
			end

			function SectionTable:ColorPicker(cfg)
				cfg = cfg or {}
				local ColorTable = {}

				Library:Default(cfg, {
					Name = "New Colorpicker",
					Tooltip = nil,
					Default = NewRGB(0, 0, 0),
					Transparency = nil,
					Ignore = false,
					Flag = "colorpicker",
					Callback = function() end,
				})

				local Holder = Library:New("TextButton", {
					Parent = Content,
					Text = "",
					BackgroundTransparency = 1,
					Position = NewUdim2(0, 0, 0, 0),
					Size = NewUdim2(1, 0, 0, 10),
					Visible = true,
					BorderSizePixel = 0,
				})

				local ColorPickerTable = Library:ColorPicker(cfg, Holder, 1, true)

				return ColorPickerTable
			end

			function SectionTable:Keybind(cfg)
				cfg = cfg or {}

				Library:Default(cfg, {
					Name = "New Keybind",
					Mode = "Toggle",
					Key = "",
					Callback = function() end,
					Tooltip = nil,
					Flag = "keybind",
				})

				local Holder = Library:New("TextButton", {
					Parent = Content,
					Text = "",
					BackgroundTransparency = 1,
					Position = NewUdim2(0, 0, 0, 0),
					Size = NewUdim2(1, 0, 0, 10),
					Visible = true,
					BorderSizePixel = 0,
				})

				local KeybindTable = Library:Keybind(cfg, Holder, 1)

				return KeybindTable
			end

			function SectionTable:Dropdown(cfg)
				cfg = cfg or {}

				Library:Default(cfg, {
					Name = "New Dropdown",
					Content = {"Var1", "Var2", "Var3", "Var4", "Var5", "Var6"},
					Default = "Var1", -- will be a table if it's multi. fyi
					Multi = false,
					Ignore = false,
					Callback = function() end,
					Tooltip = nil,
					Flag = "dropdown",
				})

				local Holder = Library:New("TextButton", {
					Parent = Content,
					Text = "",
					BackgroundTransparency = 1,
					Position = NewUdim2(0, 0, 0, 0),
					Size = NewUdim2(1, 0, 0, 33),
					Visible = true,
					BorderSizePixel = 0,
				})

				local DropdownTable = Library:Dropdown(cfg, Holder, Side)

				return DropdownTable
			end

			function SectionTable:TextBox(cfg)
				cfg = cfg or {}

				Library:Default(cfg, {
					Name = "New Textbox",
					Default = "",
					Center = true,
					ClearOnFocus = false,
					Callback = function() end,
					Tooltip = nil,
					Flag = "dropdown",
				})

				local Holder = Library:New("TextButton", {
					Parent = Content,
					Text = "",
					BackgroundTransparency = 1,
					Position = NewUdim2(0, 0, 0, 0),
					Size = NewUdim2(1, 0, 0, 18),
					Visible = true,
					BorderSizePixel = 0,
				})

				local TextBoxTable = Library:TextBox(cfg, Holder)

				return TextBoxTable
			end

			return SectionTable
		end

		function TabTable:MultiSection(cfg)
			cfg = cfg or {}

			local MultiSectionTable = {
				TabSections = {},
				TabButtons = {},
				TabOutlines = {},
				TabText = {},
			}

			Library:Default(cfg, {
				Side = "Left",
				ScaleSize = 1,
				Size = 0,
			})

			local Side = cfg.Side

			cfg.Side = cfg.Side == "Left" and Left or Right

			local Holder = Library:New("Frame", {
				Parent = cfg.Side,
				BackgroundTransparency = 1,
				Size = NewUdim2(1, -4, cfg.ScaleSize, (cfg.Size) - 4),
				Visible = true,
				BorderSizePixel = 0,
			})
			local Inline = Library:New("Frame", {
				Parent = Holder,
				BackgroundTransparency = 0,
				Theme = "Inline",
				Position = NewUdim2(0, 0, 0, 4),
				Size = NewUdim2(1, 0, 1, 0),
				Visible = true,
				BorderSizePixel = 0,
			})
			local Background = Library:New("Frame", {
				Parent = Inline,
				Theme = "Background",
				Position = NewUdim2(0, 1, 0, 1),
				Size = NewUdim2(1, -2, 1, -2),
				Visible = true,
				BorderSizePixel = 0,
			})
			local TabHolder = Library:New("Frame", {
				Parent = Background,
				Theme = "Dark Background",
				Position = NewUdim2(0, 0, 0, 0),
				Size = NewUdim2(1, 0, 0, 22),
				Visible = true,
				BorderSizePixel = 0,
			})

			Library:New("UIListLayout", {
				Padding = UDim.new(0, -2),
				Parent = TabHolder,
				FillDirection = Enum.FillDirection.Horizontal,
				SortOrder = Enum.SortOrder.LayoutOrder,
			})

			function MultiSectionTable:Tab(name)
				local SectionTable = {}

				local TextBounds = Utility:GetTextBounds(name, Library.Font, Library.Size)

				local ButtonOutline = Library:New("Frame", {
					BackgroundTransparency = 0,
					Parent = TabHolder,
					Theme = "Outline",
					Size = NewUdim2(0, TextBounds.X + 10, 1, 0),
					Visible = true,
					BorderSizePixel = 0,
				})
				local Holder = Library:New("Frame", {
					BackgroundTransparency = 0,
					Parent = ButtonOutline,
					Theme = "Dark Background",
					Position = NewUdim2(0, 2, 0, 2),
					Size = NewUdim2(1, -4, 1, -4),
					Visible = true,
					BorderSizePixel = 0,
				})
				local Button = Library:New("TextButton", {
					BackgroundTransparency = 1,
					Parent = Holder,
					Theme = "Tab Disabled",
					Size = NewUdim2(1, 0, 1, 0),
					Visible = true,
					BorderSizePixel = 0,
					TextXAlignment = Enum.TextXAlignment.Center,
					Font = Library.Font,
					TextSize = Library.Size,
					Text = name,
				})
				local HideOutline = Library:New("Frame", {
					BackgroundTransparency = 0,
					Parent = Holder,
					Theme = "Outline",
					Position = NewUdim2(0, 0, 1, 0),
					Size = NewUdim2(1, 0, 0, 2),
					Visible = true,
					BorderSizePixel = 0,
					ZIndex = 50,
				})
				local ScrollSection = Library:New("ScrollingFrame", {
					Theme = "Accent",
					Parent = Background,
					BackgroundTransparency = 1,
					Position = NewUdim2(0, 0, 0, 22),
					Size = NewUdim2(1, -1, 1, -24),
					CanvasSize = NewUdim2(0, 0, 0, 0),
					Visible = true,
					BorderSizePixel = 0,
					MidImage = "rbxassetid://12776289446",
					BottomImage = "rbxassetid://12776289446",
					TopImage = "rbxassetid://12776289446",
					ScrollBarThickness = 2,
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
				})
				local Content = Library:New("Frame", {
					Parent = ScrollSection,
					BackgroundTransparency = 1,
					Position = NewUdim2(0, 9, 0, 10),
					Size = NewUdim2(1, -22, 0, 0),
					Visible = true,
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
				})
				Library:New("UIListLayout", {
					Padding = UDim.new(0, 4),
					Parent = Content,
					FillDirection = Enum.FillDirection.Vertical,
					SortOrder = Enum.SortOrder.LayoutOrder,
				})

				table.insert(MultiSectionTable.TabButtons, Holder)
				table.insert(MultiSectionTable.TabText, Button)
				table.insert(MultiSectionTable.TabSections, ScrollSection)
				table.insert(MultiSectionTable.TabOutlines, HideOutline)

				function SectionTable:Show()
					for _,v in pairs(MultiSectionTable.TabSections) do
						if v ~= ScrollSection then
							v.Visible = false
						end
					end

					for _,v in pairs(MultiSectionTable.TabButtons) do
						if v ~= Holder then
							Library:ChangeObjectTheme(v, "Dark Background", true)
						end
					end

					for _,v in pairs(MultiSectionTable.TabText) do
						if v ~= Button then
							Library:ChangeObjectTheme(v, "Tab Disabled", true)
						end
					end

					for _,v in pairs(MultiSectionTable.TabOutlines) do
						if v ~= HideOutline then
							Library:ChangeObjectTheme(v, "Outline", true)
						end
					end

					Library:ChangeObjectTheme(Button, "Text", true)
					Library:ChangeObjectTheme(Holder, "Background", true)
					Library:ChangeObjectTheme(HideOutline, "Background", true)
					ScrollSection.Visible = true
				end

				Utility:Connect(Button.MouseButton1Down, SectionTable.Show)

				function SectionTable:Toggle(cfg)
					cfg = cfg or {}
	
					Library:Default(cfg, {
						Name = "New Toggle",
						State = false,
						Flag = "toggle",
						Tooltip = nil,
						Callback = function() end,
					})
	
					local Holder = Library:New("TextButton", {
						Parent = Content,
						Text = "",
						BackgroundTransparency = 1,
						Position = NewUdim2(0, 0, 0, 0),
						Size = NewUdim2(1, 0, 0, 10),
						Visible = true,
						BorderSizePixel = 0,
					})
	
					local ToggleTable = Library:Toggle(cfg, Holder)
	
					return ToggleTable
				end
	
				function SectionTable:Slider(cfg)
					cfg = cfg or {}
				
					Library:Default(cfg, {
						Name = "New Slider",
						Min = 0,
						Max = 100,
						Float = 1,
						Ignore = false,
						Default = 50,
						Flag = "slider",
						Tooltip = nil,
						Callback = function() end,
					})
	
					local Holder = Library:New("TextButton", {
						Parent = Content,
						Text = "",
						BackgroundTransparency = 1,
						Position = NewUdim2(0, 0, 0, 0),
						Size = NewUdim2(1, 0, 0, 23),
						Visible = true,
						BorderSizePixel = 0,
					})
	
					local SliderTable = Library:Slider(cfg, Holder)
	
					return SliderTable
				end
	
				function SectionTable:Button(cfg)
					cfg = cfg or {}
	
					Library:Default(cfg, {
						Name = "New Button",
						Callback = function() end,
						Center = true,
						Tooltip = nil,
						Confirm = false,
					})
	
					local Holder = Library:New("TextButton", {
						Parent = Content,
						Text = "",
						BackgroundTransparency = 1,
						Position = NewUdim2(0, 0, 0, 0),
						Size = NewUdim2(1, 0, 0, 18),
						Visible = true,
						BorderSizePixel = 0,
					})
	
					local ButtonTable = Library:Button(cfg, Holder)
	
					return ButtonTable
				end
	
				function SectionTable:ButtonHolder(cfg)
					cfg = cfg or {}
	
					Library:Default(cfg, {
						Buttons = {
							[1] = {
								Name = "New Button",
								Callback = function() end,
								Tooltip = nil,
								Center = true,
							},
							[2] = {
								Name = "New Button",
								Callback = function() end,
								Tooltip = nil,
								Center = true,
							},
						},
					})
	
					local ButtonHolder = Library:New("TextButton", {
						Parent = Content,
						Text = "",
						BackgroundTransparency = 1,
						Position = NewUdim2(0, 0, 0, 0),
						Size = NewUdim2(1, 0, 0, 18),
						Visible = true,
						BorderSizePixel = 0,
					})
	
					Library:New("UIListLayout", {
						Parent = ButtonHolder,
						Padding = NewUdim(0, 2),
						FillDirection = Enum.FillDirection.Horizontal,
						SortOrder = Enum.SortOrder.LayoutOrder,
					})
	
					local ButtonTable = Library:ButtonHolder(cfg, ButtonHolder)
	
					return ButtonTable
				end
	
				function SectionTable:ColorPicker(cfg)
					cfg = cfg or {}
					local ColorTable = {}
	
					Library:Default(cfg, {
						Name = "New Colorpicker",
						Tooltip = nil,
						Default = NewRGB(0, 0, 0),
						Transparency = nil,
						Ignore = false,
						Flag = "colorpicker",
						Callback = function() end,
					})
	
					local Holder = Library:New("TextButton", {
						Parent = Content,
						Text = "",
						BackgroundTransparency = 1,
						Position = NewUdim2(0, 0, 0, 0),
						Size = NewUdim2(1, 0, 0, 10),
						Visible = true,
						BorderSizePixel = 0,
					})
	
					local ColorPickerTable = Library:ColorPicker(cfg, Holder, 1, true)
	
					return ColorPickerTable
				end
	
				function SectionTable:Keybind(cfg)
					cfg = cfg or {}
	
					Library:Default(cfg, {
						Name = "New Keybind",
						Mode = "Toggle",
						Key = "",
						Callback = function() end,
						Tooltip = nil,
						Flag = "keybind",
					})
	
					local Holder = Library:New("TextButton", {
						Parent = Content,
						Text = "",
						BackgroundTransparency = 1,
						Position = NewUdim2(0, 0, 0, 0),
						Size = NewUdim2(1, 0, 0, 10),
						Visible = true,
						BorderSizePixel = 0,
					})
	
					local KeybindTable = Library:Keybind(cfg, Holder, 1)
	
					return KeybindTable
				end
	
				function SectionTable:Dropdown(cfg)
					cfg = cfg or {}
	
					Library:Default(cfg, {
						Name = "New Dropdown",
						Content = {"Var1", "Var2", "Var3", "Var4", "Var5", "Var6"},
						Default = "Var1", -- will be a table if it's multi. fyi
						Multi = false,
						Ignore = false,
						Callback = function() end,
						Tooltip = nil,
						Flag = "dropdown",
					})
	
					local Holder = Library:New("TextButton", {
						Parent = Content,
						Text = "",
						BackgroundTransparency = 1,
						Position = NewUdim2(0, 0, 0, 0),
						Size = NewUdim2(1, 0, 0, 33),
						Visible = true,
						BorderSizePixel = 0,
					})
	
					local DropdownTable = Library:Dropdown(cfg, Holder, Side)
	
					return DropdownTable
				end
	
				function SectionTable:TextBox(cfg)
					cfg = cfg or {}
	
					Library:Default(cfg, {
						Name = "New Textbox",
						Default = "",
						Center = true,
						ClearOnFocus = false,
						Callback = function() end,
						Tooltip = nil,
						Flag = "dropdown",
					})
	
					local Holder = Library:New("TextButton", {
						Parent = Content,
						Text = "",
						BackgroundTransparency = 1,
						Position = NewUdim2(0, 0, 0, 0),
						Size = NewUdim2(1, 0, 0, 18),
						Visible = true,
						BorderSizePixel = 0,
					})
	
					local TextBoxTable = Library:TextBox(cfg, Holder)
	
					return TextBoxTable
				end

				return SectionTable
			end

			local Outline = Library:New("Frame", {
				Position = NewUdim2(0, 0, 0, 0),
				Parent = Background,
				BackgroundTransparency = 0,
				Theme = "Outline",
				Size = NewUdim2(0, 2, 1, 0),
				Visible = true,
				BorderSizePixel = 0,
			})
			local Outline2 = Library:New("Frame", {
				Position = NewUdim2(0, 2, 0, 0),
				Parent = Background,
				BackgroundTransparency = 0,
				Theme = "Outline",
				Size = NewUdim2(1, -2, 0, 2),
				Visible = true,
				BorderSizePixel = 0,
			})
			local Outline3 = Library:New("Frame", {
				Position = NewUdim2(1, -4, 0, 20),
				Parent = Background,
				BackgroundTransparency = 0,
				Theme = "Outline",
				Size = NewUdim2(0, 4, 1, -20),
				Visible = true,
				BorderSizePixel = 0,
			})
			local Outline4 = Library:New("Frame", {
				Position = NewUdim2(0, 0, 0, 20),
				Parent = Background,
				BackgroundTransparency = 0,
				Theme = "Outline",
				Size = NewUdim2(1, 0, 0, 2),
				Visible = true,
				BorderSizePixel = 0,
			})

			return MultiSectionTable
		end

		return TabTable
	end

	function WindowTable:Notify(cfg)
		cfg = cfg or {}

		Library:Default(cfg, {
			Text = "This is a test notification\nYour mom",
			Warning = false,
			Time = 5,
			-- "Time", "Load", "None".
			Animation = "None",
		})

		local TextBounds = Utility:GetTextBounds(cfg.Text, Library.Font, Library.Size)
		local Objects = {}

		do
			Objects.Holder = Library:New("Frame", {
				Parent = NotifyHolder,
				BackgroundTransparency = 1,
				Size = NewUdim2(0, TextBounds.X + 8, 0, TextBounds.Y + 4),
				Visible = true,
				BorderSizePixel = 0,
			}, true)
			Objects.Inline = Library:New("Frame", {
				Parent = Objects.Holder,
				BackgroundTransparency = 1,
				Theme = "Inline 2",
				Position = NewUdim2(0, -23, 0, 0),
				Size = NewUdim2(1, 0, 1, 0),
				Visible = true,
				BorderSizePixel = 0,
			}, true)
			Objects.Background = Library:New("Frame", {
				Parent = Objects.Inline,
				BackgroundTransparency = 1,
				Theme = "Background",
				Position = NewUdim2(0, 1, 0, 1),
				Size = NewUdim2(1, -2, 1, -2),
				Visible = true,
				BorderSizePixel = 0,
			}, true)
			Objects.Outline = Library:New("Frame", {
				Position = NewUdim2(0, 0, 0, 0),
				Parent = Objects.Background,
				BackgroundTransparency = 1,
				Theme = "Outline",
				Size = NewUdim2(0, 2, 1, 0),
				Visible = true,
				BorderSizePixel = 0,
			}, true)
			Objects.Outline2 = Library:New("Frame", {
				Position = NewUdim2(0, 2, 0, 0),
				Parent = Objects.Background,
				BackgroundTransparency = 1,
				Theme = "Outline",
				Size = NewUdim2(1, -2, 0, 2),
				Visible = true,
				BorderSizePixel = 0,
			}, true)
			Objects.Accent = Library:New("Frame", {
				Position = NewUdim2(0, 0, 0, 0),
				Parent = Objects.Background,
				BackgroundTransparency = 1,
				Theme = "Accent",
				Size = NewUdim2(0, 1, 1, 0),
				Visible = true,
				BorderSizePixel = 0,
			}, true)
			Objects.AccentLine = Library:New("Frame", {
				Position = NewUdim2(0, 0, 1, -1),
				Parent = Objects.Background,
				BackgroundTransparency = 1,
				Theme = "Accent",
				Size = NewUdim2(0, 0, 0, 1),
				Visible = true,
				BorderSizePixel = 0,
			}, true)
			Objects.Title = Library:New("TextLabel", {
				Parent = Objects.Background,
				Theme = "Text",
				Text = cfg.Text,
				TextTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				BackgroundTransparency = 1,
				Position = NewUdim2(0, 4, 0, 0),
				Font = Library.Font,
				TextSize = Library.Size,
				Size = NewUdim2(0, TextBounds.X, 0, TextBounds.Y),
				Visible = true,
				BorderSizePixel = 0,
			}, true)
		end

		-- thx chat gpt <3
		local function PlayTween()
			local Tween = Animation:Create(Objects.AccentLine, nil, 2, "InOutQuad", "Sequential", {
				{
					Time = 0,
					Properties = {
						Position = NewUdim2(1, 0, 1, -1),
						Size = NewUdim2(0, 0, 0, 1)
					},
				},
				{
					Time = 0.25,
					Properties = {
						Position = NewUdim2(0.35, 0, 1, -1),
						Size = NewUdim2(0.3, 0, 0, 1)
					},
				},
				{
					Time = 0.5,
					Properties = {
						Position = NewUdim2(0, 0, 1, -1),
						Size = NewUdim2(0, 0, 0, 1)
					},
				},
				{
					Time = 0.75,
					Properties = {
						Position = NewUdim2(0.35, 0, 1, -1),
						Size = NewUdim2(0.3, 0, 0, 1)
					},
				},
				{
					Time = 1,
					Properties = {
						Position = NewUdim2(1, 0, 1, -1),
						Size = NewUdim2(0, 0, 0, 1)
					},
				},
			})

			Tween:Completed(function()
				PlayTween()
			end)

			Tween:Play()
		end

		if cfg.Animation == "Load" then
			PlayTween()
		end

		spawn(function()
			while wait() do
				if Objects.Holder == nil then
					break
				end

				if cfg.Warning then
					local Color = NewRGB(0, math.abs(math.sin(tick() * 1.5)) * 255, 0)

					Objects.Accent.BackgroundColor3 = Color
					Objects.AccentLine.BackgroundColor3 = Color
				end
			end
		end)

		spawn(function()
			Library:Tween(Objects.Inline, true, {Position = NewUdim2(0, 0, 0, 0)})

			for _,v in pairs(Objects) do
				if _ ~= "Holder" then
					if v:IsA("TextLabel") then
						local Old = v.TextTransparency
						v.TextTransparency = 1
						Library:Tween(v, true, {TextTransparency = 0})
					else
						if _:find("Outline") then
							Library:Tween(v, true, {BackgroundTransparency = 0.7})
						else
							Library:Tween(v, true, {BackgroundTransparency = 0})
						end
					end
				end
			end

			wait(Library.TweenSpeed)

			if cfg.Animation == "Time" then
				Animation:Create(Objects.AccentLine, {Size = NewUdim2(1, 0, 0, 1)}, cfg.Time, "Linear"):Play()
			end

			wait(cfg.Time)

			Library:Tween(Objects.Inline, true, {Position = NewUdim2(0, -TextBounds.X + 10, 0, 0)})

			for _,v in pairs(Objects) do
				if v:IsA("TextLabel") then
					Library:Tween(v, true, {TextTransparency = 1})
				else
					Library:Tween(v, true, {BackgroundTransparency = 1})
				end
			end

			wait(Library.TweenSpeed)

			Objects.Holder:Destroy()
			Objects.Holder = nil
		end)
	end

	function WindowTable:Watermark(cfg)
		cfg = cfg or {}

		local WatermarkTable = {}

		Library:Default(cfg, {
			Text = "GameShark / {user} / {ping}ms: Ping / {date}",
			TickRate = 30,
			Visible = true,
		})

		local WTick = tick()
		local Objects = {}

		do
			Objects.Inline = Library:New("Frame", {
				Parent = Library.ScreenGui,
				BackgroundTransparency = 0,
				Theme = "Inline 2",
				Position = NewUdim2(0, 20, 0, 26),
				Size = NewUdim2(0, 0, 0, 0),
				Visible = true,
				BorderSizePixel = 0,
			}, true)
			Objects.Background = Library:New("Frame", {
				Parent = Objects.Inline,
				BackgroundTransparency = 0,
				Theme = "Background",
				Position = NewUdim2(0, 1, 0, 1),
				Size = NewUdim2(1, -2, 1, -2),
				Visible = true,
				BorderSizePixel = 0,
			}, true)
			Objects.Outline = Library:New("Frame", {
				Position = NewUdim2(0, 0, 0, 0),
				Parent = Objects.Background,
				BackgroundTransparency = 0.7,
				Theme = "Outline",
				Size = NewUdim2(0, 2, 1, 0),
				Visible = true,
				BorderSizePixel = 0,
			}, true)
			Objects.Outline2 = Library:New("Frame", {
				Position = NewUdim2(0, 2, 0, 0),
				Parent = Objects.Background,
				BackgroundTransparency = 0.7,
				Theme = "Outline",
				Size = NewUdim2(1, -2, 0, 2),
				Visible = true,
				BorderSizePixel = 0,
			}, true)
			Objects.Accent = Library:New("Frame", {
				Position = NewUdim2(0, 0, 0, 0),
				Parent = Objects.Background,
				BackgroundTransparency = 0,
				Theme = "Accent",
				Size = NewUdim2(1, 0, 0, 1),
				Visible = true,
				BorderSizePixel = 0,
			}, true)
			Objects.Title = Library:New("TextLabel", {
				Parent = Objects.Background,
				Theme = "Text",
				Text = "",
				TextTransparency = 0,
				TextXAlignment = Enum.TextXAlignment.Left,
				BackgroundTransparency = 1,
				Position = NewUdim2(0, 4, 0, 1),
				Font = Library.Font,
				TextSize = Library.Size,
				Visible = true,
				BorderSizePixel = 0,
			}, true)
		end

		Utility:Connect(RunService.RenderStepped, function(step)
			Library.Fps = math.floor(1 / step)
			
			if tick() - WTick > cfg.TickRate / 50 and Objects.Inline.Visible then
				local Text = Library:TextTriggers(cfg.Text)
				local TextBounds = Utility:GetTextBounds(Text, Library.Font, Library.Size)

				Library:Tween(Objects.Inline, TweenInfo.new(cfg.TickRate / 50, Library.TweenType), {Size = NewUdim2(0, TextBounds.X + 10, 0, TextBounds.Y + 6)})

				Objects.Title.Size = NewUdim2(0, TextBounds.X, 0, TextBounds.Y)
				Objects.Title.Text = Text

				WTick = tick()
			end
		end)

		function WatermarkTable:Text(text)
			cfg.Text = text
		end

		function WatermarkTable:TickRate(rate)
			cfg.TickRate = rate
		end

		function WatermarkTable:Visible(bool)
			Objects.Inline.Visible = bool
		end

		return WatermarkTable
	end

	return WindowTable
end

function Library:SetOpen()
	-- am i crazy? - yes.
	local Window = Library.MainWindow

	--[[if Library.IsOpening then
		return
	end

	spawn(function()
		if not Library.IsOpening then
			Library.IsOpening = true

			if Window.Outline.Visible then
				Library.Open = false

				Library:Tween(Window.Accent, true, {Size = NewUdim2(0.5, 0, 0, 1), Position = NewUdim2(0.5, 0, 0, 25)})

				wait(Library.TweenSpeed)

				Library:Tween(Window.Accent, true, {Size = NewUdim2(0, 0, 0, 1), Position = NewUdim2(0, 0, 0, 25)})

				wait(Library.TweenSpeed)

				for _,v in pairs(Library.Drawings) do
					if (v:IsA("ImageButton") or v:IsA("ImageLabel") or v:IsA("ScrollingFrame") or v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("TextBox") or v:IsA("Frame")) and v.Visible then
						if v:IsA("ImageButton") or v:IsA("ImageLabel") then
							local Old = v.ImageTransparency
							local Tween = Library:Tween(v, true, {ImageTransparency = 1})

							Utility:Connect(Tween.Completed, function()
								wait(Library.TweenSpeed)
								v.ImageTransparency = Old
							end)
						elseif v:IsA("ScrollingFrame") then
							local Old = v.BackgroundTransparency
							local Old2 = v.ScrollBarImageTransparency
							local Tween = Library:Tween(v, true, {BackgroundTransparency = 1, ScrollBarImageTransparency = 1})

							Utility:Connect(Tween.Completed, function()
								wait(Library.TweenSpeed)
								v.BackgroundTransparency = Old
								v.ScrollBarImageTransparency = Old2
							end)
						elseif v:IsA("TextButton") then
							local Old = v.TextTransparency
							local Tween = Library:Tween(v, true, {TextTransparency = 1})

							Utility:Connect(Tween.Completed, function()
								wait(Library.TweenSpeed)
								v.TextTransparency = Old
							end)
						elseif v:IsA("TextBox") then
							local Old = v.TextTransparency
							local Tween = Library:Tween(v, true, {TextTransparency = 1})

							Utility:Connect(Tween.Completed, function()
								wait(Library.TweenSpeed)
								v.TextTransparency = Old
							end)
						elseif v:IsA("TextLabel") then
							local Old = v.TextTransparency
							local Tween = Library:Tween(v, true, {TextTransparency = 1})

							Utility:Connect(Tween.Completed, function()
								wait(Library.TweenSpeed)
								v.TextTransparency = Old
							end)
						else
							local Old = v.BackgroundTransparency
							local Tween = Library:Tween(v, true, {BackgroundTransparency = 1})

							Utility:Connect(Tween.Completed, function()
								wait(Library.TweenSpeed)
								v.BackgroundTransparency = Old
							end)
						end
					end
				end

				wait(Library.TweenSpeed)

				Window.Outline.Visible = false
			else
				Window.Outline.Visible = true
				Library.Open = true

				for _,v in pairs(Library.Drawings) do
					if (v:IsA("ImageButton") or v:IsA("ImageLabel") or v:IsA("ScrollingFrame") or v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("TextBox") or v:IsA("Frame")) and v.Visible then
						if v:IsA("ImageButton") or v:IsA("ImageLabel") then
							local Old = v.ImageTransparency
							v.ImageTransparency = 1
							local Tween = Library:Tween(v, true, {ImageTransparency = Old})
						elseif v:IsA("ScrollingFrame") then
							local Old = v.BackgroundTransparency
							local Old2 = v.ScrollBarImageTransparency
							v.BackgroundTransparency = 1
							v.ScrollBarImageTransparency = 1
							local Tween = Library:Tween(v, true, {BackgroundTransparency = Old, ScrollBarImageTransparency = Old2})
						elseif v:IsA("TextButton") then
							local Old = v.TextTransparency
							v.TextTransparency = 1
							local Tween = Library:Tween(v, true, {TextTransparency = Old})
						elseif v:IsA("TextBox") then
							local Old = v.TextTransparency
							v.TextTransparency = 1
							local Tween = Library:Tween(v, true, {TextTransparency = Old})
						elseif v:IsA("TextLabel") then
							local Old = v.TextTransparency
							v.TextTransparency = 1
							local Tween = Library:Tween(v, true, {TextTransparency = Old})
						else
							local Old = v.BackgroundTransparency
							v.BackgroundTransparency = 1
							local Tween = Library:Tween(v, true, {BackgroundTransparency = Old})
						end
					end
				end

				wait(Library.TweenSpeed)

				Library:Tween(Window.Accent, true, {Size = NewUdim2(0.5, 0, 0, 1), Position = NewUdim2(0.5, 0, 0, 25)})

				wait(Library.TweenSpeed)

				Library:Tween(Window.Accent, true, {Size = NewUdim2(1, 0, 0, 1), Position = NewUdim2(0, 0, 0, 25)})

				wait(Library.TweenSpeed)
			end

			wait(Library.TweenSpeed + 0.1)
			Library.IsOpening = false
		end
	end)]]

	if Library.IsOpening then
		return
	end

	spawn(function()
		if not Library.IsOpening then
			Library.IsOpening = true

			if Window.Outline.Visible then
				Library.Open = false

				Library:Tween(Window.Accent, true, {Size = NewUdim2(0.5, 0, 0, 1), Position = NewUdim2(0.5, 0, 0, 25)})

				wait(Library.TweenSpeed)

				Library:Tween(Window.Accent, true, {Size = NewUdim2(0, 0, 0, 1), Position = NewUdim2(0, 0, 0, 25)})

				wait(Library.TweenSpeed)

				Window.Outline.Visible = false
				Library.OverlayFrame.Visible = false
			else
				Window.Outline.Visible = true
				Library.OverlayFrame.Visible = true
				Library.Open = true

				Library:Tween(Window.Accent, true, {Size = NewUdim2(0.5, 0, 0, 1), Position = NewUdim2(0.5, 0, 0, 25)})

				wait(Library.TweenSpeed)

				Library:Tween(Window.Accent, true, {Size = NewUdim2(1, 0, 0, 1), Position = NewUdim2(0, 0, 0, 25)})

				wait(Library.TweenSpeed)
			end

			wait(Library.TweenSpeed + 0.1)
			Library.IsOpening = false
		end
	end)
end

function Library:GetConfig()
	local ConfigTable = {}

	for _,v in pairs(Library.ConfigFlags) do
		local Value = Library.Flags[_]

		if typeof(value) == "EnumItem" then
			ConfigTable[_] = tostring(Value)
		elseif typeof(value) == "Color3" then
			ConfigTable[_] = Value:ToHex()
		elseif typeof(Value) == "table" and typeof(Value[1]) == "Color3" then
			ConfigTable[_] = {Value[1]:ToHex(), Value[2]}
		else
			ConfigTable[_] = Value
		end
	end

	local Config = HttpService:JSONEncode(ConfigTable)

	return Config
end

function Library:LoadConfig(file)
	if isfile(file) then
		local ReadFile = readfile(file)
		local Config = HttpService:JSONDecode(ReadFile)
		
		for _,v in pairs(Config) do
			local Func = Library.ConfigFlags[_]

			if Func then
				Func(v)
			end
		end
	end
end

function Library:GetTheme()
	local Theme = {}

	for _,v in pairs(Library.Theme) do
		local Color = (typeof(v[1]) == "ColorSequence") and v[1].Keypoints[1].Value or v[1]
		local Anims = v[2]

		for _,a in pairs(Anims) do
			if typeof(a) == "table" then
				for _,v in pairs(a) do
					if typeof(v) == "Color3" then
						a[_] = v:ToHex()
					end
				end
			end
		end

		Theme[_] = {Color:ToHex(), Anims}
	end

	local Config = HttpService:JSONEncode(Theme)

	return Config
end

function Library:LoadTheme(file)
	if isfile(file) then
		local ReadFile = readfile(file)
		local Theme = HttpService:JSONDecode(ReadFile)
		
		for _,v in pairs(Theme) do			
			local Color = Color3.fromHex(v[1])
			if _:find("Gradient") then
				Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromHex(v[1])), ColorSequenceKeypoint.new(1.00, Color3.fromHex(v[1]))}
			end

			Library.Theme[_][1] = Color
			Library.Theme[_][2] = v[2]
		end
	end
end

function Library:SettingsTab(tab, window)
	local Watermark = window:Watermark()

	local ConfigSection = tab:Section({Name = "Configuration", ScaleSize = 0.57}) do
		local function GetConfigFiles(Folder)
			local Files = listfiles(Folder)
			local List = {}

			for _, v in ipairs(Files) do
                local FileName = v:gsub(Library.Folder .. "/Configs\\", ""):gsub(".gs", "")
                List[#List + 1] = FileName
            end
        
			return List
		end

		local ConfigName
		local Configs = ConfigSection:Dropdown({Name = "Config", flag = "Configs", Default = "", Content = {}, Callback = function(v)
			ConfigName:Set(v)
		end})
		ConfigName = ConfigSection:TextBox({Name = "Config Name", Default = "", Flag = "Config Name"})
		ConfigSection:Button({Name = "Save", Confirm = true, Callback = function()
			local File = Library.Flags["Config Name"]

			if isfile(Library.Folder .. "/Configs/" .. File .. ".gs") then
				window:Notify({Text = ("Successfully saved config (%s.gs)!"):format(File)})
				writefile(Library.Folder .. "/Configs/" .. File .. ".gs", Library:GetConfig())
			else
				window:Notify({Text = ("Successfully created & saved config (%s.gs)!"):format(File)})
				writefile(Library.Folder .. "/Configs/" .. File .. ".gs", Library:GetConfig())
			end

			Configs:Refresh(GetConfigFiles(Library.Folder .. "/Configs"))
			Configs:Set(File)
		end})
		ConfigSection:Button({Name = "Load", Confirm = true, Callback = function()
			local File = Library.Flags["Config Name"]

			if isfile(Library.Folder .. "/Configs/" .. File .. ".gs") then
				window:Notify({Text = ("Successfully loaded config (%s.gs)!"):format(File)})
				Library:LoadConfig(Library.Folder .. "/Configs/" .. File .. ".gs")
			end

			Configs:Refresh(GetConfigFiles(Library.Folder .. "/Configs"))
			Configs:Set(File)
		end})
		ConfigSection:Button({Name = "Reset", Confirm = true, Callback = function()
			local File = Library.Flags["Config Name"]

			if isfile(Library.Folder .. "/Configs/" .. File .. ".gs") then
				window:Notify({Text = ("Successfully reseted config (%s.gs)!"):format(File)})
				writefile(Library.Folder .. "/Configs/" .. File .. ".gs", "")
			end

			Configs:Refresh(GetConfigFiles(Library.Folder .. "/Configs"))
			Configs:Set(File)
		end})
		ConfigSection:Button({Name = "Delete", Confirm = true, Callback = function()
			local File = Library.Flags["Config Name"]

			if isfile(Library.Folder .. "/Configs/" .. File .. ".gs") then
				window:Notify({Text = ("Successfully deleted config (%s.gs)!"):format(File)})
				delfile(Library.Folder .. "/Configs/" .. File .. ".gs")
			end

			Configs:Refresh(GetConfigFiles(Library.Folder .. "/Configs"))
		end})
		ConfigSection:Button({Name = "Refresh", Callback = function()
			Configs:Refresh(GetConfigFiles(Library.Folder .. "/Configs"))
		end})
		ConfigSection:Toggle({Name = "Auto Save Config", Flag = "Auto Save"})

		Configs:Refresh(GetConfigFiles(Library.Folder .. "/Configs"))
	end
	
	local InterfaceSection = tab:Section({Name = "Interface", ScaleSize = 0.42, Size = 1}) do
		InterfaceSection:Keybind({Name = "Menu Bind", Flag = "Menu Keybind", Key = "Insert", Callback = function()
			Library:SetOpen()
		end})
		InterfaceSection:Toggle({Name = "Watermark", Flag = "Watermark Enabled", State = true, Callback = function(v)
			Watermark:Visible(v)
		end})
		InterfaceSection:Slider({Name = "Watermark Tickrate", Flag = "Watermark Tickrate", Min = 0, Max = 100, Default = 20, Callback = function(v)
			Watermark:TickRate(v)
		end})
		InterfaceSection:TextBox({Name = "Watermark Text", Default = "GameShark / {user} / {ping}ms: Ping / {date}", Flag = "Watermark Text", Callback = function(v)
			Watermark:Text(v)
		end})
	end

	local ThemeSection = tab:Section({Name = "Themes", Side = "Right"}) do
		local function GetThemeFiles(Folder)
			local Files = listfiles(Folder)
			local List = {}

			for _, v in ipairs(Files) do
                local FileName = v:gsub(Library.Folder .. "/Themes\\", ""):gsub(".gs", "")
                List[#List + 1] = FileName
            end
        
			return List
		end

		local ThemeColorPickers = {}

		local ThemeName
		local Themes = ThemeSection:Dropdown({Name = "Theme", flag = "Themes", Default = "", Content = {}, Callback = function(v)
			ThemeName:Set(v)
		end})
		ThemeName = ThemeSection:TextBox({Name = "Theme Name", Default = "", Flag = "Theme Name"})
		ThemeSection:Button({Name = "Save", Confirm = true, Callback = function()
			local File = Library.Flags["Theme Name"]

			if isfile(Library.Folder .. "/Themes/" .. File .. ".gs") then
				window:Notify({Text = ("Successfully saved theme (%s.gs)!"):format(File)})
				writefile(Library.Folder .. "/Themes/" .. File .. ".gs", Library:GetTheme())
			else
				window:Notify({Text = ("Successfully created & saved theme (%s.gs)!"):format(File)})
				writefile(Library.Folder .. "/Themes/" .. File .. ".gs", Library:GetTheme())
			end

			Themes:Refresh(GetThemeFiles(Library.Folder .. "/Themes"))
			Themes:Set(File)
		end})
		ThemeSection:Button({Name = "Load", Confirm = true, Callback = function()
			local File = Library.Flags["Theme Name"]

			if isfile(Library.Folder .. "/Themes/" .. File .. ".gs") then
				window:Notify({Text = ("Successfully loaded theme (%s.gs)!"):format(File)})
				Library:LoadTheme(Library.Folder .. "/Themes/" .. File .. ".gs")
				
				task.spawn(function()
					for i = 1, 2 do
						for _,v in pairs(ThemeColorPickers) do
							local ThemeColor = Library.Theme[_][1]
							local ThemeAnim = Library.Theme[_][2]
							local Color = typeof(ThemeColor) == "ColorSequence" and ThemeColor.Keypoints[1].Value or ThemeColor
							
							v:Set({Color, 1})
							v:SetAnim(ThemeAnim)
						end
						wait(0.5)
					end
				end)
			end

			Themes:Refresh(GetThemeFiles(Library.Folder .. "/Themes"))
			Themes:Set(File)
		end})
		ThemeSection:Button({Name = "Reset", Confirm = true, Callback = function()
			task.spawn(function()
				for i = 1, 2 do
					for _,v in pairs(ThemeColorPickers) do
						local ThemeColor = Library.MainTheme[_][1]
						local ThemeAnim = Library.MainTheme[_][2]
						local Color = typeof(ThemeColor) == "ColorSequence" and ThemeColor.Keypoints[1].Value or ThemeColor

						v:Set({Color, 1})
						v:SetAnim(ThemeAnim)
					end
					wait(0.5)
				end
			end)
		end})
		ThemeSection:Button({Name = "Delete", Confirm = true, Callback = function()
			local File = Library.Flags["Theme Name"]

			if isfile(Library.Folder .. "/Themes/" .. File .. ".gs") then
				window:Notify({Text = ("Successfully deleted theme (%s.gs)!"):format(File)})
				delfile(Library.Folder .. "/Themes/" .. File .. ".gs")
			end

			Themes:Refresh(GetThemeFiles(Library.Folder .. "/Themes"))
		end})
		ThemeSection:Button({Name = "Refresh", Callback = function()
			Themes:Refresh(GetThemeFiles(Library.Folder .. "/Themes"))
		end})

		for _, v in pairs(Library.Theme) do
			local Color = (typeof(v[1]) == "ColorSequence") and v[1].Keypoints[1].Value or v[1]
			ThemeColorPickers[_] = ThemeSection:ColorPicker({Name = _, Flag = _, Default = Color, Ignore = true, Callback = function(color, gay)
				Library:ChangeTheme(_, typeof(v[1]) == "ColorSequence" and ColorSequence.new{ColorSequenceKeypoint.new(0.00, color[1]), ColorSequenceKeypoint.new(1.00, color[1])} or color[1])
				Library.Flags[_ .. " theme"](_)
				if not gay then
					Library.Flags[_ .. " anim"](v[2])
				end
			end})
		end

		Themes:Refresh(GetThemeFiles(Library.Folder .. "/Themes"))
	end
end

return Library