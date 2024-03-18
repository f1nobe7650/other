repeat wait() until Utility

local NewRGB = Color3.fromRGB
local NewHSV = Color3.fromHSV
local NewInst = Instance.new
local NewVector = Vector2.new
local NewVector3 = Vector3.new
local NewUdim2 = UDim2.new
local NewUDim = UDim.new

Utility:Notify({
    Title = "GameShark",
    Description = "Math Loaded.",
    Time = 10,
})

local Math = {}

function Math:Random(min, max, decimals)
    if not (min or max) then
        Utility:Notify({
            Title = "An error has occurred: Math.lua",
            Description = "Please provide both min and max arguments.",
            Time = 10,
            Type = "Error",
        })
    end

    min = min or 0
    max = max or 0

    return decimals and math.random(min, max) / 1.1 or math.random(min, max)
end

function Math:RandomValue(unitType, min, max, decimals)
    if not (unitType or min or max) then
        Utility:Notify({
            Title = "An error has occurred: Math.lua",
            Description = "Please provide unitType, min, and max arguments.",
            Time = 10,
            Type = "Error",
        })
    end

    unitType = unitType or ""
    min = min or 0
    max = max or 0

    if unitType:lower() == "vector3" then
        return NewVector3(
            Math:Random(min, max, decimals),
            Math:Random(min, max, decimals),
            Math:Random(min, max, decimals)
        )
    elseif unitType:lower() == "vector2" then
        return NewVector(
            Math:Random(min, max, decimals),
            Math:Random(min, max, decimals)
        )
    elseif unitType:lower() == "udim2" then
        return NewUDim2(
            0,
            Math:Random(min, max, decimals),
            0,
            Math:Random(min, max, decimals)
        )
    elseif unitType:lower() == "udim" then
        return NewUDim(
            0,
            Math:Random(min, max, decimals)
        )
    else
        Utility:Notify({
            Title = "An error has occurred: Math.lua",
            Description = "Invalid unit type. Supported types are \n{\n    Vector3\n    Vector2\n    UDim2\n    UDim\n}.\n",
            Time = 10,
            Type = "Error",
        })
    end
end

return Math