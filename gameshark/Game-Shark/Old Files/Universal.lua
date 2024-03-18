return nil

repeat wait() until Utility and Library and ESP

local Players = game.Players
local LocalPlayer = Players.LocalPlayer
local NewRGB = Color3.fromRGB
local NewHSV = Color3.fromHSV
local NewInst = Instance.new
local NewVector = Vector2.new
local NewUdim2 = UDim2.new
local DrawObj = Drawing.new

print("[Game-Shark]: Universal Loaded.")

local Window = Library:Menu()

local Visuals = Window:Tab(Library.Images.Sun)
local Settings = Window:Tab(Library.Images.Folder)

local PlayersSection = Visuals:MultiSection({ScaleSize = 1}) do
    for i,v in pairs({"Enemy", "Team", "Self"}) do
        local SectionHolder = PlayersSection:Tab(v) do
            local Section = ESP[v]
    
            SectionHolder:Toggle({Name = "Enabled", Flag = ("ESP %s Enabled"):format(v), Callback = function(v)
                Section.Enabled = v
            end})
            SectionHolder:Toggle({Name = "Bounding Box", Flag = ("ESP %s Box Enabled"):format(v), Callback = function(v)
                Section.Box.Enabled = v
            end}):ColorPicker({Default = NewRGB(255, 255, 255), Flag = ("ESP %s Box Color"):format(v), Transparency = 1, Callback = function(v)
                Section.Box.Color = Utility:FromRGBA(v[1].R * 255, v[1].G * 255, v[1].B * 255, v[2])
                Section.Box.Outline = Utility:FromRGBA(0, 0, 0, v[2] - 0.5)
            end})   
            SectionHolder:Toggle({Name = "Bounding Box Fill", Flag = ("ESP %s Box Fill Enabled"):format(v), Callback = function(v)
                local Color = Library.Flags["ESP %s Box Fill Color"] or {NewRGB(255, 255, 255), 0}
                Section.Box.Fill = Utility:FromRGBA(Color[1].R * 255, Color[1].G * 255, Color[1].B * 255, v and Color[2] or 0)
            end}):ColorPicker({Default = NewRGB(255, 255, 255), Flag = ("ESP %s Box Fill Color"):format(v), Transparency = 0, Callback = function(v)
                Section.Box.Fill = Utility:FromRGBA(v[1].R * 255, v[1].G * 255, v[1].B * 255, v[2])
            end})
            SectionHolder:Toggle({Name = "Name", Flag = ("ESP %s Name Enabled"):format(v), Callback = function(v)
                Section.Name.Enabled = v
            end}):ColorPicker({Default = NewRGB(255, 255, 255), Flag = ("ESP %s Name Color"):format(v), Transparency = 1, Callback = function(v)
                Section.Name.Color = Utility:FromRGBA(v[1].R * 255, v[1].G * 255, v[1].B * 255, v[2])
            end})
            local HealthBar = SectionHolder:Toggle({Name = "Health Bar", Flag = ("ESP %s Health Bar Enabled"):format(v), Callback = function(v)
                Section.HealthBar.Enabled = v
            end})
            HealthBar:ColorPicker({Default = NewRGB(255, 0, 0), Flag = ("ESP %s Health Bar High Color"):format(v), Transparency = 1, Callback = function(v)
                Section.HealthBar.HighColor = Utility:FromRGBA(v[1].R * 255, v[1].G * 255, v[1].B * 255, v[2])
            end})
            HealthBar:ColorPicker({Default = NewRGB(0, 255, 0), Flag = ("ESP %s Health Bar Low Color"):format(v), Transparency = 1, Callback = function(v)
                Section.HealthBar.LowColor = Utility:FromRGBA(v[1].R * 255, v[1].G * 255, v[1].B * 255, v[2])
            end})
            SectionHolder:Toggle({Name = "Health Number", Flag = ("ESP %s Health Number Enabled"):format(v), Callback = function(v)
                Section.Health.Enabled = v
            end}):ColorPicker({Default = NewRGB(255, 255, 255), Flag = ("ESP %s Health Number Color"):format(v), Transparency = 1, Callback = function(v)
                Section.Health.Color = Utility:FromRGBA(v[1].R * 255, v[1].G * 255, v[1].B * 255, v[2])
            end})
            SectionHolder:Toggle({Name = "Tool", Flag = ("ESP %s Tool Enabled"):format(v), Callback = function(v)
                Section.Tool.Enabled = v
            end}):ColorPicker({Default = NewRGB(255, 255, 255), Flag = ("ESP %s Tool Color"):format(v), Transparency = 1, Callback = function(v)
                Section.Tool.Color = Utility:FromRGBA(v[1].R * 255, v[1].G * 255, v[1].B * 255, v[2])
            end})
            SectionHolder:Toggle({Name = "Distance", Flag = ("ESP %s Distance Enabled"):format(v), Callback = function(v)
                Section.Distance.Enabled = v
            end}):ColorPicker({Default = NewRGB(255, 255, 255), Flag = ("ESP %s Distance Color"):format(v), Transparency = 1, Callback = function(v)
                Section.Distance.Color = Utility:FromRGBA(v[1].R * 255, v[1].G * 255, v[1].B * 255, v[2])
            end})
            SectionHolder:Toggle({Name = "Team", Flag = ("ESP %s Team Enabled"):format(v), Callback = function(v)
                Section.Team.Enabled = v
            end}):ColorPicker({Default = NewRGB(255, 255, 255), Flag = ("ESP %s Team Color"):format(v), Transparency = 1, Callback = function(v)
                Section.Team.Color = Utility:FromRGBA(v[1].R * 255, v[1].G * 255, v[1].B * 255, v[2])
            end})
            SectionHolder:Toggle({Name = "Protected", Flag = ("ESP %s Protected Enabled"):format(v), Callback = function(v)
                Section.Protected.Enabled = v
            end}):ColorPicker({Default = NewRGB(255, 255, 255), Flag = ("ESP %s Protected Color"):format(v), Transparency = 1, Callback = function(v)
                Section.Protected.Color = Utility:FromRGBA(v[1].R * 255, v[1].G * 255, v[1].B * 255, v[2])
            end})
            local Chams = SectionHolder:Toggle({Name = "Chams", Flag = ("ESP %s Chams Enabled"):format(v), Callback = function(v)
                Section.Chams.Enabled = v
            end})
            Chams:ColorPicker({Default = NewRGB(67, 78, 163), Flag = ("ESP %s Chams Color"):format(v), Transparency = 0.6, Callback = function(v)
                Section.Chams.Color = Utility:FromRGBA(v[1].R * 255, v[1].G * 255, v[1].B * 255, v[2])
            end})
            Chams:ColorPicker({Default = NewRGB(67, 163, 125), Flag = ("ESP %s Chams Outline Color"):format(v), Transparency = 0.2, Callback = function(v)
                Section.Chams.Outline = Utility:FromRGBA(v[1].R * 255, v[1].G * 255, v[1].B * 255, v[2])
            end})
        end
        
        if i == 3 then
            SectionHolder:Show()
        end
    end
end

Library:SettingsTab(Settings, Window)

Visuals:Show()