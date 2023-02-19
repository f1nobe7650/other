-- credits to vm#8491

local client_info = {}
function client_info.ping_changed(callback)
	task.spawn(function()
		while wait() do
			callback(tonumber(math.floor(tostring(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()):split(" ")[1])))
		end
	end)
end
function client_info.fps_changed(callback)
	-- from a youtube tutorial idfk
	task.spawn(function()
		local LastIteration, Start
		local FrameUpdateTable = {}
		local CurrentFPS = 0
		game:GetService("RunService").Heartbeat:Connect(function()
			LastIteration = tick()
			for Index = #FrameUpdateTable, 1, -1 do
				FrameUpdateTable[Index + 1] = (FrameUpdateTable[Index] >= LastIteration - 1) and FrameUpdateTable[Index] or nil
			end
			FrameUpdateTable[1] = LastIteration
			callback(math.floor((tick() - Start >= 1 and #FrameUpdateTable) or (#FrameUpdateTable / (tick() - Start))))
		end)
		Start = tick()
	end)
end
client_info.game_name = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
return client_info
