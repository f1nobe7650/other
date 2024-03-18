local Files = listfiles("Game-Shark")
local Loader = {
    Ignore = {
        ["Bot"] = "Bot",
        ["Website"] = "Website",
        ["Loader.lua"] = "Loader",
        ["Old Files"] = "Old Files",
    },
    Names = {
        ["User Interface"] = "Library",
    },
    FilesLoaded = {},
}

if Utility then
    Utility:Unload()
end

function Loader:GetFiles(Files)
    local UnpackedFiles = {}

    for _,v in pairs(Files) do
        local FileName = v:match(".*\\(.*)")

        if Loader.Ignore[FileName] then
            continue
        end

        if not isfolder(v) and not FileName:find(".lua") then
            continue
        end

        if isfolder(v) then
            local NewFiles = Loader:GetFiles(listfiles(v))

            for _,v in pairs(NewFiles) do
                table.insert(UnpackedFiles, v)
            end
        else
            table.insert(UnpackedFiles, v)
        end
    end

    return UnpackedFiles
end

function Loader:RunFiles(Files)
    for _,v in pairs(Files) do
        local FileName = v:match(".*\\(.*)"):gsub(".lua", "")
        FileName = Loader.Names[FileName] or FileName

        task.spawn(function()
            local err, msg = pcall(function()
                getgenv()[FileName] = loadstring(readfile(v))()
                Loader.FilesLoaded[FileName] = FileName
            end) 

            if not err then
                if FileName ~= "Utility" then
                    repeat wait() until Utility 
                end

                if Utility then
                    Utility:Notify({
                        Title = "An error has occurred: " .. FileName .. ".lua",
                        Description = msg,
                        Time = 50,
                        Type = "Error",
                    })

                    print("An error has occurred: " .. FileName .. ".lua: ", msg)
                else
                    print("An error has occurred: " .. FileName .. ".lua: ", msg)
                end
            end
        end)
    end
end

Loader:RunFiles(Loader:GetFiles(Files))

getgenv().Loader = Loader