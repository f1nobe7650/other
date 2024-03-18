if game.PlaceId ~= 301549746 then return end

repeat wait() until Utility and Library and Toggle

local Players = game.Players
local LocalPlayer = Players.LocalPlayer
local UserInputService = game.UserInputService
local RunService = game.RunService
local ReplicatedStorage = game.ReplicatedStorage
local Camera = workspace.Camera
local AutoWallParams = RaycastParams.new()
AutoWallParams.FilterType = Enum.RaycastFilterType.Blacklist
local AutoWallBackParams = RaycastParams.new()
AutoWallBackParams.FilterType = Enum.RaycastFilterType.Whitelist

-- // Feature Template for now

Library:Window()
    :Add("Tab", "Rage")
        :Add("Section", "Aimbot")
        :Ret()
        :Add("Section", "Anti-Aim")
            :Side("Right")
            :Scale(0.49)
        :Ret()
        :Add("Section", "Hack vs. Hack")
            :Side("Right")
            :Scale(0.49)
            :Size(1)
        :Ret()
    :Ret()
    :Add("Tab", "Visuals")
        
    :Ret()
    :Add("Tab", "Misc")
        :Add("Section", "Movement")
            :Add("Toggle", "Auto Jump")
                :Flag("Auto Jump")
            :Ret()
            :Add("Toggle", "Speed")
                :Flag("Speed Enabled")
                :Add("Keybind")
                    :Flag("Speed Key")
                    :Key("")
                :Ret()
            :Ret()
            :Add("Slider", "Speed Factor")
                :Flag("Speed Factor")
                :Value(60)
                :Min(15)
                :Max(250)
            :Ret()
            :Add("Dropdown", "Speed Type")
                :Flag("Speed Type")
                :Values({ "Always", "In Air", "On Hop" })
                :Value("Always")
            :Ret()
            :Add("Dropdown", "Speed Mode")
                :Flag("Speed Mode")
                :Values({ "Velocity", "CFrame" })
                :Value("Velocity")
            :Ret()
            :Add("Toggle", "Fly")
                :Flag("Fly Enabled")
                :Add("Keybind")
                    :Flag("Fly Key")
                    :Key("")
                :Ret()
            :Ret()
            :Add("Slider", "Fly Factor")
                :Flag("Fly Factor")
                :Value(60)
                :Min(15)
                :Max(250)
            :Ret()
            :Add("Toggle", "Click Teleport")
                :Flag("Click Teleport")
                :Add("Keybind")
                    :Flag("Click Teleport Key")
                    :Key("")
                :Ret()
            :Ret()
        :Ret()
        :Add("Section", "Desync")
            :Side("Right")
            :Scale(0.49)
        :Ret()
        :Add("Section", "Extra")
            :Side("Right")
            :Scale(0.49)
            :Size(1)
        :Ret()
    :Ret()
    :Add("Tab", "Settings")
        
    :Ret()
