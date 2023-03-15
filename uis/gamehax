-- // boui moment!!!
-- // inspired by splix

local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local ts = game:GetService("TweenService")
local plrs = game:GetService("Players")
local stats = game:GetService("Stats")

local lplr = plrs.LocalPlayer

-- / vector 2

local v2new = Vector2.new
local v2zero = Vector2.zero

-- / color3

local c3rgb, c3hsv = Color3.fromRGB, Color3.fromHSV

-- // library!!!

local library = {
    drawings = {{}, {}},
    preloaded_images = {},
    connections = {},
    flags = {},
    pointers = {},
    groups = {},
    fade_instances = {},
    loaded = false,
}

-- // utility

local utility = {}

-- // utility coding

do

    utility.vozoid_tween = loadstring(game:HttpGet("https://raw.githubusercontent.com/vozoid/utility/main/Tween.lua"))()

    -- // utility:Draw is super pasted and skidded and shitcoded even i cant read it even tho i coded it
    -- // xyl pls dont ban me for this code 😭😢

    -- // 24 december 2022: added groups to make my life easier

    function utility:Draw(class, offset, properties, t)
        t = t or false

        local draw = Drawing.new(class)
        local fakeDraw = {}
        rawset(fakeDraw, "__OBJECT_EXIST", true)

        local customProperties = {
            ["Parent"] = function(object)
                table.insert(rawget(object, "children"), fakeDraw)
            end,
            ["Group"] = function(name)
                if library.groups[name] == nil then
                    library.groups[name] = {}
                end

                table.insert(library.groups[name], fakeDraw)
            end,
            ["OffsetX"] = function(x)
                fakeDraw.SetOffset(x, fadeDraw.GetOffset().Y)
            end,
            ["OffsetY"] = function(Y)
                fakeDraw.SetOffset(fadeDraw.GetOffset().X, y)
            end
        }

        setmetatable(fakeDraw, {
            __index = function(self, key)
                if rawget(fakeDraw, "__OBJECT_EXIST") then
                    return draw[key]
                end
            end,
            __newindex = function(self, key, value)
                if rawget(fakeDraw, "__OBJECT_EXIST") then
                    if customProperties[key] then
                        customProperties[key](value)
                    else
                        draw[key] = value
                        if key == "Position" then
                            for _, v in pairs(rawget(fakeDraw, "children")) do
                                v.Position = fakeDraw.Position + v.GetOffset()
                            end
                        end
                    end
                end
            end
        })
        rawset(fakeDraw, "getDefaultTransparency", function(self)
            return rawget(self, "__properties").Transparency or 1
        end)
        rawset(fakeDraw, "Remove", function()
            if rawget(fakeDraw, "__OBJECT_EXIST") then
                draw:Remove()
                rawset(fakeDraw, "__OBJECT_EXIST", false)
            end
        end)
        rawset(fakeDraw, "GetType", function()
            return class
        end)
        rawset(fakeDraw, "GetOffset", function()
            return offset or v2new()
        end)
        rawset(fakeDraw, "SetOffset", function(noffset)
            offset = noffset or v2new()

            if properties and properties.Parent then
                fakeDraw.Position = properties.Parent.Position + fakeDraw.GetOffset()
            end
        end)
        rawset(fakeDraw, "__properties", properties)
        rawset(fakeDraw, "children", {})

        local lerpLoop

        function lerp(v1, v2, ptc) -- // exists so it does work for Color3 n shit
            if typeof(v1) == "number" then
                return v1 + ((v2 - v1) * ptc)
            end
            return v1:Lerp(v2, ptc)
        end

        rawset(fakeDraw, "Lerp", function(to, time, removeOld)
            if not rawget(fakeDraw, "__OBJECT_EXIST") then return end

            --utility.vozoid_tween.new(fakeDraw, TweenInfo.new(instanceTime, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), instanceTo):Play()

            local from = {}
	
            for i, _ in pairs(to) do
                from[i] = fakeDraw[i]
            end
            
            local elapsed = 0

            if lerpLoop ~= nil and removeOld then
                lerpLoop:Disconnect()
                lerpLoop = nil
            end
            
            local loop; loop = rs.Heartbeat:Connect(function(delta)
                
                if elapsed == time then
                    for i, v in pairs(to) do
                        fakeDraw[i] = v
                    end

                    lerpLoop = nil
                    
                    loop:Disconnect()
                end

                local ptc = (elapsed / time)
                
                for i, v in pairs(to) do
                    fakeDraw[i] = lerp(from[i], v, ptc)
                end
                
                elapsed = math.clamp(elapsed + delta, 0, time)
                
            end)

            lerpLoop = loop

        end)

        if class == "Square" or class == "Circle" or class == "Line" then
            fakeDraw.Thickness = 1
            if class == "Square" then
                fakeDraw.Filled = true
                fakeDraw.Thickness = 1
            end
        end

        if class ~= "Image" then
            fakeDraw.Color = Color3.new(0, 0, 0)
        end

        fakeDraw.Visible = library.loaded
        if properties ~= nil then
            for key, value in pairs(properties) do
                if customProperties[key] == nil then
                    fakeDraw[key] = value
                else
                    customProperties[key](value)
                end
            end
            if properties.Parent then
                fakeDraw.Position = properties.Parent.Position + fakeDraw.GetOffset()
            end
            if properties.Parent and properties.From then
                fakeDraw.From = properties.Parent.Position + fakeDraw.GetOffset()
            end
            if properties.Parent and properties.To then
                fakeDraw.To = properties.Parent.Position + fakeDraw.GetOffset()
            end
        end

        if not library.loaded and not t then
            fakeDraw.Transparency = 0
        end

        properties = properties or {}

        if not t then
            table.insert(library.drawings[1], {fakeDraw, properties["Transparency"] or 1, class})
        else
            table.insert(library.drawings[2], {fakeDraw, properties["Transparency"] or 1, class})
        end

        return fakeDraw
    end

    function utility:ScreenSize()
        return workspace.CurrentCamera.ViewportSize
    end

    function utility:RoundVector(vector)
        return v2new(math.floor(vector.X), math.floor(vector.Y))
    end

    function utility:MouseOverDrawing(object)
        local values = {object.Position, object.Position + object.Size}
        local mouseLocation = uis:GetMouseLocation()
        return mouseLocation.X >= values[1].X and mouseLocation.Y >= values[1].Y and mouseLocation.X <= values[2].X and mouseLocation.Y <= values[2].Y
    end

    function utility:MouseOverPosition(values)
        local mouseLocation = uis:GetMouseLocation()
        return mouseLocation.X >= values[1].X and mouseLocation.Y >= values[1].Y and mouseLocation.X <= values[2].X and mouseLocation.Y <= values[2].Y
    end

    function utility:PreloadImage(link)
        local data = library.preloaded_images[link] or game:HttpGet(link)
        if library.preloaded_images[link] == nil then
            library.preloaded_images[link] = data
        end
        return data
    end

    function utility:Image(object, link)
        local data = library.preloaded_images[link] or game:HttpGet(link)
        if library.preloaded_images[link] == nil then
            library.preloaded_images[link] = data
        end
        object.Data = data
    end

    function utility:Connect(connection, func)
        local con = connection:Connect(func)
        table.insert(library.connections, con)
        return con
    end

    function utility:BindToRenderStep(name, priority, func)
        local fake_connection = {}

        function fake_connection:Disconnect()
            rs:UnbindFromRenderStep(name)
        end

        rs:BindToRenderStep(name, priority, func)

        return fake_connection
    end

    function utility:Combine(t1, t2)
        local t3 = {}
        for i, v in pairs(t1) do
            table.insert(t3, v)
        end
        for i, v in pairs(t2) do
            table.insert(t3, v)
        end
        return t3
    end

    -- // xyl thanks for the method cause im npc

    function utility:GetPlexSize(text)
        return #text * 7
    end

    function utility:CopyTable(tbl)
        local newtbl = {}
        for i, v in pairs(tbl) do
            newtbl[i] = v
        end
        return newtbl
    end

    -- // function i will never use?

    function utility:ShiftKey(key)
        if string.byte(key) >= 65 and string.byte(key) <= 122 then
            return key:upper()
        else
            local shiftKeybinds = {["-"] = "_", ["="] = "+", ["1"] = "!", ["2"] = "@", ["3"] = "#", ["4"] = "$", ["5"] = "%", ["6"] = "^", ["7"] = "&", ["8"] = "*", ["9"] = "(", ["0"] = ")", [";"] = ":", ["'"] = "\"", ["\\"] = "|", ["/"] = "?"}
            return shiftKeybinds[key] or key
        end
    end

    -- // totally not pasted from splix (100%)
    -- //        oh no im a paster

    utility.short_keybind_names = {["MouseButton1"] = "MB1", ["MouseButton2"] = "MB2", ["MouseButton3"] = "MB3", ["Insert"] = "INS", ["LeftAlt"] = "LALT", ["LeftControl"] = "LC", ["LeftShift"] = "LS", ["RightAlt"] = "RALT", ["RightControl"] = "RC", ["RightShift"] = "RS", ["CapsLock"] = "CAPS", ["Return"] = "RET", ["Backspace"] = "BSP"}
end

