repeat wait() until Utility

-- Locals
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Camera = workspace.Camera
local NewRGB = Color3.fromRGB
local NewVector = Vector2.new
local NewInst = Instance.new
local DrawObj = Drawing.new

Utility:Notify({
    Title = "GameShark",
    Description = "ESP Loaded.",
    Time = 10,
})

local ESP = {
    Enabled = false,
    LimitDistance = {
        Enabled = false,
        Amount = 5,
    },

    VisibleOnly = false,

    -- Okay so I made a custom function called Utility:FromRGBA, the 4th argument is the alpha. It goes from 0 - 1.
    ["Enemy"] = {
        Enabled = true,
        Box = {
            Enabled = true,
            Color = Utility:FromRGBA(255, 255, 255, 1),
            Outline = Utility:FromRGBA(0, 0, 0, 1),
            Fill = Utility:FromRGBA(255, 255, 255, 0.5),
        },
        Name = {
            Enabled = true,
            Color = Utility:FromRGBA(255, 255, 255, 1),
            Outline = Utility:FromRGBA(0, 0, 0, 1),
            Case = "Normal",
            Font = 0,
            Size = 15,
            UseDisplayName = false,
        },
        HealthBar = {
            Enabled = true,
            HighColor = Utility:FromRGBA(255, 0, 0, 1),
            LowColor = Utility:FromRGBA(0, 255, 0, 1),
            Outline = Utility:FromRGBA(0, 0, 0, 0.5),
        },
        Health = {
            Enabled = true,
            Color = Utility:FromRGBA(255, 255, 255, 1),
            Outline = Utility:FromRGBA(0, 0, 0, 1),
            Font = 0,
            Size = 10,
            HealthVisibilityCap = 90,
        },
        Tool = {
            Enabled = true,
            Color = Utility:FromRGBA(255, 255, 255, 1),
            Outline = Utility:FromRGBA(0, 0, 0, 1),
            Case = "Normal",
            Font = 0,
            Size = 15,
        },
        Distance = {
            Enabled = true,
            Color = Utility:FromRGBA(255, 255, 255, 1),
            Outline = Utility:FromRGBA(0, 0, 0, 1),
            Case = "Normal",
            Font = 0,
            Size = 15,
        },
        Team = {
            Enabled = true,
            Color = Utility:FromRGBA(255, 255, 255, 1),
            Outline = Utility:FromRGBA(0, 0, 0, 1),
            Case = "Normal",
            Font = 0,
            Size = 15,
        },
        Protected = {
            Enabled = true,
            Color = Utility:FromRGBA(255, 255, 255, 1),
            Outline = Utility:FromRGBA(0, 0, 0, 1),
            Case = "Normal",
            Font = 0,
            Size = 15,
        },
        Chams = {
            Enabled = true,
            Color = Utility:FromRGBA(67, 78, 163, 1),
            Outline = Utility:FromRGBA(67, 163, 125, 0.5),
        },
    },
    ["Team"] = {
        Enabled = true,
        Box = {
            Enabled = true,
            Color = Utility:FromRGBA(255, 255, 255, 1),
            Outline = Utility:FromRGBA(0, 0, 0, 1),
            Fill = Utility:FromRGBA(255, 255, 255, 0.5),
        },
        Name = {
            Enabled = true,
            Color = Utility:FromRGBA(255, 255, 255, 1),
            Outline = Utility:FromRGBA(0, 0, 0, 1),
            Case = "Normal",
            Font = 0,
            Size = 15,
            UseDisplayName = false,
        },
        HealthBar = {
            Enabled = true,
            HighColor = Utility:FromRGBA(255, 0, 0, 1),
            LowColor = Utility:FromRGBA(0, 255, 0, 1),
            Outline = Utility:FromRGBA(0, 0, 0, 0.5),
        },
        Health = {
            Enabled = true,
            Color = Utility:FromRGBA(255, 255, 255, 1),
            Outline = Utility:FromRGBA(0, 0, 0, 1),
            Font = 0,
            Size = 10,
            HealthVisibilityCap = 90,
        },
        Tool = {
            Enabled = true,
            Color = Utility:FromRGBA(255, 255, 255, 1),
            Outline = Utility:FromRGBA(0, 0, 0, 1),
            Case = "Normal",
            Font = 0,
            Size = 15,
        },
        Distance = {
            Enabled = true,
            Color = Utility:FromRGBA(255, 255, 255, 1),
            Outline = Utility:FromRGBA(0, 0, 0, 1),
            Case = "Normal",
            Font = 0,
            Size = 15,
        },
        Team = {
            Enabled = true,
            Color = Utility:FromRGBA(255, 255, 255, 1),
            Outline = Utility:FromRGBA(0, 0, 0, 1),
            Case = "Normal",
            Font = 0,
            Size = 15,
        },
        Protected = {
            Enabled = true,
            Color = Utility:FromRGBA(255, 255, 255, 1),
            Outline = Utility:FromRGBA(0, 0, 0, 1),
            Case = "Normal",
            Font = 0,
            Size = 15,
        },
        Chams = {
            Enabled = true,
            Color = Utility:FromRGBA(67, 78, 163, 0.5),
            Outline = Utility:FromRGBA(67, 163, 125, 0.5),
        },
    },
    ["Self"] = {
        Enabled = true,
        Box = {
            Enabled = true,
            Color = Utility:FromRGBA(255, 255, 255, 1),
            Outline = Utility:FromRGBA(0, 0, 0, 1),
            Fill = Utility:FromRGBA(255, 255, 255, 0.5),
        },
        Name = {
            Enabled = true,
            Color = Utility:FromRGBA(255, 255, 255, 1),
            Outline = Utility:FromRGBA(0, 0, 0, 1),
            Case = "Normal",
            Font = 0,
            Size = 15,
            UseDisplayName = false,
        },
        HealthBar = {
            Enabled = true,
            HighColor = Utility:FromRGBA(255, 0, 0, 1),
            LowColor = Utility:FromRGBA(0, 255, 0, 1),
            Outline = Utility:FromRGBA(0, 0, 0, 0.5),
        },
        Health = {
            Enabled = true,
            Color = Utility:FromRGBA(255, 255, 255, 1),
            Outline = Utility:FromRGBA(0, 0, 0, 1),
            Font = 0,
            Size = 10,
            HealthVisibilityCap = 90,
        },
        Tool = {
            Enabled = true,
            Color = Utility:FromRGBA(255, 255, 255, 1),
            Outline = Utility:FromRGBA(0, 0, 0, 1),
            Case = "Normal",
            Font = 0,
            Size = 15,
        },
        Distance = {
            Enabled = false,
            Color = Utility:FromRGBA(255, 255, 255, 1),
            Outline = Utility:FromRGBA(0, 0, 0, 1),
            Case = "Normal",
            Font = 0,
            Size = 15,
        },
        Team = {
            Enabled = true,
            Color = Utility:FromRGBA(255, 255, 255, 1),
            Outline = Utility:FromRGBA(0, 0, 0, 1),
            Case = "Normal",
            Font = 0,
            Size = 15,
        },
        Protected = {
            Enabled = true,
            Color = Utility:FromRGBA(255, 255, 255, 1),
            Outline = Utility:FromRGBA(0, 0, 0, 1),
            Case = "Normal",
            Font = 0,
            Size = 15,
        },
        Chams = {
            Enabled = true,
            Color = Utility:FromRGBA(67, 78, 163, 1),
            Outline = Utility:FromRGBA(67, 163, 125, 0.5),
        },
    },

    FadeTime = 0.5,

    Players = {},
    FadingPlayers = {},
    Loops = {},
    Connections = {},
    Ignores = {
        -- Tries to find a folder named ignore. Add your own ones if you want.
        workspace:FindFirstChild("ignore"),
        workspace:FindFirstChild("ignores"),
        workspace:FindFirstChild("ignored"),
        workspace:FindFirstChild("Ignore"),
        workspace:FindFirstChild("Ignores"),
        workspace:FindFirstChild("Ignored"),
    },
}