:Ret()
--[[
local Client = getsenv(LocalPlayer.PlayerGui.Client)

do
    function Encrypt(vector)
        return Vector3.new(((vector.X - 74312) * 4 + 1325) * 13, (vector.Y + 3183421) * 4 - 4201432, (vector.Z * 41 - 581357) * 2)
    end

    function Shoot(target, position, gun, range, damageModifier, isMelee, wallbang, rmbHit)
        ReplicatedStorage.Events.HitPart:FireServer(
            target, 
            Encrypt(position), 
            gun, 
            range, 
            LocalPlayer.Character:FindFirstChild("Gun"), 
            nil, 
            damageModifier, 
            isMelee, 
            wallbang, 
            Vector3.zero, 
            workspace.DistributedTime.Value, 
            Vector3.new(1, 0, 0), 
            rmbHit, 
            nil, 
            nil, 
            nil, 
            nil
        )
    end
end

local FireRateTick = 0
Utility:Connect(RunService.RenderStepped, function()
    for _,v in pairs(Players:GetPlayers()) do
        local OldClock = os.clock()
        if Utility:IsAlive(LocalPlayer) and v ~= LocalPlayer and v.Team ~= LocalPlayer.Team and Utility:IsAlive(v) and Client.gun and Client.gun:FindFirstChild("Penetration") then
            if OldClock - FireRateTick < (Client.gun.FireRate.Value or 0.5) then
                return
            end

            FireRateTick = OldClock

            local Character = v.Character

            local Origin = Camera.CFrame.Position

            local Map = workspace:FindFirstChild("Map")
            
            if not Map then
                return
            end
            
            local Direction = (Character.Head.Position - Origin)

            local MaximumPenetration = 0
            local PenetrationPower = Client.gun.Penetration.Value * 0.01
            local DamageModifier = 1
            local IgnoreList = {
                Character, 
                LocalPlayer.Character, 
                Camera, 
                Map:FindFirstChild("Clips"), 
                Map:FindFirstChild("SpawnPoints"), 
                Map:FindFirstChild("TSpawns"), 
                Map:FindFirstChild("CTSpawns"), 
                Map:FindFirstChild("Ignore"),
                workspace:FindFirstChild("Debris"), 
                workspace:FindFirstChild("Ray_Ignore"),
            }

            AutoWallParams.FilterDescendantsInstances = IgnoreList

            local Visible = workspace:Raycast(Origin, Direction, AutoWallParams)
            
            -- // Checking if they are visible.
            if not Visible then
                Shoot(v.Character.HeadHB, v.Character.HeadHB.Position, Client.gun.Name, Client.gun.Range.Value, 1, false, true, false)

                return
            end

            local Passes = 0

            for _,result in pairs(Camera:GetPartsObscuringTarget( {v.Character.Head.Position}, IgnoreList )) do
                if Passes > 4 then
                    break
                end

                local HitPosition = result.Position
                local PartHit = result
                local HitMaterial = PartHit.Material
                
                table.insert(IgnoreList, PartHit)

                AutoWallParams.FilterDescendantsInstances = IgnoreList


                -- // I just took this from the game source LEL!!
                local Mod = 1
                if HitMaterial == Enum.Material.DiamondPlate then
                    Mod = 3
                end
                if HitMaterial == Enum.Material.CorrodedMetal or HitMaterial == Enum.Material.Metal or HitMaterial == Enum.Material.Concrete or HitMaterial == Enum.Material.Brick then
                    Mod = 2
                end
                if PartHit.Name == "Grate" or HitMaterial == Enum.Material.Wood or HitMaterial == Enum.Material.WoodPlanks or PartHit and PartHit.Parent and PartHit.Parent:FindFirstChild("Humanoid") then
                    Mod = 0.1
                end
                if PartHit.Transparency == 1 or PartHit.CanCollide == false or PartHit.Name == "Glass" or PartHit.Name == "Cardboard" then
                    Mod = 0
                end
                if PartHit.Name == "nowallbang" then
                    Mod = 100
                end
                if PartHit:FindFirstChild("PartModifier") then
                    Mod = PartHit.PartModifier.Value;
                end

                if Mod <= 0 then
                    Shoot(v.Character.HeadHB, v.Character.HeadHB.Position, Client.gun.Name, Client.gun.Range.Value, 1, false, true, false)

                    return
                end 

                --print("Mod:", Mod)
                --print("Material:", HitMaterial)

                local MaxPen = (PenetrationPower - MaximumPenetration) / Mod
                local ReverseDirection = Direction.Unit * MaxPen    
                
                AutoWallBackParams.FilterDescendantsInstances = {PartHit}

                local EndResult = workspace:Raycast(HitPosition + ReverseDirection, ReverseDirection * -2, AutoWallBackParams)

                if not EndResult then
                    return
                end

                Passes += 1

                local PenetrationDistance = (EndResult.Position - HitPosition).Magnitude * Mod

                --print("PenDistance:", PenetrationDistance)

                MaximumPenetration += PenetrationDistance
            end

            --print("DamageMod:", DamageModifier)

            DamageModifier = 1 - (MaximumPenetration / PenetrationPower)

            --print("MaximumPen:", MaximumPenetration, "PenPower:", PenetrationPower)

            if MaximumPenetration >= PenetrationPower or DamageModifier <= 0 then
                return
            end

            Shoot(v.Character.HeadHB, v.Character.HeadHB.Position, Client.gun.Name, Client.gun.Range.Value, DamageModifier, false, true, false)
        end
    end
end)
]]--