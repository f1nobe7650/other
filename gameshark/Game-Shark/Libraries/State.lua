repeat wait() until Utility

local State = {
    Values = {}
}

Utility:Notify({
    Title = "GameShark",
    Description = "State Loaded.",
    Time = 10,
})

function State:Create(Key, InitValue, Callback)
    Callback = Callback or function() end
    
    local StateTbl = {
        ["Key"] = Key,
        ["Value"] = InitValue,
        ["Callback"] = Callback,
    }
    
    State.Values[StateTbl.Key] = StateTbl
    
    StateTbl.Callback(StateTbl.Value, StateTbl.Key)
    
    function StateTbl:Update(NewValue)
        StateTbl.Value = NewValue
        
        -- // Callback
        StateTbl.Callback(StateTbl.Value, StateTbl.Key)
    end
    
    function StateTbl:SetCallback(NewCallback)
        -- // Setting new callback
        StateTbl.Callback = NewCallback 
    end
    
    function StateTbl:SetKey(NewKey)
        -- // Removes old key
        State.Values[StateTbl.Key] = nil
        
        -- // Changes key from table
        StateTbl.Key = NewKey

        -- // Inserts new key
        State.Values[StateTbl.Key] = StateTbl
    end

    function StateTbl:GetValue()
        return StateTbl.Value
    end
    
    return StateTbl
end
    
function State:Update(Key, Value)
    if State.Values[Key] then
        local StateTbl = State.Values[Key]
        
        StateTbl:Update(Value)
    else
        print("Invalid key: ", Key)
    end
end

function State:SetCallback(Key, Callback)
    if State.Values[Key] then
        local StateTbl = State.Values[Key]
        
        StateTbl:SetCallback(Callback)
    else
        print("Invalid key: ", Key)
    end
end

function State:SetKey(Key, NewKey)
    if State.Values[Key] then
        local StateTbl = State.Values[Key]
        
        StateTbl:SetKey(NewKey)
    else
        print("Invalid key: ", Key)
    end
end

function State:GetValue(Key)
    if State.Values[Key] then
        local StateTbl = State.Values[Key]
        
        return StateTbl:GetValue()
    else
        print("Invalid key: ", Key)
    end
end

return State