ESP.GetFlags = function(player)
    local group = "Enemy"

    if player == LocalPlayer then
        group = "Self"
    elseif player.Team == LocalPlayer.Team then
        group = "Team"
    end

    return ESP[group]
end

ESP.IsPlayerValid = function(player)
    if not ESP.Enabled then
        return
    end

    local flags = ESP.GetFlags(player)

    if not flags.Enabled then
        return false
    end

    if ESP.VisibleOnly and Utility:IsAlive(LocalPlayer) and Utility:Raycast(LocalPlayer.Character.HumanoidRootPart.Position, player.Character.HumanoidRootPart.Position, ESP.Ignores) then
        return false
    end

    local Distance = Utility:GetDistance(player)

    if ESP.LimitDistance.Enabled and Distance < ESP.LimitDistance.Amount then
        return false
    end

    return true
end

ESP.AddPlayer = function(player)
    if ESP.Players[player] then
        return
    end

    ESP.Players[player] = {
        BoxOutline = Utility:NewDrawing("Square", {
            Filled = false,
            Thickness = 3,
        }),
        Box = Utility:NewDrawing("Square", {
            Filled = false,
            Thickness = 1,        
        }),
        BoxFill = Utility:NewDrawing("Square", {
            Filled = true,
        }),
        NameOutline = Utility:NewDrawing("Text"),
        Name = Utility:NewDrawing("Text"),
        HealthBarOutline = Utility:NewDrawing("Square", {
            Filled = true,
        }),

        -- The reason im doing this is because the thickness thing sucks and if I use squares it gets delayed!
        HealthBar = Utility:NewDrawing("Line", {
            Thickness = 1,
        }),
        HealthBar2 = Utility:NewDrawing("Line", {
            Thickness = 1,
        }),
        HealthOutline = Utility:NewDrawing("Text"),
        Health = Utility:NewDrawing("Text"),
        ToolOutline = Utility:NewDrawing("Text"),
        Tool = Utility:NewDrawing("Text"),
        DistanceOutline = Utility:NewDrawing("Text"),
        Distance = Utility:NewDrawing("Text"),
        TeamOutline = Utility:NewDrawing("Text"),
        Team = Utility:NewDrawing("Text"),
        ProtectedOutline = Utility:NewDrawing("Text"),
        Protected = Utility:NewDrawing("Text"),
        Chams = Utility:NewObject("Highlight"),
    }

    ESP.Loops[player] = Utility:Connect(RunService.RenderStepped, function()
        local Drawings = ESP.Players[player]

        local Character = player.Character
        local Opacity = 1

        if not Utility:IsAlive(player) and ESP.FadingPlayers[player] then
            local PlayerFade = ESP.FadingPlayers[player]

            if PlayerFade then
                Opacity = math.clamp((PlayerFade.Tick - tick() + ESP.FadeTime) * 1 / ESP.FadeTime, 0, 1)
            end
        end

        if ESP.IsPlayerValid(player) then
            local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart") or ESP.FadingPlayers[player].HumanoidRootPart or nil
            local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or ESP.FadingPlayers[player].Humanoid or nil

            if HumanoidRootPart and Humanoid then
                local Pos, OnScreen = Camera:WorldToViewportPoint(HumanoidRootPart.Position)

                if OnScreen then
                    local flags = ESP.GetFlags(player)

                    -- Drawings
                    local BoxSize, BoxPos = ESP.BoxSizing(HumanoidRootPart)

                    if (Library and Library.MainWindow) and (Library.MainWindow.Outline.Visible and not Utility:InBoundsSize(Library.MainWindow.Outline, BoxPos, BoxSize) or not Library.MainWindow.Outline.Visible) then
                        if Utility:IsAlive(player) and Character.HumanoidRootPart and Character.Humanoid then
                            ESP.FadingPlayers[player] = {
                                Fading = false,
                                HumanoidRootPart = Utility:GetPartInfo(Character.HumanoidRootPart),
                                Humanoid = {
                                    Health = Character.Humanoid.Health,
                                    MaxHealth = Character.Humanoid.MaxHealth,
                                },
                                Tick = tick(),
                            }
                        end
    
                        for _,v in pairs(Drawings) do
                            if typeof(v) == "table" and v.Visible then
                                v.Visible = false
                            elseif typeof(v) == "Instance" and v.Enabled then
                                v.Enabled = false
                            end
                        end

                        local Box = Drawings.Box
                        local BoxOutline = Drawings.BoxOutline
                        local BoxFill = Drawings.BoxFill
                        local Name = Drawings.Name
                        local NameOutline = Drawings.NameOutline
                        local HealthBar = Drawings.HealthBar
                        local HealthBar2 = Drawings.HealthBar2
                        local HealthBarOutline = Drawings.HealthBarOutline
                        local Health = Drawings.Health
                        local HealthOutline = Drawings.HealthOutline
                        local Tool = Drawings.Tool
                        local ToolOutline = Drawings.ToolOutline
                        local Distance = Drawings.Distance
                        local DistanceOutline = Drawings.DistanceOutline
                        local Team = Drawings.Team
                        local TeamOutline = Drawings.TeamOutline
                        local Protected = Drawings.Protected
                        local ProtectedOutline = Drawings.ProtectedOutline
                        local Chams = Drawings.Chams
    
                        local RightAdd = 0
                        local BottomAdd = 0
    
                        Humanoid.NameDisplayDistance = 0
    
                        CreateFlag = function(text, object, object2, table, side)
                            if side:lower() == "bottom" then
                                object.Visible = true
                                object.Font = table.Font
                                object.Size = table.Size
                                object.Color = table.Color
                                object.Transparency = table.Color.a * Opacity
                                object.Text = Utility:GetCase(text, table.Case)
                                object.Center = true
                                object.Position = NewVector(BoxPos.X + BoxSize.X / 2, BoxPos.Y + BoxSize.Y + 2 + BottomAdd)
                    
                                object2.Visible = true
                                object2.Font = table.Font
                                object2.Size = table.Size
                                object2.Color = table.Outline
                                object2.Transparency = table.Outline.a * Opacity
                                object2.Text = Utility:GetCase(text, table.Case)
                                object2.Center = true
                                object2.Position = NewVector(BoxPos.X + BoxSize.X / 2 + 1,  BoxPos.Y + BoxSize.Y + 3 + BottomAdd)
    
                                BottomAdd += object.TextBounds.Y
                            elseif side:lower() == "right" then
                                object.Visible = true
                                object.Font = table.Font
                                object.Size = table.Size
                                object.Color = table.Color
                                object.Transparency = table.Color.a * Opacity
                                object.Text = Utility:GetCase(text, table.Case)
                                object.Position = NewVector(BoxPos.X + BoxSize.X + 3,  BoxPos.Y + RightAdd - 4)
                                
                                object2.Visible = true
                                object2.Font = table.Font
                                object2.Size = table.Size
                                object2.Color = table.Outline
                                object2.Transparency = table.Outline.a * Opacity
                                object2.Text = Utility:GetCase(text, table.Case)
                                object2.Position = NewVector(BoxPos.X + BoxSize.X + 4,  BoxPos.Y + RightAdd - 3)
    
                                RightAdd += object.TextBounds.Y
                            end
                        end
    
                        if flags.Box.Enabled then
                            Box.Visible = true
                            Box.Color = flags.Box.Color
                            Box.Transparency = flags.Box.Color.a * Opacity
                            Box.Size = BoxSize
                            Box.Position = BoxPos
    
                            BoxOutline.Visible = true
                            BoxOutline.Transparency = flags.Box.Outline.a * Opacity
                            BoxOutline.Color = flags.Box.Outline
                            BoxOutline.Size = BoxSize
                            BoxOutline.Position = BoxPos
                            
                            BoxFill.Visible = true
                            BoxFill.Color = flags.Box.Fill
                            BoxFill.Transparency = flags.Box.Fill.a * Opacity
                            BoxFill.Size = BoxSize - NewVector(4, 4)
                            BoxFill.Position = BoxPos + NewVector(2, 2)
                        end
    
                        if flags.Name.Enabled then
                            Name.Visible = true
                            Name.Font = flags.Name.Font
                            Name.Size = flags.Name.Size
                            Name.Color = flags.Name.Color
                            Name.Transparency = flags.Name.Color.a * Opacity
                            Name.Text = Utility:GetCase(flags.Name.UseDisplayName and player.DisplayName or player.Name, flags.Name.Case)
                            Name.Center = true
                            Name.Position = NewVector(BoxPos.X + BoxSize.X / 2, BoxPos.Y - Name.TextBounds.Y - 4)
    
                            NameOutline.Visible = true
                            NameOutline.Font = flags.Name.Font
                            NameOutline.Size = flags.Name.Size
                            NameOutline.Color = flags.Name.Outline
                            NameOutline.Transparency = flags.Name.Outline.a * Opacity
                            NameOutline.Text = Utility:GetCase(flags.Name.UseDisplayName and player.DisplayName or player.Name, flags.Name.Case)
                            NameOutline.Center = true
                            NameOutline.Position = NewVector(BoxPos.X + BoxSize.X / 2 + 1, BoxPos.Y - NameOutline.TextBounds.Y - 3)
                        end
    
                        if flags.HealthBar.Enabled then
                            HealthBar.Visible = true
                            HealthBar.Color = flags.HealthBar.HighColor:Lerp(flags.HealthBar.LowColor, Humanoid.Health / Humanoid.MaxHealth)
                            HealthBar.Transparency = flags.HealthBar.HighColor.a * Opacity
                            HealthBar.From = NewVector(BoxPos.X - 5, BoxPos.Y + BoxSize.Y)
                            HealthBar.To = NewVector(BoxPos.X - 5, HealthBar.From.Y - (Humanoid.Health / Humanoid.MaxHealth) * BoxSize.Y)
    
                            HealthBar2.Visible = true
                            HealthBar2.Color = flags.HealthBar.HighColor:Lerp(flags.HealthBar.LowColor, Humanoid.Health / Humanoid.MaxHealth)
                            HealthBar2.Transparency = flags.HealthBar.HighColor.a * Opacity
                            HealthBar2.From = NewVector(BoxPos.X - 4, BoxPos.Y + BoxSize.Y)
                            HealthBar2.To = NewVector(BoxPos.X - 4, HealthBar.From.Y - (Humanoid.Health / Humanoid.MaxHealth) * BoxSize.Y)
    
                            HealthBarOutline.Visible = true
                            HealthBarOutline.Color = flags.HealthBar.Outline
                            HealthBarOutline.Transparency = flags.HealthBar.Outline.a * Opacity
                            HealthBarOutline.Size = NewVector(4, BoxSize.Y + 2)
                            HealthBarOutline.Position = NewVector(BoxPos.X - 6, BoxPos.Y - 1)
                        end
    
                        if flags.Health.Enabled and Humanoid.Health <= flags.Health.HealthVisibilityCap then
                            Health.Text = tostring(math.floor(Humanoid.Health))
                            Health.Visible = true
                            Health.Font = flags.Health.Font
                            Health.Size = flags.Health.Size
                            Health.Color = flags.Health.Color
                            Health.Transparency = flags.Health.Color.a  * Opacity
                            Health.Center = true
                            Health.Position = NewVector(HealthBar.To.X, HealthBar.To.Y - Health.TextBounds.Y / 2 - 1)
    
                            HealthOutline.Text = tostring(math.floor(Humanoid.Health))
                            HealthOutline.Visible = true
                            HealthOutline.Font = flags.Health.Font
                            HealthOutline.Size = flags.Health.Size
                            HealthOutline.Color = flags.Health.Outline
                            HealthOutline.Transparency = flags.Health.Outline.a * Opacity
                            HealthOutline.Center = true
                            HealthOutline.Position = NewVector(HealthBar.To.X + 1, HealthBar.To.Y - HealthOutline.TextBounds.Y / 2)
                        end
    
                        local ToolName = Character:FindFirstChildWhichIsA("Tool") and Character:FindFirstChildWhichIsA("Tool").Name or nil
                        if flags.Tool.Enabled and ToolName then
                            CreateFlag(ToolName, Tool, ToolOutline, flags.Tool, "Bottom")
                        end
    
                        if flags.Distance.Enabled then
                            CreateFlag(tostring(math.floor(Utility:GetDistance(player))) .. " S", Distance, DistanceOutline, flags.Distance, "Bottom")
                        end
    
                        local TeamName = player.Team and player.Team.Name or nil
                        if flags.Team.Enabled and TeamName then
                            CreateFlag(TeamName, Team, TeamOutline, flags.Team, "Right")
                        end
    
                        if flags.Protected.Enabled and Character:FindFirstChildWhichIsA("ForceField") then
                            CreateFlag("Protected", Protected, ProtectedOutline, flags.Protected, "Right")
                        end
    
                        if flags.Chams.Enabled then
                            Chams.Parent = Character
                            Chams.Adornee = Character
                            Chams.FillColor = flags.Chams.Color
                            Chams.FillTransparency = 1 - flags.Chams.Color.a * Opacity
                            Chams.OutlineColor = flags.Chams.Outline
                            Chams.OutlineTransparency = 1 - flags.Chams.Outline.a * Opacity
                            Chams.Enabled = true
                        end
                    elseif Utility:IsAlive(player) then
                        for _,v in pairs(Drawings) do
                            if typeof(v) == "table" and v.Visible then
                                v.Visible = false
                            elseif typeof(v) == "Instance" and v.Enabled then
                                v.Enabled = false
                            end
                        end
                    end
                elseif Utility:IsAlive(player) then
                    for _,v in pairs(Drawings) do
                        if typeof(v) == "table" and v.Visible then
                            v.Visible = false
                        elseif typeof(v) == "Instance" and v.Enabled then
                            v.Enabled = false
                        end
                    end
                end
            elseif Utility:IsAlive(player) then
                for _,v in pairs(Drawings) do
                    if typeof(v) == "table" and v.Visible then
                        v.Visible = false
                    elseif typeof(v) == "Instance" and v.Enabled then
                        v.Enabled = false
                    end
                end
            end
        elseif Utility:IsAlive(player) then
            for _,v in pairs(Drawings) do
                if typeof(v) == "table" and v.Visible then
                    v.Visible = false
                elseif typeof(v) == "Instance" and v.Enabled then
                    v.Enabled = false
                end
            end
        end
    end)