function library.Window(self, info, theme)

    theme = theme or {
        accent = c3rgb(255, 0, 0),
        dcont = c3rgb(20, 20, 20),
        lcont = c3rgb(40, 40, 40),
        cont = c3rgb(30, 30, 30),
        outline = c3rgb(0, 0, 0),
        outline2 = c3rgb(45, 45, 45)
    }

    local name = info.name or "worst ui library ever"
    local size = typeof(info.size) == "Vector2" and info.size or v2new(500, 600)

    local window = {shit = {}, kbds = {}, rna = {}, sshit = nil, theme = theme, tabs = {}, _last = {0, 0}, start = v2zero, connections = {}, dragging = false}

    local main_frame = utility:Draw("Square", nil, {
        Size = size,
        Color = window.theme.lcont,
        Group = "lcont",
        Position = utility:RoundVector(utility:ScreenSize() / 2 - v2new(250, 300))
    })

    window.frame = main_frame

    utility:Connect(uis.InputBegan, function(input)
        if main_frame.Visible and input.UserInputType == Enum.UserInputType.MouseButton1 and utility:MouseOverPosition({main_frame.Position, main_frame.Position + v2new(main_frame.Size.X, 20)}) then
            window.start = uis:GetMouseLocation() - main_frame.Position
            window.dragging = true
        end
    end)

    utility:Connect(uis.InputEnded, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            window.dragging = false
        end
    end)

    utility:Connect(uis.InputChanged, function(input)
        if main_frame.Visible and input.UserInputType == Enum.UserInputType.MouseMovement and window.dragging then
            main_frame.Position = uis:GetMouseLocation() - window.start
        end
    end)

    local main_frame_outline = utility:Draw("Square", v2new(-1, -1), {
        Size = main_frame.Size + v2new(2, 2),
        Color = window.theme.outline,
        Group = "outline",
        Filled = false,
        Parent = main_frame
    })

    local main_frame_accent = utility:Draw("Square", v2new(-2, -2), {
        Size = main_frame.Size + v2new(4, 4),
        Color = window.theme.accent,
        Filled = false,
        Group = "accent",
        Parent = main_frame
    })

    local main_frame_title = utility:Draw("Text", v2new(3, 2), {
        Font = 2,
        Size = 13,
        Outline = true,
        Color = Color3.new(1, 1, 1),
        Text = name,
        Parent = main_frame
    })

    local pretab_frame = utility:Draw("Square", v2new(6, 20), {
        Size = main_frame.Size - v2new(12, 26),
        Color = window.theme.dcont,
        Group = "dcont",
        Parent = main_frame
    })

    local pretab_frame_inline = utility:Draw("Square", v2new(-1, -1), {
        Size = pretab_frame.Size + v2new(2, 2),
        Color = window.theme.dcont,
        Group = "dcont",
        Filled = false,
        Parent = pretab_frame
    })

    local pretab_frame_outline = utility:Draw("Square", v2new(-2, -2), {
        Size = pretab_frame.Size + v2new(4, 4),
        Color = c3rgb(),
        Group = "outline",
        Filled = false,
        Parent = pretab_frame
    })

    local tabs_frame = utility:Draw("Square", v2new(6, 23), {
        Size = main_frame.Size - v2new(24, 55),
        Color = window.theme.lcont,
        Group = "lcont",
        Parent = pretab_frame
    })

    local tab_frame_accent = utility:Draw("Square", v2zero, {
        Size = v2new(0, 1),
        Color = window.theme.accent,
        Group = "accent",
        ZIndex = 1
    })

    utility:Connect(rs.RenderStepped, function()
        if main_frame.Visible and window.sshit then
            local tab_frame = window.sshit.instances[1]

            tab_frame_accent.Size = v2new(tab_frame.Size.X, 1)
            tab_frame_accent.Position = tab_frame.Position
        end
    end)

    local tabs_frame_outline = utility:Draw("Square", v2new(-1, -1), {
        Size = tabs_frame.Size + v2new(2, 2),
        Color = window.theme.outline2,
        Group = "outline2",
        Filled = false,
        Parent = tabs_frame
    })

    function window.Tab(self, info)

        local name = info.name or "tab"

        local offset = v2new(0, -19)

        local tab = {name = name, instances = {}, sections = {}, sides = {{}, {}}, on = false}

        local count = 1

        if #self.tabs > 0 then

            count = #self.tabs + 1
            
            offset = self.tabs[#self.tabs].instances[1].GetOffset() + v2new(self.tabs[#self.tabs].instances[1].Size.X + 1, 0)
        end

        local tab_frame = utility:Draw("Square", offset, {
            Size = v2new(utility:GetPlexSize(name) + 12, 18),
            Color = window.theme.lcont,
            Parent = tabs_frame
        })

        local tab_frame_outline = utility:Draw("Square", v2new(-1, -1), {
            Size = tab_frame.Size + v2new(2, 2),
            Color = window.theme.outline2,
            Group = "outline2",
            Filled = false,
            Parent = tab_frame
        })

        local tab_frame_text = utility:Draw("Text", v2new(tab_frame.Size.X / 2, 2), {
            Font = 2,
            Size = 13,
            Text = name,
            Color = Color3.new(1, 1, 1),
            Outline = true,
            Center = true,
            Parent = tab_frame
        })

        local tab_frame_hider = utility:Draw("Square", v2new(0, tab_frame.Size.Y), {
            Size = v2new(tab_frame.Size.X, 1),
            Color = window.theme.lcont,
            Group = "lcont",
            Parent = tab_frame
        })

        tab.instances = {tab_frame, tab_frame_outline, tab_frame_text, tab_frame_hider}

        table.insert(self.tabs, tab)

        function tab.Show(self)
            tab_frame.Color = window.theme.lcont
            tab_frame_hider.Visible = true

            for i, v in pairs(self.sections) do
                v:Show()
            end

            self.on = true

            self:Update()
        end

        function tab.Hide(self)
            tab_frame.Color = window.theme.dcont
            tab_frame_hider.Visible = false

            for i, v in pairs(self.sections) do
                v:Hide()
            end

            self.on = false

            self:Update()
        end

        function tab.UpdateColor(self)
            tab_frame.Color = self.on and window.theme.lcont or window.theme.dcont
        end

        function tab.Update(self)

            -- // loop for every side (left, right)

            for sn, side in pairs(self.sides) do

                -- // every section in it

                for i, v in pairs(side) do

                    -- // update it's size
                    
                    v:Update()

                    -- // count y offset

                    local offset = 12

                    -- // if its not first section

                    if i > 1 then

                        -- // last section_frame instance

                        local last_sframe = side[i - 1].instances[1]

                        -- // set new section_frame instance offset with counting last section_frame offset (y) + size (y) + 16 (default offset)

                        offset = offset + last_sframe.GetOffset().Y + last_sframe.Size.Y

                    end

                    -- // set offset

                    v.instances[1].SetOffset(v2new(sn == 1 and 6 or tabs_frame.Size.X/2+6, offset))
                end
            end

            self:UpdateColor()

            for i, v in pairs(self.sections) do
                v:Update()
            end
        end

        function tab.Section(self, info)
            local name = info.name or "section"
            local side = info.side or "left" side = tostring(side):lower()
            local render_non_attached = info.rna or info.render_non_attached or false

            -- // side check

            if side ~= "left" and side ~= "right" then
                side = "left"
            end

            -- // section

            local section = {name = name, side = side, instances = {}, scale = 0, things = {buttons = {}, toggles = {}, textboxes = {}, dropdowns = {}, sliders = {}, colorpickers ={}, keybinds = {}, lists = {}}, rna = render_non_attached}

            local section_frame 

            if section.rna then
                section_frame = utility:Draw("Square", v2new(side == "left" and 6 or tabs_frame.Size.X/2 - 6, 16), {
                    Size = v2new(228, section.scale),
                    Color = window.theme.cont,
                    Group = "cont"
                })

                table.insert(window.rna, section)
            else
                section_frame = utility:Draw("Square", v2new(side == "left" and 6 or tabs_frame.Size.X/2 - 6, 16), {
                    Size = v2new(tabs_frame.Size.X / 2 - 12, section.scale),
                    Color = window.theme.cont,
                    Group = "cont",
                    Parent = tabs_frame
                })
            end

            local section_inline = utility:Draw("Square", v2new(-1, -1), {
                Size = section_frame.Size + v2new(2, 2),
                Color = window.theme.outline,
                Group = "outline",
                Filled = false,
                Parent = section_frame
            })

            local section_outline = utility:Draw("Square", v2new(-2, -2), {
                Size = section_frame.Size + v2new(4, 4),
                Color = window.theme.lcont,
                Group = "lcont",
                Filled = false,
                Parent = section_frame
            })

            local section_accent = utility:Draw("Square", v2new(0, 0), {
                Size = v2new(8, 2),
                Color = window.theme.accent,
                Group = "accent",
                Parent = section_frame
            })

            local section_title = utility:Draw("Text", v2new(9, -7), {
                Font = 2,
                Size = 13,
                Color = Color3.new(1, 1, 1),
                --Outline = true,
                Text = name,
                Parent = section_frame
            })

            local section_title_bold = utility:Draw("Text", v2new(1, 0), {
                Font = 2,
                Size = 13,
                Color = Color3.new(1, 1, 1),
                Text = name,
                Parent = section_title
            })

            local section_accent2 = utility:Draw("Square", v2new(11 + (#name * 7), 0), {
                Size = v2new(section_frame.Size.X - (11 + (#name * 7)), 2),
                Color = window.theme.accent,
                Group = "accent",
                Parent = section_frame
            })

            function section.Show(self)
                for i, v in pairs(self.instances) do
                    v.Visible = true

                    if v.Transparency ~= v:getDefaultTransparency() and not window.fading then
                        v.Transparency = v:getDefaultTransparency()
                    end
                end
            end

            function section.Hide(self)
                for i, v in pairs(self.instances) do
                    v.Visible = false
                end
            end

            function section.NextObjectPosition(self)
                return self.scale > 0 and self.scale or 10
            end

            function section.UpdateScale(self, number)
                if self.scale == 0 then
                    self.scale = 10
                end

                self.scale = self.scale + number + 5
            end

            function section.Update(self)

                local tside = tab.sides[self.side == "left" and 1 or 2]

                section_frame.Size = v2new(self.rna and 228 or tabs_frame.Size.X / 2 - 12, table.find(tside, self) == #tside and tabs_frame.Size.Y - (section_frame.GetOffset().Y+5) or self.scale > 0 and self.scale or 10)
                section_inline.Size = section_frame.Size + v2new(2, 2)
                section_outline.Size = section_inline.Size + v2new(2, 2)
                section_accent2.Size = v2new(section_frame.Size.X - (11 + (#name * 7)), 2)

                for i, v in pairs(self.things.lists) do
                    v:update()
                end

                for _, thing in pairs({"buttons", "dropdowns", "sliders", "textboxes", "keybinds", "colorpickers", "toggles"}) do
                    for i, v in pairs(section.things[thing]) do
                        v:Update()
                    end
                end
            end

            function section.SetPositionIHateMyselfAndIWannaDieOk(self, new_pos)
                if self.rna then
                    section_frame.Position = new_pos
                end
            end

            if self.rna then
                section:SetPositionIHateMyselfAndIWannaDieOk(v2new(-1000, -1000))
            end

            utility:Connect(uis.InputChanged, function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement and window.tooltip and main_frame.Visible and utility:MouseOverDrawing(section_frame) then
                    local is_it_visible = false

                    if tab.on then
                        for i, v in pairs(section.things.toggles) do
                            if is_it_visible then break end
                            local toggle_frame = getupvalue(v.Update, 1)

                            if v.tt ~= "" and utility:MouseOverPosition({section_frame.Position + v2new(0, toggle_frame.GetOffset().Y), section_frame.Position + v2new(section_frame.Size.X, toggle_frame.GetOffset().Y + 17)}) then
                                is_it_visible = true

                                window.tooltip:SetPosition(toggle_frame.Position + v2new(0, 12))
                                window.tooltip:SetText(v.tt)
                            end
                        end
                    end

                    if not is_it_visible and tab.on then
                        window.tooltip:SetPosition(v2new(-1000, -1000))
                    end
                elseif not utility:MouseOverDrawing(main_frame) and window.tooltip then
                    window.tooltip:SetPosition(v2new(-1000, -1000))
                end
            end)

            -- // same for colorpicker just function

            function section._Keybind(self, info, offsets, parent, do_update, pointer, name2)
                local def = info.def or "unset"
                local name = info.name
                local flag = info.flag

                local keybind = {value = def, flag = flag, pointer = pointer, name = name, sname = name2, mode = "toggle", instances = {}, minst = {}, binding = false}

                if pointer then
                    library.pointers[pointer] = keybind
                end

                local keybind_frame = utility:Draw("Square", offsets[1], {
                    Size = v2new(40, 12),
                    Color = window.theme.lcont,
                    Group = "lcont",
                    Parent = parent
                })

                local keybind_title = utility:Draw("Text", offsets[2], {
                    Font = 2,
                    Size = 13,
                    Color = c3rgb(255, 255, 255),
                    Outline = true,
                    Text = name,
                    Parent = parent
                })

                if not do_update then
                    keybind_title.Text = ""
                end

                local keybind_outline = utility:Draw("Square", v2new(-1, -1), {
                    Size = keybind_frame.Size + v2new(2, 2),
                    Color = window.theme.outline,
                    Group = "outline",
                    Filled = false,
                    Parent = keybind_frame
                })

                local keybind_gradient = utility:Draw("Image", v2zero, {
                    Size = keybind_frame.Size,
                    Transparency = 0.35,
                    Parent = keybind_frame
                })

                local keybind_value = utility:Draw("Text", v2new(keybind_frame.Size.X / 2, -1), {
                    Font = 2,
                    Size = 13,
                    Color = c3rgb(255, 255, 255),
                    Outline = true,
                    Center = true,
                    Text = keybind.value,
                    Parent = keybind_frame
                })

                utility:Image(keybind_gradient, "https://i.imgur.com/j9y4dux.png")

                function keybind.Get(self)
                    return {self.value, self.mode}
                end

                function keybind.SetOffset(self, offset)
                    keybind_frame.SetOffset(offset)
                end
                
                function keybind.Update(self)
                    keybind_value.Text = utility.short_keybind_names[self.value] or self.value:upper()

                    if parent == section_frame then
                        self:SetOffset(v2new(parent.Size.X - 46, offsets[1].Y))
                    end

                    if window.kblist then
                        window.kblist:Update()
                    end
                end

                function keybind.Set(self, value)
                    self.value = value[1]
                    self.mode = value[2]

                    self:Update()
                end

                function keybind.AddToTable(self, input_name)
                    if keybind.value == input_name then
                        if keybind.mode == "toggle" then
                            if table.find(window.kbds, keybind.pointer) then
                                table.remove(window.kbds, table.find(window.kbds, keybind.pointer))
                            else
                                table.insert(window.kbds, keybind.pointer)
                            end
                        else
                            table.insert(window.kbds, keybind.pointer)
                        end

                        if window.kblist then
                            window.kblist:Update()
                        end
                    end
                end

                function keybind.Close(self)
                    if #self.minst > 0 then
                        for i, v in pairs(self.minst) do
                            v.Remove()
                        end

                        table.clear(self.minst)
                    end

                    window.shit.keybind = nil
                end

                function keybind.Open(self)

                    window:HideUselessDumbassFuckingShitStopPastingMyCodePleaseYouAreSkidAndImGayILikeBigBlackManOkNoProblemThisIsASexcretFuncteiotieitns4epoivi2n45obvi6j45bv74gvho4hgv487()
                    
                    local mframe = utility:Draw("Square", v2new(0, 15), {
                        Color = window.theme.dcont,
                        Group = "dcont",
                        Size = v2new(48, 5 + 26),
                        Parent = keybind_frame
                    })

                    local mframe_outline = utility:Draw("Square", v2new(-1, -1), {
                        Color = window.theme.outline,
                        Group = "outline",
                        Size = mframe.Size + v2new(2, 2),
                        Filled = false,
                        Parent = mframe
                    })

                    local modes = {}

                    for i, v in pairs({"Toggle", "Hold"}) do

                        modes[i] = utility:Draw("Text", v2new(3, 2 + 14 * (i-1)), {
                            Font = 2,
                            Size = 13,
                            Color = self.mode == v:lower() and window.theme.accent or c3rgb(255, 255, 255),
                            Group = "accent",
                            Outline = true,
                            Text = v,
                            Parent = mframe
                        })

                    end

                    self.minst = {mframe, mframe_outline, unpack(modes)}

                    window.shit.keybind = self

                end

                keybind:Set({keybind.value, "toggle"})

                utility:Connect(uis.InputBegan, function(input)
                    if not keybind.binding then
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            if main_frame.Visible and (tab.on or table.find(window.rna, section)) and not window:FakeRealMouseFuckingImAloneGoingToKillMyselfWithKnife(section) and utility:MouseOverDrawing(keybind_frame) then
                                keybind.binding = true
                                keybind_value.Text = "..."
                            else
                                if #keybind.minst > 0 then
                                    if utility:MouseOverDrawing(keybind.minst[1]) then
                                        local offset = uis:GetMouseLocation().Y - keybind.minst[1].Position.Y

                                        if offset >= 22 then
                                            keybind.mode = "hold"
                                        else
                                            keybind.mode = "toggle"
                                        end

                                        for i, v in pairs({keybind.minst[3], keybind.minst[4]}) do
                                            v.Color = keybind.mode == v.Text:lower() and window.theme.accent or c3rgb(255, 255, 255)
                                        end
                                    else
                                        keybind:Close()
                                    end
                                end

                                keybind:AddToTable(input.UserInputType.Name)
                            end
                        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                            if main_frame.Visible and (tab.on or table.find(window.rna, section)) and not window:FakeRealMouseFuckingImAloneGoingToKillMyselfWithKnife(section) and utility:MouseOverDrawing(keybind_frame) then
                                keybind:Open()
                            else
                                keybind:AddToTable(input.UserInputType.Name)
                            end
                        elseif input.UserInputType == Enum.UserInputType.Keyboard then
                            keybind:AddToTable(input.KeyCode.Name)
                        end
                    else
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            if input.KeyCode ~= Enum.KeyCode.Escape then
                                keybind.binding = false
                                keybind:Set({input.KeyCode.Name, keybind.mode})
                            else
                                keybind.binding = false
                                keybind:Set({"unset", keybind.mode})
                            end
                        elseif input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 then
                            keybind.binding = false
                            keybind:Set({input.UserInputType.Name, keybind.mode})
                        end
                    end
                end)

                utility:Connect(uis.InputEnded, function(input)
                    if not keybind.binding and keybind.mode == "hold" then
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 then
                            if keybind.value == input.UserInputType.Name then
                                if table.find(window.kbds, keybind.pointer) then
                                    table.remove(window.kbds, table.find(window.kbds, keybind.pointer))

                                    if window.kblist then
                                        window.kblist:Update()
                                    end
                                end
                            end
                        elseif input.UserInputType == Enum.UserInputType.Keyboard then
                            if keybind.value == input.KeyCode.Name then
                                if table.find(window.kbds, keybind.pointer) then
                                    table.remove(window.kbds, table.find(window.kbds, keybind.pointer))

                                    if window.kblist then
                                        window.kblist:Update()
                                    end
                                end
                            end
                        end
                    end
                end)

                keybind.instances = {keybind_frame, keybind_title, keybind_outline, keybind_gradient, keybind_value}

                self.instances = utility:Combine(self.instances, keybind.instances)

                if do_update then
                    self:UpdateScale(13)
                end

                table.insert(section.things.keybinds, keybind)

                return keybind

            end

            function section._Colorpicker(self, info, offsets, parent, do_update, pointer, cptable)
                local name = info.name
                local def = info.def or c3rgb(255, 0, 0)
                local trans = info.trans or info.transparency
                local deftrans = info.deftrans or info.defaultrans or 0
                local flag = info.flag
                local callback = info.callback or function() end

                local colorpicker = {value = def, name = name, trans = trans, callback = callback, pointer = pointer, flag = flag, dvalues = {}, instances = {}}

                if pointer then
                    library.pointers[pointer] = colorpicker
                end

                table.insert(cptable, colorpicker)

                local cpframe = utility:Draw("Square", offsets[1], {
                    Size = v2new(30, 12),
                    Color = def,
                    Parent = parent
                })

                local cpframe_outline = utility:Draw("Square", v2new(-1, -1), {
                    Size = cpframe.Size + v2new(2, 2),
                    Color = window.theme.outline,
                    Group = "outline",
                    Filled = false,
                    Parent = cpframe
                })

                local cpframe_gradient = utility:Draw("Image", v2zero, {
                    Size = cpframe.Size,
                    Transparency = 0.35,
                    Parent = cpframe
                })

                local cptitle = utility:Draw("Text", offsets[2], {
                    Font = 2,
                    Size = 13,
                    Color = c3rgb(255, 255, 255),
                    Outline = true,
                    Text = name,
                    Parent = parent
                })

                utility:Image(cpframe_gradient, "https://i.imgur.com/j9y4dux.png")

                if not do_update then
                    cptitle.Text = ""
                end 

                function colorpicker.Get(self)
                    return not self.trans and {self.value:ToHSV()} or {{self.value[1]:ToHSV()}, self.value[2]}
                end

                function colorpicker.SetOffset(self, offset)
                    cpframe.SetOffset(offset)
                end

                function colorpicker.Update(self)
                    cpframe.Color = self.trans and self.value[1] or self.value

                    if parent == section_frame then
                        self:SetOffset(v2new(parent.Size.X - 36, offsets[1].Y))
                    end
                end

                function colorpicker.Set(self, value)

                    self.value = not self.trans and c3hsv(unpack(value)) or {c3hsv(value[1][1], value[1][2], value[1][3]), value[2]}

                    if colorpicker.flag ~= nil then
                        library.flags[flag] = self.value
                    end

                    self:Update()

                    self.callback(self.value)
                end

                function colorpicker.Close(self)
                    if #self.instances > 0 then
                        for i, v in pairs(self.instances) do
                            v.Remove()
                        end

                        self.instances = {}

                        window.shit.colorpicker = nil
                    end
                end

                function colorpicker.Open(self)

                    window:HideUselessDumbassFuckingShitStopPastingMyCodePleaseYouAreSkidAndImGayILikeBigBlackManOkNoProblemThisIsASexcretFuncteiotieitns4epoivi2n45obvi6j45bv74gvho4hgv487()

                    local hsv = (self.trans and {self.value[1]:ToHSV()}) or {self.value:ToHSV()}

                    self.dvalues = {hsv[1], hsv[2], hsv[3], self.trans and self.value[2] or 0, false, false, false}

                    local cpdropframe = utility:Draw("Square", v2new(35, 0), {
                        Color = window.theme.dcont,
                        Group = "dcont",
                        Size = v2new(self.trans and 152 or 137, 120),
                        Parent = cpframe
                    })

                    local cpdropframe_outline = utility:Draw("Square", v2new(-1, -1), {
                        Color = window.theme.outline,
                        Group = "outline",
                        Size = cpdropframe.Size + v2new(2, 2),
                        Filled = false,
                        Parent = cpdropframe
                    })

                    local cpdropframe_accent = utility:Draw("Square", v2zero, {
                        Color = window.theme.accent,
                        Group = "accent",
                        Size = v2new(cpdropframe.Size.X, 1),
                        Parent = cpdropframe
                    })

                    local cpdropframe_color = utility:Draw("Square", v2new(10, 10), {
                        Color = c3hsv(self.dvalues[1], 1, 1),
                        Size = v2new(100, 100),
                        Parent = cpdropframe
                    })

                    local cpdropframe_color_outline = utility:Draw("Square", v2new(-1, -1), {
                        Color = window.theme.outline,
                        Group = "outline",
                        Size = cpdropframe_color.Size + v2new(2, 2),
                        Filled = false,
                        Parent = cpdropframe_color
                    })

                    local cpdropframe_color_image = utility:Draw("Image", v2zero, {
                        Size = cpdropframe_color.Size,
                        Parent = cpdropframe_color
                    })

                    local cpdropframe_color_cursor = utility:Draw("Square", v2new(math.clamp(self.dvalues[2]*100, 0, 97), math.clamp((1-self.dvalues[3])*100, 0, 97)), {
                        Color = c3rgb(255, 255, 255),
                        Size = v2new(3, 3),
                        Parent = cpdropframe_color
                    })

                    local cpdropframe_color_cursor_outline = utility:Draw("Square", v2new(-1, -1), {
                        Color = window.theme.outline,
                        Group = "outline",
                        Size = cpdropframe_color_cursor.Size + v2new(2, 2),
                        Filled = false,
                        Parent = cpdropframe_color_cursor
                    })

                    local cpdropframe_hue = utility:Draw("Square", v2new(120, 10), {
                        Color = window.theme.outline,
                        Group = "outline",
                        Size = v2new(7, 100),
                        Filled = false,
                        Parent = cpdropframe
                    })

                    local cpdropframe_hue_image = utility:Draw("Image", v2new(1, 1), {
                        Size = cpdropframe_hue.Size - v2new(2, 2),
                        Parent = cpdropframe_hue
                    })

                    local cpdropframe_hue_picker = utility:Draw("Square", v2new(0, math.clamp(math.floor(self.dvalues[1]*100), 0, 99)), {
                        Color = c3rgb(255, 255, 255),
                        Size = v2new(7, 1),
                        Parent = cpdropframe_hue
                    })

                    local cpdropframe_hue_picker_outline = utility:Draw("Square", v2new(-1, -1), {
                        Color = window.theme.outline,
                        Group = "outline",
                        Size = cpdropframe_hue_picker.Size + v2new(2, 2),
                        Filled = false,
                        Parent = cpdropframe_hue_picker
                    })

                    local cpdropframe_trans = utility:Draw("Square", v2new(137, 10), {
                        Color = window.theme.outline,
                        Group = "outline",
                        Size = v2new(7, 100),
                        Filled = false,
                        Parent = cpdropframe
                    })

                    local cpdropframe_trans_image = utility:Draw("Image", v2new(1, 1), {
                        Size = cpdropframe_trans.Size - v2new(2, 2),
                        Parent = cpdropframe_trans
                    })

                    local cpdropframe_trans_picker = utility:Draw("Square", v2new(0, math.clamp(math.floor(self.dvalues[4]*100), 0, 99)), {
                        Color = c3rgb(255, 255, 255),
                        Size = v2new(7, 1),
                        Parent = cpdropframe_trans
                    })

                    local cpdropframe_trans_picker_outline = utility:Draw("Square", v2new(-1, -1), {
                        Color = window.theme.outline,
                        Group = "outline",
                        Size = cpdropframe_trans_picker.Size + v2new(2, 2),
                        Filled = false,
                        Parent = cpdropframe_trans_picker
                    })

                    if not self.trans then
                        cpdropframe_trans.Visible = false
                        cpdropframe_trans_image.Visible = false
                        cpdropframe_trans_picker.Visible = false
                        cpdropframe_trans_picker_outline.Visible = false
                    end

                    utility:Image(cpdropframe_color_image, "https://i.imgur.com/wpDRqVH.png")
                    utility:Image(cpdropframe_hue_image, "https://i.imgur.com/iEOsHFv.png")
                    utility:Image(cpdropframe_trans_image, "https://i.imgur.com/GeMU2Ke.png")

                    self.instances = {cpdropframe, cpdropframe_outline, cpdropframe_accent, cpdropframe_color, cpdropframe_color_outline, cpdropframe_color_image,
                        cpdropframe_color_cursor, cpdropframe_color_cursor_outline, cpdropframe_hue, cpdropframe_hue_image, cpdropframe_hue_picker, cpdropframe_hue_picker_outline,
                        cpdropframe_trans, cpdropframe_trans_image, cpdropframe_trans_picker, cpdropframe_trans_picker_outline
                    }

                    window.shit.colorpicker = self
                end

                function colorpicker.Colorpicker(self, info)

                    self.doublecp = true

                    return section:_Colorpicker(info, {v2new(-35, 0) , v2zero}, cpframe, false, pointer .. "Colorpicker", cptable)
                end

                colorpicker:Set(colorpicker.trans and {{colorpicker.value:ToHSV()}, deftrans} or {colorpicker.value:ToHSV()})

                utility:Connect(uis.InputBegan, function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if main_frame.Visible and (tab.on or table.find(window.rna, section)) then 
                            if not window:FakeRealMouseFuckingImAloneGoingToKillMyselfWithKnife(section) and utility:MouseOverDrawing(cpframe) then
                                colorpicker:Open()
                            else
                                if #colorpicker.instances > 0 then
                                    if utility:MouseOverDrawing(colorpicker.instances[1]) then
                                        if utility:MouseOverDrawing(colorpicker.instances[4]) then
                                            local offset = uis:GetMouseLocation() - colorpicker.instances[4].Position

                                            local size = colorpicker.instances[4].Size

                                            local px, py = offset.X / size.X, offset.Y / size.Y

                                            px, py = math.clamp(px, 0, 1), math.clamp(py, 0, 1)

                                            local mno, mxo = v2zero, size - v2new(4, 4)

                                            local posx, posy =  math.floor(math.clamp(px * size.X, mno.X, mxo.X)), math.floor(math.clamp(py * size.Y, mno.Y, mxo.Y))

                                            colorpicker.instances[7].SetOffset(v2new(posx, posy))

                                            colorpicker.dvalues[2] = px
                                            colorpicker.dvalues[3] = 1-py

                                            colorpicker.dvalues[5] = true
                                        elseif utility:MouseOverDrawing(colorpicker.instances[9]) then
                                            local offset = uis:GetMouseLocation().Y - colorpicker.instances[9].Position.Y

                                            local size = colorpicker.instances[9].Size.Y

                                            local py = math.clamp(offset / size, 0, 1)

                                            colorpicker.instances[11].SetOffset(v2new(0, math.clamp(math.floor(py*size), 0, size-1)))

                                            colorpicker.instances[4].Color = c3hsv(py, 1, 1)

                                            colorpicker.dvalues[1] = py
                                            colorpicker.dvalues[6] = true
                                        elseif utility:MouseOverDrawing(colorpicker.instances[13]) and colorpicker.trans then
                                            local offset = uis:GetMouseLocation().Y - colorpicker.instances[13].Position.Y

                                            local size = colorpicker.instances[13].Size.Y

                                            local py = math.clamp(offset / size, 0, 1)

                                            colorpicker.instances[15].SetOffset(v2new(0, math.clamp(math.floor(py*size), 0, size-1)))

                                            colorpicker.dvalues[4] = py
                                            colorpicker.dvalues[7] = true
                                        end

                                        local dvalues = colorpicker.dvalues
                                        local color = c3hsv(dvalues[1], dvalues[2], dvalues[3])

                                        colorpicker:Set(colorpicker.trans and {{color:ToHSV()}, dvalues[4]} or {color:ToHSV()})
                                    else
                                        colorpicker:Close()
                                    end
                                else
                                    colorpicker:Close()
                                end
                            end
                        end
                    end
                end)

                utility:Connect(uis.InputChanged, function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement and #colorpicker.instances > 0 then
                        if main_frame.Visible and (tab.on or table.find(window.rna, section)) then
                            if colorpicker.dvalues[5] then
                                local mouse_pos = uis:GetMouseLocation()
                                local offset = mouse_pos - colorpicker.instances[4].Position

                                local size = colorpicker.instances[4].Size

                                local px, py = offset.X / size.X, offset.Y / size.Y

                                px, py = math.clamp(px, 0, 1), math.clamp(py, 0, 1)

                                local mno, mxo = v2zero, size - v2new(4, 4)

                                local posx, posy =  math.floor(math.clamp(px * size.X, mno.X, mxo.X)), math.floor(math.clamp(py * size.Y, mno.Y, mxo.Y))

                                colorpicker.dvalues[2] = px
                                colorpicker.dvalues[3] = 1-py

                                colorpicker.instances[7].SetOffset(v2new(posx, posy))
                            elseif colorpicker.dvalues[6] then
                                local offset = uis:GetMouseLocation().Y - colorpicker.instances[9].Position.Y

                                local size = colorpicker.instances[9].Size.Y

                                local py = math.clamp(offset / size, 0, 1)

                                colorpicker.instances[11].SetOffset(v2new(0, math.clamp(math.floor(py*size), 0, size-1)))

                                colorpicker.instances[4].Color = c3hsv(py, 1, 1)

                                colorpicker.dvalues[1] = py
                            elseif colorpicker.dvalues[7] then
                                local offset = uis:GetMouseLocation().Y - colorpicker.instances[13].Position.Y

                                local size = colorpicker.instances[13].Size.Y

                                local py = math.clamp(offset / size, 0, 1)

                                colorpicker.instances[15].SetOffset(v2new(0, math.clamp(math.floor(py*size), 0, size-1)))

                                colorpicker.dvalues[4] = py
                            end

                            local dvalues = colorpicker.dvalues
                            local color = c3hsv(dvalues[1], dvalues[2], dvalues[3])

                            colorpicker:Set(colorpicker.trans and {{color:ToHSV()}, dvalues[4]} or {color:ToHSV()})
                        end
                    end
                end)

                utility:Connect(uis.InputEnded, function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 and #colorpicker.instances > 0 then
                        if colorpicker.dvalues[5] then

                            local mouse_pos = uis:GetMouseLocation()
                            local offset = mouse_pos - colorpicker.instances[4].Position

                            local size = colorpicker.instances[4].Size

                            local px, py = offset.X / size.X, offset.Y / size.Y

                            px, py = math.clamp(px, 0, 1), math.clamp(py, 0, 1)

                            local mno, mxo = v2zero, size - v2new(4, 4)

                            local posx, posy =  math.floor(math.clamp(px * size.X, mno.X, mxo.X)), math.floor(math.clamp(py * size.Y, mno.Y, mxo.Y))

                            colorpicker.dvalues[2] = px
                            colorpicker.dvalues[3] = 1-py

                            colorpicker.instances[7].SetOffset(v2new(posx, posy))

                            colorpicker.dvalues[5] = false
                        elseif colorpicker.dvalues[6] then
                            local offset = uis:GetMouseLocation().Y - colorpicker.instances[9].Position.Y

                            local size = colorpicker.instances[9].Size.Y

                            local py = math.clamp(offset / size, 0, 1)

                            colorpicker.instances[11].SetOffset(v2new(0, math.clamp(math.floor(py*size), 0, size-1)))

                            colorpicker.instances[4].Color = c3hsv(py, 1, 1)

                            colorpicker.dvalues[1] = py
                            colorpicker.dvalues[6] = false
                        elseif colorpicker.dvalues[7] then
                            local offset = uis:GetMouseLocation().Y - colorpicker.instances[13].Position.Y

                            local size = colorpicker.instances[13].Size.Y

                            local py = math.clamp(offset / size, 0, 1)

                            colorpicker.instances[15].SetOffset(v2new(0, math.clamp(math.floor(py*size), 0, size-1)))

                            colorpicker.dvalues[4] = py
                            colorpicker.dvalues[7] = false
                        end

                        local dvalues = colorpicker.dvalues
                        local color = c3hsv(dvalues[1], dvalues[2], dvalues[3])

                        colorpicker:Set(colorpicker.trans and {{color:ToHSV()}, dvalues[4]} or {color:ToHSV()})
                    end
                end)

                self.instances = utility:Combine(self.instances, {cpframe, cptitle, cpframe_outline, cpframe_gradient})

                if do_update then
                    self:UpdateScale(13)
                end

                table.insert(self.things.colorpickers, colorpicker)

                return colorpicker
            end

            function section.Button(self, info)

                local name = info.name or "Button"
                local callback = info.callback or function() end
                
                local button = {name = name, callback = callback}

                local button_frame = utility:Draw("Square", v2new(6, self:NextObjectPosition()), {
                    Size = v2new(section_frame.Size.X - 12, 18),
                    Color = window.theme.lcont,
                    Group = "lcont",
                    Parent = section_frame
                })

                local button_outline = utility:Draw("Square", v2new(-1, -1), {
                    Size = button_frame.Size + v2new(2, 2),
                    Color = window.theme.outline,
                    Group = "outline",
                    Filled = false,
                    Parent = button_frame
                })

                local button_gradient = utility:Draw("Image", v2zero, {
                    Size = button_frame.Size,
                    Transparency = 0.35,
                    Parent = button_frame
                })

                local button_title = utility:Draw("Text", v2new(button_frame.Size.X / 2, 2), {
                    Font = 2,
                    Size = 13,
                    Color = Color3.new(1, 1, 1),
                    Outline = true,
                    Center = true,
                    Text = name,
                    Parent = button_frame
                })

                utility:Image(button_gradient, "https://i.imgur.com/j9y4dux.png")

                function button.Update(self)
                    button_frame.Size = v2new(section_frame.Size.X - 12, 18)
                    button_outline.Size = button_frame.Size + v2new(2, 2)
                    button_gradient.Size = button_frame.Size
                    button_title.SetOffset(v2new(button_frame.Size.X/2, 2))
                end

                utility:Connect(uis.InputBegan, function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 and main_frame.Visible and tab.on and not window:FakeRealMouseFuckingImAloneGoingToKillMyselfWithKnife(section) and utility:MouseOverPosition({section_frame.Position + v2new(0, button_frame.GetOffset().Y), section_frame.Position + v2new(section_frame.Size.X, button_frame.GetOffset().Y + 18)}) then
                        button.callback()
                    end
                end)

                self.instances = utility:Combine(self.instances, {button_frame, button_outline, button_title, button_gradient})

                self:UpdateScale(18)

                table.insert(self.things.buttons, button)

            end

            function section.Textbox(self, info)
                local name = info.name
                local def = info.default or info.def or ""
                local callback = info.callback or function() end
                local flag = info.flag
                local pointer = tab.name .. section.name .. name

                local textbox = {name = name, typing = false, value = def, callback = callback, flag = flag, pointer = pointer}

                if pointer then
                    library.pointers[pointer] = textbox
                end

                local textbox_frame = utility:Draw("Square", v2new(6, self:NextObjectPosition()), {
                    Size = v2new(section_frame.Size.X - 12, 18),
                    Color = window.theme.lcont,
                    Group = "lcont",
                    Parent = section_frame
                })

                local textbox_outline = utility:Draw("Square", v2new(-1, -1), {
                    Size = textbox_frame.Size + v2new(2, 2),
                    Color = window.theme.outline,
                    Group = "outline",
                    Filled = false,
                    Parent = textbox_frame
                })

                local textbox_gradient = utility:Draw("Image", v2zero, {
                    Size = textbox_frame.Size,
                    Transparency = 0.35,
                    Parent = textbox_frame
                })

                local textbox_title = utility:Draw("Text", v2new(4, 2), {
                    Font = 2,
                    Size = 13,
                    Color = c3rgb(255, 255, 255),
                    Outline = true,
                    Text = name,
                    Parent = textbox_frame
                })

                utility:Image(textbox_gradient, "https://i.imgur.com/j9y4dux.png")

                function textbox.Update(self)
                    textbox_frame.Size = v2new(section_frame.Size.X - 12, 18)
                    textbox_outline.Size = textbox_frame.Size + v2new(2, 2)
                    textbox_gradient.Size = textbox_frame.Size

                    local max = math.floor(textbox_frame.Size.X/7)-3

                    if self.value == "" then
                        textbox_title.Color = c3rgb(170, 170, 170)

                        local sub = self.name:sub(1, max)

                        textbox_title.Text = sub .. (#self.name > max and "..." or "")
                    else
                        textbox_title.Color = c3rgb(255, 255, 255)

                        local sub = self.value:sub(1, max)

                        textbox_title.Text = sub .. (#self.value > max and "..." or "")
                    end
                end

                function textbox.Get(self)
                    return self.value
                end

                function textbox.Start(self)
                    self.typing = true

                    window.shit.textbox = self
                end

                function textbox.Stop(self)
                    self.typing = false

                    window.shit.textbox = nil
                end

                function textbox.Set(self, value)
                    self.value = value

                    if self.flag then
                        library.flags[self.flag] = value
                    end

                    self:Update()
                end

                textbox:Set(textbox.value)

                utility:Connect(uis.InputBegan, function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 and main_frame.Visible and tab.on then
                        if not window:FakeRealMouseFuckingImAloneGoingToKillMyselfWithKnife(section) and utility:MouseOverPosition({section_frame.Position + v2new(0, textbox_frame.GetOffset().Y), section_frame.Position + v2new(section_frame.Size.X, textbox_frame.GetOffset().Y + 18)}) then
                            textbox:Start()
                        else
                            textbox:Stop()
                        end
                    elseif input.UserInputType == Enum.UserInputType.Keyboard and textbox.typing then
                        local keycode = input.KeyCode

                        local key_name = uis:GetStringForKeyCode(keycode):lower()

                        if uis:IsKeyDown("LeftShift") or uis:IsKeyDown("RightShift") then
                            key_name = utility:ShiftKey(key_name)
                        end

                        if keycode.Name ~= "Backspace" then
                            if key_name ~= "" then
                                textbox:Set(textbox.value .. key_name)
                            end
                        else
                            textbox:Set(textbox.value:sub(1, -2))
                        end
                    end
                end)

                self.instances = utility:Combine(self.instances, {textbox_frame, textbox_outline, textbox_gradient, textbox_title})

                self:UpdateScale(18)

                table.insert(self.things.textboxes, textbox)

                return textbox
            end

            function section.Toggle(self, info)
                
                local name = info.name or "toggle"
                local default = info.default or info.def or false
                local callback = info.callback or function() end
                local tooltip = info.tooltip or info.ttip or info.tt or ""
                local flag = info.flag
                local pointer = info.pointer or tab.name .. section.name .. name

                local toggle = {name = name, flag = flag, state = default, callback = callback, tt = tooltip, pointer = pointer}

                if toggle.pointer then
                    library.pointers[pointer] = toggle
                end

                local toggle_frame = utility:Draw("Square", v2new(6, self:NextObjectPosition() + 3), {
                    Size = v2new(8, 8),
                    Parent = section_frame
                })

                local toggle_outline = utility:Draw("Square", v2new(-1, -1), {
                    Size = toggle_frame.Size + v2new(2, 2),
                    Color = window.theme.outline,
                    Group = "outline",
                    Filled = false,
                    Parent = toggle_frame
                })

                local toggle_gradient = utility:Draw("Image", v2zero, {
                    Size = toggle_frame.Size,
                    Transparency = 0.35,
                    Parent = toggle_frame
                })

                local toggle_title = utility:Draw("Text", v2new(13, -3), {
                    Font = 2,
                    Size = 13,
                    Color = Color3.new(1, 1, 1),
                    Outline = true,
                    Text = name,
                    Parent = toggle_frame
                })

                utility:Image(toggle_gradient, "https://i.imgur.com/j9y4dux.png")

                function toggle.Get(self)
                    return self.state
                end

                function toggle.Update(self)
                    toggle_frame.Color = self.state and window.theme.accent or window.theme.lcont

                    if self.keybind then
                        self.keybind:SetOffset(v2new(section_frame.Size.X - (45+8), -1))
                    end

                    if self.fcp then
                        self.fcp:SetOffset(v2new(section_frame.Size.X - (35+8), -1))
                    end

                    if self.flag then
                        library.flags[self.flag] = self.state
                    end
                end

                function toggle.Set(self, state)
                    self.state = state

                    self:Update()

                    self.callback(self.state)
                end

                function toggle.Keybind(self, info)
                    info.name = self.name

                    self.keybind = section:_Keybind(info, {v2new(section_frame.Size.X - (45+8), -1), v2new()}, toggle_frame, false, tab.name .. section.name .. info.name .. "Keybind", section.name)
                    
                    self.kexs = true

                    return self.keybind
                end

                function toggle.Colorpicker(self, info)
                    info.name = self.name

                    self.cps = {}

                    self.fcp = section:_Colorpicker(info, {v2new(section_frame.Size.X - (35+8), -1), v2new()}, toggle_frame, false, tab.name .. section.name .. info.name .. "Colorpicker", self.cps)

                    return self.fcp
                end

                toggle:Set(default)

                utility:Connect(uis.InputBegan, function(input)
                    local offset = (toggle.kexs and section_frame.Size.X - 46) or (toggle.cps ~= nil and section_frame.Size.X - (1 + (#toggle.cps*35))) or section_frame.Size.X

                    if input.UserInputType == Enum.UserInputType.MouseButton1 and main_frame.Visible and (tab.on or table.find(window.rna, section)) and not window:FakeRealMouseFuckingImAloneGoingToKillMyselfWithKnife(section) and utility:MouseOverPosition({section_frame.Position + v2new(0, toggle_frame.GetOffset().Y), section_frame.Position + v2new(offset, toggle_frame.GetOffset().Y + 17)}) then
                        toggle:Set(not toggle.state)
                    end
                end)

                self.instances = utility:Combine(self.instances, {toggle_frame, toggle_outline, toggle_title, toggle_gradient})

                self:UpdateScale(13)

                table.insert(self.things.toggles, toggle)

                return toggle
            end

            function section.Slider(self, info)
                info = info or {}

                local name = info.name or "slider"
                local min = info.min or 1
                local max = info.max or 100
                local def = info.def or min
                local dec = info.dec or 1
                local suf = info.suf or ""
                local mintval = info.mintval or info.min_text_value
                local maxtval = info.maxtval or info.max_text_value
                local flag = info.flag or ""
                local callback = info.callback or function() end
                local pointer = info.pointer or tab.name .. section.name .. name

                local slider = {name = name, flag = flag, pointer = pointer, value = def, min = min, max = max, suf = suf, dec = dec, mintval = mintval, maxtval = maxtval, holding = false, callback = callback}

                if pointer then
                    library.pointers[pointer] = slider
                end

                local slider_title = utility:Draw("Text", v2new(6, self:NextObjectPosition() + 3), {
                    Color = c3rgb(255, 255, 255),
                    Outline = true,
                    Size = 13,
                    Font = 2,
                    Text = name,
                    Parent = section_frame
                })

                local slider_pm = utility:Draw("Text", v2new(section_frame.Size.X-33, 0), {
                    Color = c3rgb(255, 255, 255),
                    Outline = true,
                    Size = 13,
                    Font = 2,
                    Text = "- +",
                    Parent = slider_title
                })

                local slider_frame = utility:Draw("Square", v2new(0, 16), {
                    Size = v2new(section_frame.Size.X - 12, 10),
                    Color = window.theme.lcont,
                    Group = "lcont",
                    Parent = slider_title
                })

                local slider_outline = utility:Draw("Square", v2new(-1, -1), {
                    Size = slider_frame.Size + v2new(2, 2),
                    Color = window.theme.outline,
                    Group = "outline",
                    Filled = false,
                    Parent = slider_frame
                })

                local slider_bar = utility:Draw("Square", v2new(), {
                    Color = window.theme.accent,
                    Size = v2new(0, slider_frame.Size.Y),
                    Group = "accent",
                    Parent = slider_frame
                })

                local slider_gradient = utility:Draw("Image", v2new(), {
                    Size = slider_frame.Size,
                    Transparency = .75,
                    Parent = slider_frame
                })

                local slider_value = utility:Draw("Text", v2new(slider_frame.Size.X / 2, -2), {
                    Color = c3rgb(255, 255, 255),
                    Outline = true,
                    Size = 13,
                    Font = 2,
                    Text = tostring(def) .. "/" .. tostring(max) .. suf,
                    Center = true,
                    Parent = slider_frame
                })

                utility:Image(slider_gradient, "https://i.imgur.com/j9y4dux.png")

                function slider.Get(self)
                    return self.value
                end
                
                function slider.Update(self)
                    slider_frame.Size = v2new(section_frame.Size.X - 12, 10)
                    slider_outline.Size = slider_frame.Size + v2new(2, 2)
                    slider_gradient.Size = slider_frame.Size
                    slider_value.SetOffset(v2new(slider_frame.Size.X/2, -2))
                    slider_pm.SetOffset(v2new(section_frame.Size.X-33, 0))

                    slider_value.Text = self.mintval and self.value == self.min and self.mintval or self.maxtval and self.value == self.max and self.maxtval or ("%s%s"):format(tostring(self.value), tostring(slider.suf))

                    local percent = 1 - (self.max - self.value) / (self.max - self.min)

                    slider_bar.Size = v2new(percent * slider_frame.Size.X, slider_frame.Size.Y)

                    if self.flag then
                        library.flags[self.flag] = self.value
                    end
                end

                function slider.Set(self, value)
                    self.value = value

                    self:Update()

                    callback(self.value)
                end

                slider:Set(slider.value)

                utility:Connect(uis.InputBegan, function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 and main_frame.Visible and (tab.on or table.find(window.rna, section)) and not window:FakeRealMouseFuckingImAloneGoingToKillMyselfWithKnife(section) and utility:MouseOverPosition({section_frame.Position + v2new(0, slider_title.GetOffset().Y), section_frame.Position + v2new(section_frame.Size.X, slider_title.GetOffset().Y + 29)}) then
                        if utility:MouseOverPosition({section_frame.Position + v2new(section_frame.Size.X-27, slider_title.GetOffset().Y), section_frame.Position + v2new(section_frame.Size.X, slider_title.GetOffset().Y+14)}) then
                            local offset = uis:GetMouseLocation().X - slider_pm.Position.X
                            if offset < 15 then
                                slider:Set(math.clamp(math.floor((slider.value - (1 / slider.dec)) * slider.dec) / slider.dec, slider.min, slider.max))
                            elseif offset > 15 then
                                local value_fix = (slider.value + (1 / slider.dec))

                                if value_fix % (1 / slider.dec) ~= 0 then
                                    value_fix = math.round(value_fix * (slider.dec * 10)) / (slider.dec * 10)
                                end

                                slider:Set(math.clamp(math.floor(value_fix * slider.dec) / slider.dec, slider.min, slider.max))
                            end
                        else
                            slider.holding = true
                            local percent = math.clamp(uis:GetMouseLocation().X - slider_bar.Position.X, 0, slider_frame.Size.X) / slider_frame.Size.X
                            local value = math.floor((slider.min + (slider.max - slider.min) * percent) * slider.dec) / slider.dec
                            value = math.clamp(value, slider.min, slider.max)
                            slider:Set(value)
                        end
                    end
                end)

                utility:Connect(uis.InputChanged, function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement and slider.holding then
                        local percent = math.clamp(uis:GetMouseLocation().X - slider_bar.Position.X, 0, slider_frame.Size.X) / slider_frame.Size.X
                        local value = math.floor((slider.min + (slider.max - slider.min) * percent) * slider.dec) / slider.dec
                        value = math.clamp(value, slider.min, slider.max)
                        slider:Set(value)
                    end
                end)

                utility:Connect(uis.InputEnded, function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 and slider.holding then
                        slider.holding = false
                        local percent = math.clamp(uis:GetMouseLocation().X - slider_bar.Position.X, 0, slider_frame.Size.X) / slider_frame.Size.X
                        local value = math.floor((slider.min + (slider.max - slider.min) * percent) * slider.dec) / slider.dec
                        value = math.clamp(value, slider.min, slider.max)
                        slider:Set(value)
                    end
                end)

                slider.instances = {slider_title, slider_frame, slider_outline, slider_bar, slider_gradient, slider_value, slider_pm}

                self.instances = utility:Combine(self.instances, slider.instances)

                self:UpdateScale(28)

                table.insert(self.things.sliders, slider)

                return slider

            end

            function section.Dropdown(self, info)
                info = info or {}

                local name = info.name or "dropdown"
                local options = info.options or {"first", "second", "third"}
                local multi = info.multi or false
                local def = info.default or info.def or (not multi and options[1] or {options[1]})
                local minOptions = info.min or info.minOptions or 1
                local scrollable = info.scrollable or false
                local visOptions = (scrollable and info.vis) or #options
                local flag = info.flag or ""
                local pointer = tab.name .. section.name .. name
                local callback = info.callback or function() end

                local dropdown = {name = name, multi = multi, options = options, value = def, minOptions = minOptions, scrollable = scrollable, visOptions = visOptions, scrolling = {1, visOptions}, instances = {}, callback = callback, flag = flag, pointer = pointer}

                if pointer then
                    library.pointers[pointer] = dropdown
                end

                local dropdown_title = utility:Draw("Text", v2new(6, self:NextObjectPosition() + 3), {
                    Color = c3rgb(255, 255, 255),
                    Outline = true,
                    Size = 13,
                    Font = 2,
                    Text = name,
                    Parent = section_frame
                })

                local dropdown_frame = utility:Draw("Square", v2new(0, 17), {
                    Size = v2new(section_frame.Size.X - 12, 18),
                    Color = window.theme.lcont,
                    Group = "lcont",
                    Parent = dropdown_title
                })

                local dropdown_outline = utility:Draw("Square", v2new(-1, -1), {
                    Size = dropdown_frame.Size + v2new(2, 2),
                    Color = window.theme.outline,
                    Group = "outline",
                    Filled = false,
                    Parent = dropdown_frame
                })

                local dropdown_gradient = utility:Draw("Image", v2zero, {
                    Size = dropdown_frame.Size,
                    Transparency = 0.35,
                    Parent = dropdown_frame
                })

                local dropdown_value = utility:Draw("Text", v2new(4, 2), {
                    Color = c3rgb(255, 255, 255),
                    Outline = true,
                    Size = 13,
                    Font = 2,
                    Text = "shit vaLue",
                    Parent = dropdown_frame
                })

                local dropdown_image = utility:Draw("Image", v2new(dropdown_frame.Size.X - 14, 6), {
                    Size = v2new(9, 6),
                    Parent = dropdown_frame
                })

                utility:Image(dropdown_gradient, "https://i.imgur.com/j9y4dux.png")
                utility:Image(dropdown_image, "https://i.imgur.com/tVqy0nL.png")

                function dropdown.Get(self)
                    return self.value
                end

                function dropdown.Refresh(self, new)
                    self.options = new
                end

                function dropdown.Open(self)

                    self.scrolling[1] = 1
                    self.scrolling[2] = self.visOptions
                    
                    local list_frame = utility:Draw("Square", v2new(0, 19), {
                        Size = v2new(dropdown_frame.Size.X, 2+16*#self.options),
                        Color = window.theme.dcont,
                        Group = "dcont",
                        Parent = dropdown_frame
                    })

                    if self.scrollable and #self.options > self.visOptions then
                        list_frame.Size = v2new(dropdown_frame.Size.X, 2+16*self.visOptions)
                    end

                    local list_outline = utility:Draw("Square", v2new(-1, -1), {
                        Size = list_frame.Size + v2new(2, 2),
                        Color = window.theme.outline,
                        Group = "outline",
                        Filled = false,
                        Parent = list_frame
                    })

                    local list_scrollbar = utility:Draw("Square", v2new(list_frame.Size.X-3, 0), {
                        Size = v2new(3, list_frame.Size.Y/(#self.options - self.visOptions + 1)),
                        Color = window.theme.accent,
                        Group = "accent",
                        Parent = list_frame
                    })

                    if not self.scrollable or (self.scrollable and #self.options <= self.visOptions) then
                        list_scrollbar.Visible = false
                    end

                    self.instances = {list_frame, list_outline, list_scrollbar}

                    for i, v in pairs(self.options) do
                        local option_text = utility:Draw("Text", v2new(4, 2+16*(i-1)), {
                            Color = (multi and table.find(self.value, v) or not multi and self.value == v) and window.theme.accent or c3rgb(255, 255, 255),
                            Outline = true,
                            Size = 13,
                            Font = 2,
                            Text = tostring(v),
                            Parent = list_frame
                        })

                        if self.scrollable then
                            if i >= self.scrolling[1] and i <= self.scrolling[2] then
                                option_text.Visible = true
                            else
                                option_text.Visible = false
                            end
                        end

                        table.insert(self.instances, option_text)
                    end 

                    utility:Image(dropdown_image, "https://i.imgur.com/SL9cbQp.png")

                    window.shit.dropdown = dropdown
                    
                end

                function dropdown.Close(self)
                    for _, v in pairs(self.instances) do
                        v.Remove()
                    end

                    self.instances = {}

                    utility:Image(dropdown_image, "https://i.imgur.com/tVqy0nL.png")

                    window.shit.dropdown = nil
                end

                function dropdown.GenerateValueName(self)
                    if not self.multi then
                        local text_size = utility:GetPlexSize(self.value)

                        local max_size = dropdown_frame.Size.X - (4+16)

                        if text_size < max_size then
                            return self.value
                        else
                            return self.value:sub(1, 25) .. "..."
                        end
                    else
                        local text = ""

                        for i, v in pairs(self.value) do
                            if i ~= #self.value then
                                text = text .. v .. ", "
                            else
                                text = text .. v
                            end
                        end

                        local text_size = utility:GetPlexSize(text)

                        local max_size = dropdown_frame.Size.X - (4+16)

                        if text_size < max_size then
                            return text
                        else
                            return text:sub(1, 25) .. "..."
                        end
                    end
                end

                function dropdown.Update(self)
                    dropdown_frame.Size = v2new(section_frame.Size.X - 12, 18)
                    dropdown_outline.Size = dropdown_frame.Size + v2new(2, 2)
                    dropdown_gradient.Size = dropdown_frame.Size
                    dropdown_image.SetOffset(v2new(dropdown_frame.Size.X - 14, 6))

                    if #self.instances > 1 then
                        self.instances[1].Size = v2new(dropdown_frame.Size.X, self.instances[1].Size.Y)
                        self.instances[2].Size = self.instances[1].Size + v2new(2, 2)

                        for i, v in pairs({select(4, unpack(self.instances))}) do
                            if multi and table.find(self.value, v.Text) or not multi and self.value == v.Text then
                                v.Color = window.theme.accent
                            else
                                v.Color = c3rgb(255, 255, 255)
                            end

                            if self.scrollable then
                                if i >= self.scrolling[1] and i <= self.scrolling[2] then
                                    v.Visible = true

                                    v.SetOffset(v2new(4, 2+16*(i-self.scrolling[1]))) 
                                else
                                    v.Visible = false
                                end
                            end
                        end

                        local max_y_pos = self.instances[1].Size.Y - self.instances[3].Size.Y
                        
                        self.instances[3].SetOffset(v2new(self.instances[1].Size.X-self.instances[3].Size.X, max_y_pos * ((1/(#self.options-self.visOptions))*(self.scrolling[1]-1))))
                    end
                end

                function dropdown.Set(self, value)
                    self.value = value

                    dropdown_value.Text = self:GenerateValueName()

                    library.flags[flag] = self.value

                    self:Update()

                    self.callback(self.value)
                end

                dropdown:Set(dropdown.value)

                utility:Connect(uis.InputBegan, function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 and main_frame.Visible and (tab.on or table.find(window.rna, section)) then
                        if #dropdown.instances > 1 then
                            if utility:MouseOverDrawing(dropdown.instances[1]) then
                                local option_counter = (uis:GetMouseLocation().Y - (dropdown.instances[1].Position.Y+2))/16

                                if option_counter%1 ~= 0 then
                                    option_counter = math.floor(option_counter)+1
                                end

                                option_counter = option_counter > 0 and option_counter or 1

                                if dropdown.scrollable then
                                    option_counter = dropdown.scrolling[1] + option_counter - 1
                                end

                                if not dropdown.multi then
                                    dropdown:Set(dropdown.options[option_counter])
                                else
                                    local value = dropdown.options[option_counter]

                                    if table.find(dropdown.value, value) then
                                        if #dropdown.value > dropdown.minOptions then
                                            table.remove(dropdown.value, table.find(dropdown.value, value))
                                        end
                                    else
                                        table.insert(dropdown.value, value)
                                    end

                                    dropdown:Set(dropdown.value)
                                end
                            else
                                dropdown:Close()
                            end
                        else
                            if not window:FakeRealMouseFuckingImAloneGoingToKillMyselfWithKnife(section) and utility:MouseOverPosition({section_frame.Position + v2new(0, dropdown_title.GetOffset().Y), section_frame.Position + v2new(section_frame.Size.X, dropdown_title.GetOffset().Y + 35)}) then
                                dropdown:Open()
                            end
                        end
                    end
                end)

                utility:Connect(uis.InputChanged, function(input)
                    if input.UserInputType == Enum.UserInputType.MouseWheel and #dropdown.instances > 1 and utility:MouseOverDrawing(dropdown.instances[1]) and #dropdown.options > dropdown.visOptions then
                        local direction = input.Position.Z > 0 and "up" or "down"
                        
                        local min, max = dropdown.scrolling[1], dropdown.scrolling[2]

                        if direction == "up" then
                            dropdown.scrolling[1] = min ~= 1 and min - 1 or min
                            dropdown.scrolling[2] = min ~= 1 and max - 1 or max
                        else
                            dropdown.scrolling[1] = max ~= #dropdown.options and min + 1 or min
                            dropdown.scrolling[2] = max ~= #dropdown.options and max + 1 or max
                        end

                        dropdown:Update()
                    end
                end)

                self.instances = utility:Combine(self.instances, {dropdown_title, dropdown_frame, dropdown_outline, dropdown_gradient, dropdown_value, dropdown_image})
                
                self:UpdateScale(39)

                table.insert(self.things.dropdowns, dropdown)

                return dropdown
                
            end

            function section.Keybind(self, info)
                return self:_Keybind(info, {v2new(section_frame.Size.X - 46, self:NextObjectPosition() + 2), v2new(6, self:NextObjectPosition())}, section_frame, true, tab.name .. section.name .. info.name, section.name)
            end

            function section.Colorpicker(self, info)
                return self:_Colorpicker(info, {v2new(section_frame.Size.X - 36, self:NextObjectPosition() + 2), v2new(6, self:NextObjectPosition())}, section_frame, true, tab.name .. section.name .. info.name, {})
            end

            function section.List(self, info)
                info = info or {}

                local name = info.name or "list"
                local options = info.options or {"option 1", "option 2"}
                local def = info.def or info.default or options[1]
                local flag = info.flag
                local pointer = info.pointer or tab.name .. section.name .. name 

                local list = {name = name, value = def, scroll = {}, options = options, flag = flag, pointer = pointer, opinst = {}, lloop = nil}

                if pointer then
                    library.pointers[pointer] = list
                end

                local list_title = utility:Draw("Text", v2new(6, self:NextObjectPosition()-2), {
                    Color = c3rgb(255, 255, 255),
                    Outline = true,
                    Size = 13,
                    Font = 2,
                    Text = name,
                    Parent = section_frame
                })

                local list_frame = utility:Draw("Square", v2new(0, 15), {
                    Color = window.theme.dcont,
                    Group = "dcont",
                    Size = v2new(section_frame.Size.X - 12, 140),
                    Parent = list_title
                })

                local list_frame_outline = utility:Draw("Square", v2new(-1, -1), {
                    Color = window.theme.outline,
                    Group = "outline",
                    Size = list_frame.Size + v2new(2, 2),
                    Filled = false,
                    Parent = list_frame
                })

                local list_frame_scrollbar = utility:Draw("Square", v2new(list_frame.Size.X-3, 0), {
                    Color = window.theme.accent,
                    Group = "accent",
                    Size = v2new(3, 0),
                    Parent = list_frame
                })

                function list.fix_string(self, value)
                    local max_symbols = math.floor(list_frame.Size.X/7)

                    return #value < max_symbols and value or value:sub(1, max_symbols-3) .. "..."
                end

                function list.draw_options(self)
                    for i, v in pairs(self.opinst) do
                        v.Remove()
                    end

                    table.clear(self.opinst)

                    self.scroll = {1, 10}

                    for i, text in pairs(self.options) do

                        local list_option = utility:Draw("Text", v2new(3, (i-1)*14), {
                            Color = self.value == text and window.theme.accent or c3rgb(255, 255, 255),
                            Outline = true,
                            Size = 13,
                            Font = 2,
                            Text = self:fix_string(text),
                            Visible = i >= self.scroll[1] and i <= self.scroll[2],
                            Parent = list_frame
                        })

                        table.insert(self.opinst, list_option)

                    end

                    section.instances = utility:Combine(section.instances, {unpack(self.opinst)})

                    self:update()
                end

                function list.update(self)
                    list_frame.Size = v2new(section_frame.Size.X - 12, 140)
                    list_frame_outline.Size = list_frame.Size + v2new(2, 2)

                    for i, v in pairs(self.opinst) do
                        v.Visible = list_frame.Visible and i >= self.scroll[1] and i <= self.scroll[2]
                        if v.Visible then
                            v.Color = self.value == self.options[i] and window.theme.accent or c3rgb(255, 255, 255)
                            v.SetOffset(v2new(3, (i - self.scroll[1])*14))
                        end
                    end

                    list_frame_scrollbar.Visible = list_frame.Visible and #self.options > 10 and true or false
                    list_frame_scrollbar.Size = v2new(3, list_frame.Size.Y / (1 + #self.options - 10))

                    list_frame_scrollbar.SetOffset(v2new(list_frame.Size.X-3, ((1/(#self.options-10)*(self.scroll[1]-1)))*(list_frame.Size.Y-list_frame_scrollbar.Size.Y)))
                end

                function list.Refresh(self, new_options)
                    self.options = new_options

                    self:draw_options()
                end

                function list.Get(self)
                    return self.value
                end

                function list.Set(self, value)
                    self.value = value

                    if self.flag then
                        library.flags[flag] = self.value
                    end

                    self:update()
                end

                utility:Connect(uis.InputBegan, function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 and main_frame.Visible and (tab.on or table.find(window.rna, section)) and not window:FakeRealMouseFuckingImAloneGoingToKillMyselfWithKnife(section) and utility:MouseOverDrawing(list_frame) then
                        local offset = uis:GetMouseLocation().Y - list_frame.Position.Y

                        local option_index = math.clamp(offset/14, 1, 10)

                        if option_index % 1 ~= 0 then
                            option_index = math.floor(option_index) + 1
                        end

                        local index = list.scroll[1] - 1 + option_index

                        if list.options[index] then
                            list:Set(list.options[index])
                        end
                    end
                end)

                utility:Connect(uis.InputChanged, function(input)
                    if input.UserInputType == Enum.UserInputType.MouseWheel and main_frame.Visible and (tab.on or table.find(window.rna, section)) and not window:FakeRealMouseFuckingImAloneGoingToKillMyselfWithKnife(section) and utility:MouseOverDrawing(list_frame) then
                        local direction = input.Position.Z > 0 and "up" or "down"
                        
                        local min, max = list.scroll[1], list.scroll[2]

                        if direction == "up" then
                            list.scroll[1] = min ~= 1 and min - 1 or min
                            list.scroll[2] = min ~= 1 and max - 1 or max
                        else
                            list.scroll[1] = max ~= #list.options and min + 1 or min
                            list.scroll[2] = max ~= #list.options and max + 1 or max
                        end

                        list:update()
                    end
                end)

                list:draw_options()

                self.instances = utility:Combine(self.instances, {list_title, list_frame, list_frame_outline, list_frame_scrollbar})

                self:UpdateScale(153)

                table.insert(self.things.lists, list)

                return list
            end

            section.instances = {section_frame, section_inline, section_outline, section_title, section_title_bold, section_accent, section_accent2}

            if not section.rna then
                table.insert(self.sections, section)
                table.insert(self.sides[side == "left" and 1 or 2], section)
            end

            return section
        end

        if self.sshit == nil then
            self:SelectTab(name)
        end

        utility:Connect(uis.InputBegan, function(input)
            if main_frame.Visible and input.UserInputType == Enum.UserInputType.MouseButton1 and utility:MouseOverDrawing(tab_frame) then
                self:SelectTab(name)
            end
        end)

        return tab

    end

    function window.Update(self)
        for i, v in pairs(self.rna) do
            v:Update()
        end

        for i, v in pairs(self.tabs) do
            if v == window.sshit then
                v:Update()
            else
                v:UpdateColor()
            end
        end
    end

    function window.FakeRealMouseFuckingImAloneGoingToKillMyselfWithKnife(self, section)
        if self.shit.dropdown ~= nil and #self.shit.dropdown.instances > 1 then
            return utility:MouseOverDrawing(self.shit.dropdown.instances[1])
        elseif self.shit.keybind ~= nil and #self.shit.keybind.minst > 1 then
            return utility:MouseOverDrawing(self.shit.keybind.minst[1])
        elseif self.shit.colorpicker ~= nil and #self.shit.colorpicker.instances > 1 then
            return utility:MouseOverDrawing(self.shit.colorpicker.instances[1])
        end

        if not table.find(window.rna, section) then
            local on = false

            for i, v in pairs(window.rna) do
                if on then break end

                on = utility:MouseOverDrawing(v.instances[1])
            end

            return on
        end
        return false
    end

    function window.NewTheme(self, theme)
        self.theme = theme

        for i, _ in pairs(self.theme) do
            for _, obj in pairs(library.groups[i]) do
                obj.Color = self.theme[i]
            end
        end

        self:Update()
    end

    function window.SelectTab(self, name)

        if self.fading then return end

        for i, v in pairs(self.tabs) do
            if v.instances[3].Text == name then
                v:Show()
                v:Update()

                self.sshit = v
            else
                v:Hide()
            end
        end

        for _, v in pairs(self.connections["tab"] or {}) do
            v(name)
        end
    end

    function window.Resize(self, size)
        main_frame.Size = size
        main_frame_outline.Size = main_frame.Size + v2new(2, 2)
        main_frame_accent.Size = main_frame.Size + v2new(4, 4)

        pretab_frame.Size = size - v2new(12, 26)
        pretab_frame_inline.Size = pretab_frame.Size + v2new(2, 2)
        pretab_frame_outline.Size = pretab_frame.Size + v2new(4, 4)

        tabs_frame.Size = size - v2new(24, 55)
        tabs_frame_outline.Size = tabs_frame.Size + v2new(2, 2)

        self:Update()
    end

    function window.HideUselessDumbassFuckingShitStopPastingMyCodePleaseYouAreSkidAndImGayILikeBigBlackManOkNoProblemThisIsASexcretFuncteiotieitns4epoivi2n45obvi6j45bv74gvho4hgv487(self)
        if self.shit.dropdown then
            self.shit.dropdown:Close()
        elseif self.shit.textbox then
            self.shit.textbox:Stop()
        elseif self.shit.keybind then
            self.shit.keybind:Close()
        elseif self.shit.colorpicker then
            self.shit.colorpicker:Close()
        end
    end

    function window.GetFakeRealNoobConfigFunctionDontUseMe(self)
        local new_table = {}

        for i, v in pairs(library.pointers) do
            new_table[i] = v:Get()
        end

        new_table["animation_saved"] = self.saved_settings

        return game:GetService("HttpService"):JSONEncode(new_table)
    end

    function window.BestFunctionToKillMyselfFurryGayPornFemboyDildoMasterAloneWolfMode(self, IHATEMYSELFFUCKINGIWANTTODIEIMUSELESSINTHISLIFENOBODYLIKESME)
        for USELESSNAMEFORNONAMERIHATEMYSELF, SHITTYVALUEFORNOBODYCAUSEIMALONEIMSODUMBFUCKINGUSELESS in pairs(IHATEMYSELFFUCKINGIWANTTODIEIMUSELESSINTHISLIFENOBODYLIKESME) do
            if library.pointers[USELESSNAMEFORNONAMERIHATEMYSELF] then
                library.pointers[USELESSNAMEFORNONAMERIHATEMYSELF]:Set(SHITTYVALUEFORNOBODYCAUSEIMALONEIMSODUMBFUCKINGUSELESS)
            end
        end

        self.saved_settings = IHATEMYSELFFUCKINGIWANTTODIEIMUSELESSINTHISLIFENOBODYLIKESME["animation_saved"] or {}
    end

    function window.SetSecretFunctionNameNotWindowNameClickGrabifyPNEK8UPleaseBotlagArgyyyHaxx(self, newsecretpropertyname)
        main_frame_title.Text = newsecretpropertyname 
    end

    function window.Fade(self)
        if self.fading then return end

        for i, v in pairs(self.connections["fade"] or {}) do
            v(not main_frame.Visible)
        end

        local fade_instances = utility:Combine(library.fade_instances, {
            main_frame, main_frame_accent, main_frame_title, main_frame_outline,
            pretab_frame, pretab_frame_inline, pretab_frame_outline,
            tabs_frame, tab_frame_accent, tabs_frame_outline
        })

        if self.cursor then
            fade_instances = utility:Combine(fade_instances, self.cursor.instances)
        end

        for i, v in pairs(self.tabs) do
            fade_instances = utility:Combine(fade_instances, v.instances)
        end

        for i, v in pairs(self.rna) do
            fade_instances = utility:Combine(fade_instances, v.instances)
        end

        if self.sshit then
            for _, s in pairs(self.sshit.sections) do
                fade_instances = utility:Combine(fade_instances, s.instances)
            end
        end

        if main_frame.Visible then
            self.fading = true

            if self.tooltip then
                self.tooltip:SetPosition(v2new(-1000, -1000))
            end

            for i, v in pairs(fade_instances) do
                v.Lerp({Transparency = 0}, 0.2)

                task.delay(0.2, function()
                    v.Visible = false

                    self.fading = false
                end)
            end

            uis.MouseIconEnabled = true
        else
            self.fading = true

            for i, v in pairs(fade_instances) do
                v.Visible = true
                v.Transparency = 0

                v.Lerp({Transparency = v:getDefaultTransparency()}, 0.2)
            end

            task.delay(0.2, function()
                self.fading = false
            end)

            local from = tick()

            uis.MouseIconEnabled = false
        end

        self:Update()

        self:HideUselessDumbassFuckingShitStopPastingMyCodePleaseYouAreSkidAndImGayILikeBigBlackManOkNoProblemThisIsASexcretFuncteiotieitns4epoivi2n45obvi6j45bv74gvho4hgv487()
    end

    function window.Notifications(self)

        local notiflist = {ntifs = {}, interval = 7}

        function notiflist.new(self, info)

            info = info or {}

            local text = info.text or "notification"
            local dur = info.dur or info.duration or 3
            local show_dur_bar = info.show_dur_bar or info.sdb or true
            local pulse = info.pulse or false
            local pulse_color = info.pulsecolor or info.pulse_color or info.pc or {c3rgb(0, 0, 0), c3rgb(194, 164, 16)}
            local text_highlight = info.th or info.text_highlight or {}

            local ntif = {text = text, dur = dur, pulse = pulse, pc = pulse_color, pm = 1, ptick = 0, create_tick = tick(), sdb = show_dur_bar, instances = {}}

            local ntif_frame = utility:Draw("Square", nil, {
                Color = window.theme.lcont,
                Group = "lcont",
                Size = v2new(7 + utility:GetPlexSize(text), 4 + (#text:split("\n")*13)),
                Position = v2new(-utility:GetPlexSize(text), 0)
            }, true)

            if #text:split("\n") > 1 then
                local max = 0
                for i, v in pairs(text:split("\n")) do
                    if utility:GetPlexSize(v) > max then
                        max = utility:GetPlexSize(v)
                    end
                end

                ntif_frame.Size = v2new(5 + max, ntif_frame.Size.Y)
                ntif_frame.Position = v2new(-max, 0)
            end

            local ntif_frame_outline = utility:Draw("Square", v2new(-1, -1), {
                Color = window.theme.outline,
                Group = "outline",
                Size = ntif_frame.Size + v2new(2, 2),
                Filled = false,
                Parent = ntif_frame
            }, true)

            local ntif_text = utility:Draw("Text", v2new(5, 2), {
                Color = c3rgb(255, 255, 255),
                Outline = true,
                Size = 13,
                Font = 2,
                Text = ntif.text,
                Parent = ntif_frame
            }, true)

            local ntif_dur_line = utility:Draw("Square", v2new(0, ntif_frame.Size.Y), {
                Color = window.theme.accent,
                Group = "accent",
                Size = v2new(ntif_frame.Size.X / 5, 1),
                Visible = ntif.sdb,
                Parent = ntif_frame
            }, true)

            local ntif_accent = utility:Draw("Square", v2zero, {
                Size = v2new(2, ntif_frame.Size.Y),
                Color = not ntif.pulse and window.theme.accent or ntif.pc[1],
                Group = "accent",
                Parent = ntif_frame
            }, true)

            local highligted = {}

            for _, v in pairs(text_highlight) do
                local s, e = ntif.text:find(v[1])

                if s and e then
                    local ntif_high = utility:Draw("Text", v2new((s-1)*7, 0), {
                        Color = v[2],
                        Outline = true,
                        Size = 13,
                        Font = 2,
                        Text = ntif.text:sub(s, e),
                        Parent = ntif_text
                    }, true)
    
                    table.insert(highligted, ntif_high)
                end
            end

            ntif.lupapupa = utility:Connect(rs.Heartbeat, function()
                if ntif.sdb then
                    ntif_dur_line.SetOffset(v2new(((tick()-ntif.create_tick) / ntif.dur) * (ntif_frame.Size.X * 0.8), ntif_frame.Size.Y))
                end

                if ntif.pulse then
                    if tick()-ntif.ptick > 0.5 then
                        ntif.ptick = tick()

                        if ntif.pm == 1 then
                            ntif.pm = 2

                            ntif_accent.Lerp({Color = ntif.pc[ntif.pm]}, 0.5)
                        else
                            ntif.pm = 1

                            ntif_accent.Lerp({Color = ntif.pc[ntif.pm]}, 0.5)
                        end
                    end
                end

                if tick()-ntif.create_tick > ntif.dur - 0.2 and not ntif.did_set then
                    ntif.did_set = true

                    ntif:idontlikemylifesucidepleasesomebodykillme()
                end
            end)

            function ntif.idontlikemylifesucidepleasesomebodykillme(self)
                for i, v in pairs(self.instances) do
                    v.Lerp({Transparency = 0}, 0.2)
                end

                task.wait(0.2)

                for i, v in pairs(self.instances) do
                    v.Remove()
                end

                if self.lupapupa then
                    self.lupapupa:Disconnect()
                end

                table.remove(notiflist.ntifs, table.find(notiflist.ntifs, ntif))

                notiflist:reposition()
            end

            ntif.instances = {ntif_frame, ntif_frame_outline, ntif_text, ntif_dur_line, ntif_accent, unpack(highligted)}

            table.insert(self.ntifs, ntif)

            self:reposition()
            
        end

        function notiflist.reposition(self)
            local position_to_go = 60 + self.interval
            for i, v in pairs(self.ntifs) do
                local position = v2new(19, position_to_go)

                local lerp_table = {Position = position}

                if v.instances[1].Position.X < 0 then
                    v.instances[1].Position = position + v2new(-4, 7)

                    for i, v in pairs(v.instances) do
                        v.Transparency = 0
                        
                        if i == 1 then
                            lerp_table.Transparency = 1
                        else
                            v.Lerp({Transparency = 1}, 0.1, false)
                        end
                    end
                end

                v.instances[1].Lerp(lerp_table, 0.1, false)

                position_to_go = position_to_go + v.instances[1].Size.Y + self.interval
            end

        end

        self.ntiflist = notiflist
    end

    function window.Keybinds(self)

        local kblist = {visible = false, instances = {}}

        local kblist_frame = utility:Draw("Square", v2zero, {
            Color = window.theme.lcont,
            Group = "lcont",
            Size = v2new()
        }, true)

        local kblist_outline = utility:Draw("Square", v2new(-1, -1), {
            Color = window.theme.outline,
            Group = "outline",
            Size = kblist_frame.Size + v2new(2, 2),
            Filled = false,
            Parent = kblist_frame
        }, true)

        local kblist_accent = utility:Draw("Square", v2zero, {
            Color = window.theme.accent,
            Size = v2new(kblist_frame.Size.X, 1),
            Group = "accent",
            Parent = kblist_frame
        }, true)

        local kblist_title = utility:Draw("Text", v2new(3, 3), {
            Color = c3rgb(255, 255, 255),
            Outline = true,
            Size = 13,
            Font = 2,
            Text = "keybinds",
            Parent = kblist_frame
        }, true)

        local kblist_value = utility:Draw("Text", v2new(3, 17), {
            Color = c3rgb(255, 255, 255),
            Outline = true,
            Size = 13,
            Font = 2,
            Text = "",
            Parent = kblist_frame
        }, true)

        function kblist.Update(self)
            local kbds_string = ""
            local max_len = 56

            for i, v in pairs(window.kbds) do
                local keybind = library.pointers[v]

                local string_add = ("[%s] %s: %s\n"):format(keybind.instances[5].Text, keybind.sname, keybind.name)

                if utility:GetPlexSize(string_add) > max_len then
                    max_len = utility:GetPlexSize(string_add)
                end

                kbds_string = kbds_string .. string_add
            end

            kblist_frame.Size = v2new(6 + max_len, 20 + ((#kbds_string:split("\n")-1)*13))
            kblist_outline.Size = kblist_frame.Size + v2new(2, 2)
            kblist_accent.Size = v2new(kblist_frame.Size.X, 1)
            kblist_value.Text = kbds_string
        end

        function kblist.AdjustFuckingUselessShitNamedPositionIWantToDie(self, pos)
            kblist_frame.Position = pos
        end

        function kblist.ShowHideFromMyLifePleaseSomebodyKillMeIDontWantToBeAliveRightNowImUselessInMyLife(self, visible)
            for i, v in pairs(self.instances) do
                v.Visible = visible
            end
        end

        kblist.instances = {kblist_frame, kblist_outline, kblist_accent, kblist_title, kblist_value}

        kblist:Update()
        kblist:AdjustFuckingUselessShitNamedPositionIWantToDie(v2new(20, math.floor(utility:ScreenSize().Y/2)))
        kblist:ShowHideFromMyLifePleaseSomebodyKillMeIDontWantToBeAliveRightNowImUselessInMyLife(false)

        self.kblist = kblist

    end

    function window.Watermark(self)

        local watermark = {text = "worsst fucking ui without doxxs", visible = false, instances = {}}

        local watermark_frame = utility:Draw("Square", v2zero, {
            Color = window.theme.lcont,
            Group = "lcont",
            Size = v2new(0, 20),
        }, true)

        local watermark_inline = utility:Draw("Square", v2new(-1, -1), {
            Color = window.theme.dcont,
            Group = "dcont",
            Size = watermark_frame.Size + v2new(2, 2),
            Filled = false,
            Parent = watermark_frame
        }, true)

        local watermark_outline = utility:Draw("Square", v2new(-2, -2), {
            Color = window.theme.outline,
            Group = "outline",
            Size = watermark_frame.Size + v2new(4, 4),
            Filled = false,
            Parent = watermark_frame
        }, true)

        local watermark_accent = utility:Draw("Square", v2new(), {
            Color = window.theme.accent,
            Size = v2new(watermark_frame.Size.X, 1),
            Group = "accent",
            Parent = watermark_frame
        }, true)

        local watermark_gradient = utility:Draw("Image", v2new(0, 1), {
            Size = watermark_frame.Size - v2new(0, 1),
            Transparency = 0.35,
            Parent = watermark_frame
        }, true)

        local watermark_title = utility:Draw("Text", v2new(3, 4), {
            Color = c3rgb(255, 255, 255),
            Outline = true,
            Size = 13,
            Font = 2,
            Text = watermark.text,
            Parent = watermark_frame
        }, true)

        utility:Image(watermark_gradient, "https://i.imgur.com/j9y4dux.png")

        watermark.instances = {watermark_frame, watermark_inline, watermark_outline, watermark_accent, watermark_gradient, watermark_title}

        function watermark.Update(self)
            local bounds = utility:GetPlexSize(self.text)

            watermark_frame.Size = v2new(6 + bounds, 20)
            watermark_inline.Size = watermark_frame.Size + v2new(2, 2)
            watermark_outline.Size = watermark_inline.Size + v2new(2, 2)
            watermark_accent.Size = v2new(watermark_frame.Size.X, 1)
            watermark_gradient.Size = watermark_frame.Size - v2new(0, 1)

            watermark_frame.Position = v2new(20, 40)
        end

        function watermark.SetVisible(self, value)
            self.visible = value

            for i, v in pairs(self.instances) do
                v.Visible = self.visible
            end
        end

        function watermark.SetText(self, value)
            self.text = value
        end

        utility:Connect(rs.RenderStepped, function()
            watermark:Update()

            watermark_title.Text = watermark.text
        end)

        watermark:SetVisible(false)

        self.watermark = watermark

    end

    function window.Tooltip(self)
        
        local tooltip = {instances = {}}

        local tt_frame = utility:Draw("Square", nil, {
            Color = self.theme.dcont,
            Group = "dcont",
            Size = v2new(0, 17)
        })

        local tt_frame_outline = utility:Draw("Square", v2new(-1, -1), {
            Color = self.theme.outline,
            Group = "outline",
            Size = tt_frame.Size + v2new(2, 2),
            Filled = false,
            Parent = tt_frame
        })

        local tt_accent = utility:Draw("Square", v2zero, {
            Color = self.theme.accent,
            Size = v2new(2, tt_frame.Size.Y),
            Group = "accent",
            Parent = tt_frame
        })

        local tt_text = utility:Draw("Text", v2new(5, 2), {
            Color = c3rgb(255, 255, 255),
            Outline = true,
            Size = 13,
            Font = 2,
            Text = "",
            Parent = tt_frame
        })

        tooltip.instances = {tt_frame, tt_frame_outline, tt_accent, tt_text}

        function tooltip.SetText(self, text)
            for i, v in pairs(self.instances) do
                v.Visible = true
            end

            tt_text.Text = text

            tt_frame.Size = v2new(7 + utility:GetPlexSize(text), 4 + (#text:split("\n")*13))

            if #text:split("\n") > 1 then
                local max = 0
                for i, v in pairs(text:split("\n")) do
                    if utility:GetPlexSize(v) > max then
                        max = utility:GetPlexSize(v)
                    end
                end

                tt_frame.Size = v2new(5 + max, tt_frame.Size.Y)
            end

            tt_frame_outline.Size = tt_frame.Size + v2new(2, 2)
            tt_accent.Size = v2new(2, tt_frame.Size.Y)
        end

        function tooltip.SetPosition(self, pos)
            tt_frame.Position = pos
        end

        tooltip:SetPosition(v2new(-1000, -1000))
        
        self.tooltip = tooltip

    end

    function window.Cursor(self)

        local cursor = {position = v2zero, instances = {}}

        local triangle = utility:Draw("Triangle", v2zero, {
            Color = window.theme.accent,
            Group = "accent",
            Filled = true,
            Thickness = 0,
            ZIndex = 65
        })

        local triangle_outline = utility:Draw("Triangle", v2zero, {
            Color = window.theme.outline,
            Group = "outline",
            Filled = false,
            Thickness = 1,
            ZIndex = 66
        })

        function cursor.Update(self)
            triangle.PointA = self.position 
            triangle.PointB = self.position + v2new(10, 4)
            triangle.PointC = self.position + v2new(4, 10)

            triangle_outline.PointA = triangle.PointA
            triangle_outline.PointB = triangle.PointB
            triangle_outline.PointC = triangle.PointC
        end

        function cursor.Set(self, value)
            self.position = value

            self:Update()
        end

        utility:Connect(rs.RenderStepped, function()
            if window.frame.Visible then
                cursor:Set(uis:GetMouseLocation())
            end
        end)

        cursor.instances = {triangle, triangle_outline}

        window.cursor = cursor
    end

    function window.Init(self)

        for _, tab in pairs(self.tabs) do
            tab:Update()
        end

        if #self.tabs > 0 then
            self.saved_settings = {}

            local slider_section = self.tabs[1]:Section({name = "Animation", rna = true})
            local anim_enabled = slider_section:Toggle({name = "Enabled", pointer = ""})
            local anim_speed = slider_section:Slider({name = "Speed", min = 0.1, def = 1, max = 15, dec = 10, pointer = ""})
            local anim_min = slider_section:Slider({name = "Minimum value", min = 1, max = 2, pointer = ""})
            local anim_max = slider_section:Slider({name = "Maximum value", min = 1, max = 2, pointer = ""})

            slider_section:Update()
            slider_section:SetPositionIHateMyselfAndIWannaDieOk(v2new(-1000, -1000))

            local slider_flag = nil

            utility:Connect(uis.InputBegan, function(input)
                if self.frame.Visible and not window:FakeRealMouseFuckingImAloneGoingToKillMyselfWithKnife(slider_section) then
                    if input.UserInputType == Enum.UserInputType.MouseButton2 then
                        local slider_visible = false

                        for _, section in pairs(window.sshit.sections) do
                            if slider_visible then break end
                            for _, slider in pairs(section.things.sliders) do
                                if slider_visible then break end

                                local section_frame = section.instances[1]
                                local slider_title = slider.instances[1]

                                if utility:MouseOverPosition({section_frame.Position + v2new(0, slider_title.GetOffset().Y), section_frame.Position + v2new(section_frame.Size.X, slider_title.GetOffset().Y + 29)}) then
                                    slider_visible = true

                                    slider_section:SetPositionIHateMyselfAndIWannaDieOk(slider_title.Position + v2new(2, 2))

                                    anim_min.min = slider.min
                                    anim_min.max = slider.max
                                    anim_min.dec = slider.dec

                                    anim_max.min = slider.min
                                    anim_max.max = slider.max
                                    anim_max.dec = slider.dec

                                    slider_flag = slider.pointer

                                    if self.saved_settings[slider.pointer] then
                                        local settings = self.saved_settings[slider.pointer]

                                        anim_enabled:Set(settings.enabled)
                                        anim_min:Set(settings.min)
                                        anim_max:Set(settings.max)
                                        anim_speed:Set(settings.speed)
                                    else
                                        anim_enabled:Set(false)
                                        anim_min:Set(slider.min)
                                        anim_max:Set(slider.max)
                                        anim_speed:Set(1)

                                        self.saved_settings[slider.pointer] = {
                                            enabled = false,
                                            min = slider.min,
                                            max = slider.max,
                                            speed = 1,
                                            dec = slider.dec,
                                            random_angle_offset = math.random(-720, 720)
                                        }
                                    end
                                end
                            end
                        end

                        if not slider_visible then
                            slider_section:SetPositionIHateMyselfAndIWannaDieOk(v2new(-1000, -1000))

                            slider_flag = nil
                        end
                    elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if not utility:MouseOverDrawing(slider_section.instances[1]) then
                            slider_section:SetPositionIHateMyselfAndIWannaDieOk(v2new(-1000, -1000))

                            slider_flag = nil
                        end
                    end
                else
                    slider_section:SetPositionIHateMyselfAndIWannaDieOk(v2new(-1000, -1000))

                    slider_flag = nil
                end
                
            end)

            utility:Connect(rs.Heartbeat, function()
                if slider_flag ~= nil then
                    self.saved_settings[slider_flag] = {
                        enabled = anim_enabled:Get(),
                        min = anim_min:Get(),
                        max = anim_max:Get(),
                        speed = anim_speed:Get(),
                        dec = library.pointers[slider_flag].dec,
                        random_angle_offset = self.saved_settings[slider_flag].random_angle_offset
                    }
                end

                for i, v in pairs(self.saved_settings) do
                    if v.enabled then
                        local sin_tick = 1 + math.sin(math.rad((tick()*50*v.speed)) + math.rad(v.random_angle_offset))

                        if tostring(sin_tick):sub(1, 4) == "1.99" then
                            sin_tick = 2
                        end

                        library.pointers[i]:Set(math.clamp(math.floor((v.min + (((v.max - v.min)/2) * sin_tick)) * v.dec) / v.dec, v.min, v.max))
                    end
                end
            end)
        end

        self:Watermark()
        self:Notifications()
        self:Tooltip()
        self:Keybinds()
        self:Cursor()

        self:Fade()

        task.wait(0.2)

        self:SelectTab(self.sshit.name)

        library.loaded = true

        function self.Unload(self)
            for i, v in pairs(utility:Combine(library.drawings[1], library.drawings[2])) do
                v[1]:Remove()
            end

            for i, v in pairs(library.connections) do
                v:Disconnect()
            end

            for i, v in pairs(self.connections["unload"] or {}) do
                v()
            end

            library.loaded = false
        end
    end

    function window.Connect(self, info)
        info = info or {}

        local connection = info.con or "tab"
        local callback = info.callback or function() end

        if not self.connections[connection] then
            self.connections[connection] = {}
        end

        table.insert(self.connections[connection], callback)
    end

    return window
end

return library, utility