end

ESP.RemovePlayer = function(player)
    if not ESP.Players[player] then
        return
    end

    for _,v in pairs(ESP.Players[player]) do
        if typeof(v) == "table" then
            v:Remove()
        elseif typeof(v) == "Instance" then
            v:Destroy()
        end
    end

    ESP.Loops[player]:Disconnect()
end

ESP.BoxSizing = function(torso)
    local VTop = torso.Position + (torso.CFrame.UpVector * 1.8) + Camera.CFrame.UpVector
    local VBottom = torso.Position - (torso.CFrame.UpVector * 2.5) - Camera.CFrame.UpVector

    local Top, TopIsRendered = Camera:WorldToViewportPoint(VTop)
    local Bottom, BottomIsRendered = Camera:WorldToViewportPoint(VBottom)

    local Width = math.max(math.floor(math.abs(Top.x - Bottom.x)), 3)
    local Height = math.max(math.floor(math.max(math.abs(Bottom.y - Top.y), Width / 2)), 3)
    local BoxSize = NewVector(math.floor(math.max(Height / 1.5, Width)), Height)
    local BoxPosition = NewVector(math.floor(Top.x * 0.5 + Bottom.x * 0.5 - BoxSize.x * 0.5), math.floor(math.min(Top.y, Bottom.y)))

    return BoxSize, BoxPosition
end

table.insert(ESP.Connections, Utility:Connect(Players.PlayerAdded, function(player)
    ESP.AddPlayer(player)
end))

table.insert(ESP.Connections, Utility:Connect(Players.PlayerRemoving, function(player)
    ESP.RemovePlayer(player)
end))

for _,player in pairs(Players:GetPlayers()) do
    ESP.AddPlayer(player)
end

return ESP