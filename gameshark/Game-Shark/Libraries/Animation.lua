repeat wait() until Utility

local TweenLibrary = {}

Utility:Notify({
    Title = "GameShark",
    Description = "Animations Loaded.",
    Time = 10,
})

function interpolateColor(color1, color2, t)
	local r = color1.r + (color2.r - color1.r) * t
	local g = color1.g + (color2.g - color1.g) * t
	local b = color1.b + (color2.b - color1.b) * t

	return Color3.new(r, g, b)
end

local Animation = {
	Sequential = "Sequential",
	Combinational = "Combinational",
}
local EasingStyles = {
	Linear = function(t) return t end;
	LinearOut = function(t) return 1 - t end;
	LinearIn = function(t) return t end;
	LinearInOut = function(t) if t < 0.5 then return 2 * t else return 2 - (2 * t) end end;
	InSine = function(t) return 1 - math.cos(t * (math.pi / 2)) end;
	OutSine = function(t) return math.sin(t * (math.pi / 2)) end;
	InOutSine = function(t) return -(math.cos(math.pi * t) - 1) / 2 end;
	InQuad = function(t) return t ^ 2 end;
	OutQuad = function(t) return 1 - (1 - t) ^ 2 end;
	InOutQuad = function(t) if t < 0.5 then return 2 * t ^ 2 else return 1 - (-2 * t + 2) ^ 2 / 2 end end;
	InCubic = function(t) return t ^ 3 end;
	OutCubic = function(t) return 1 - (1 - t) ^ 3 end;
	InOutCubic = function(t) if t < 0.5 then return 4 * t ^ 3 else return 1 - (-2 * t + 2) ^ 3 / 2 end end;
	InQuart = function(t) return t ^ 4 end;
	OutQuart = function(t) return 1 - (1 - t) ^ 4 end;
	InOutQuart = function(t) if t < 0.5 then return 8 * t ^ 4 else return 1 - (-2 * t + 2) ^ 4 / 2 end end;
	InQuint = function(t) return t ^ 5 end;
	OutQuint = function(t) return 1 - (1 - t) ^ 5 end;
	InOutQuint = function(t) if t < 0.5 then return 16 * t ^ 5 else return 1 - (-2 * t + 2) ^ 5 / 2 end end;
	InExpo = function(t) return 2 ^ (10 * (t - 1)) end;
	OutExpo = function(t) return 1 - 2 ^ (-10 * t) end;
	InOutExpo = function(t) if t < 0.5 then return 2 ^ (20 * t - 10) / 2 else return (2 - 2 ^ (-20 * t + 10)) / 2 end end;
	InCirc = function(t) return 1 - math.sqrt(1 - t ^ 2) end;
	OutCirc = function(t) return math.sqrt(1 - (1 - t) ^ 2) end;
	InOutCirc = function(t) if t < 0.5 then return (1 - math.sqrt(1 - (2 * t) ^ 2)) / 2 else return (math.sqrt(1 - (-2 * t + 2) ^ 2) + 1) / 2 end end;
	InBack = function(t) return t ^ 2 * (2.70158 * t - 1.70158) end;
	OutBack = function(t) return 1 - ((1 - t) ^ 2 * (2.70158 * (1 - t) - 1.70158)) end;
	InOutBack = function(t) if t < 0.5 then return (2 * t ^ 2 * (7 * t - 3)) / 2 else return (1 - ((-2 * t + 2) ^ 2 * (7 * (-2 * t + 2) - 3))) / 2 end end;
	InElastic = function(t) return math.sin(13 * (math.pi / 2) * t) * 2 ^ (10 * (t - 1)) end;
	OutElastic = function(t) return -math.sin(13 * (math.pi / 2) * (t + 1)) * 2 ^ (-10 * t) + 1 end;
	InOutElastic = function(t) if t < 0.5 then return -(math.sin(13 * (math.pi / 2) * (2 * t)) * 2 ^ (10 * (2 * t - 1))) / 2 else return (math.sin(-13 * (math.pi / 2) * (2 * t - 1 + 1)) * 2 ^ (-10 * (2 * t - 1)) + 2) / 2 end end;
	OutBounce = function(t) if t < 1 / 2.75 then return 7.5625 * t ^ 2 elseif t < 2 / 2.75 then return 7.5625 * (t - (1.5 / 2.75)) ^ 2 + 0.75 elseif t < 2.5 / 2.75 then return 7.5625 * (t - (2.25 / 2.75)) ^ 2 + 0.9375 else return 7.5625 * (t - (2.625 / 2.75)) ^ 2 + 0.984375 end end;
}

EasingStyles.InBounce = function(t) return 1 - EasingStyles.OutBounce(1 - t) end;
EasingStyles.InOutBounce = function(t) if t < 0.5 then return EasingStyles.InBounce(t * 2) / 2 else return EasingStyles.OutBounce(t * 2 - 1) / 2 + 0.5 end end;

function TweenLibrary:Create(object, properties, duration, easingStyle, animationType, keyframes)
	local easingFunction = EasingStyles[easingStyle]
	local TweenTable = {}

	animationType = animationType or "Combinational"
	keyframes = keyframes or {}
	properties = properties or {}

	assert(easingFunction, "Invalid easing style")
	assert(Animation[animationType], "Invalid animation type")

	local initialProperties = {}
	local finalProperties = {}
	local startTime = 0
	local isTweening = false
	local isPaused = false
	local pausedElapsedTime = 0
	local completionCallback = nil

	local function copyInitialProperties()
		for property, value in pairs(properties) do
			initialProperties[property] = object[property]
		end
	end

	local function setFinalProperties()
		if animationType == "Sequential" and #keyframes > 0 then
			-- Keyframe-based interpolation
			local lastKeyframe = keyframes[#keyframes]
			if lastKeyframe then
				for property, value in pairs(lastKeyframe.Properties) do
					finalProperties[property] = value
				end
			end
		else
			-- Non-keyframe type (direct property assignment)
			for property, value in pairs(properties) do
				finalProperties[property] = value
			end
		end
	end

	local function getKeyframeIndex(keyframeTime)
		for i, keyframe in ipairs(keyframes) do
			if keyframe.Time >= keyframeTime then
				return i
			end
		end
		return #keyframes
	end

	local function interpolateProperties(properties1, properties2, progress)
		for property, value in pairs(properties1) do
			local endValue = properties2[property]
			if typeof(value) == "number" and typeof(endValue) == "number" then
				object[property] = value + (endValue - value) * progress
			elseif typeof(value) == "UDim2" and typeof(endValue) == "UDim2" then
				object[property] = value:Lerp(endValue, progress)
			elseif typeof(value) == "Color3" and typeof(endValue) == "Color3" then
				object[property] = interpolateColor(value, endValue, progress)
			elseif typeof(value) == "Vector3" and typeof(endValue) == "Vector3" then
				object[property] = value + (endValue - value) * progress
			end
		end
	end
	
	local function updateTween()
		if isTweening then
			local currentTime = tick()
			local elapsedTime = currentTime - startTime - pausedElapsedTime
			local progress = elapsedTime / duration

			if progress >= 1 then
				progress = 1
			end

			if animationType == "Sequential" then
				local currentKeyframe = 1
				while currentKeyframe < #keyframes and progress >= keyframes[currentKeyframe + 1].Time do
					currentKeyframe = currentKeyframe + 1
				end

				local currentFrame = keyframes[currentKeyframe]
				local nextFrame = keyframes[currentKeyframe + 1]

				if nextFrame then
					local frameProgress = (progress - currentFrame.Time) / (nextFrame.Time - currentFrame.Time)
					interpolateProperties(currentFrame.Properties, nextFrame.Properties, frameProgress)
				else
					interpolateProperties(currentFrame.Properties, currentFrame.Properties, 1)
				end
			else -- Animation.Combinational
				interpolateProperties(initialProperties, finalProperties, progress)
			end

			if progress >= 1 then
				isTweening = false
				if completionCallback then
					completionCallback()
				end
			end
		end
	end


	function TweenTable:Play()
		if not isTweening then
			isTweening = true
			isPaused = false
			startTime = tick()
			pausedElapsedTime = 0
			copyInitialProperties()
			setFinalProperties()

			spawn(function()
				while isTweening do
					updateTween()
					task.wait() -- Adjust the delay as needed
				end
			end)
		elseif isPaused then
			isPaused = false
			startTime = tick() - pausedElapsedTime
		end
	end

	function TweenTable:Pause()
		if isTweening and not isPaused then
			isPaused = true
			pausedElapsedTime = tick() - startTime
		end
	end

	function TweenTable:Resume()
		if isTweening and isPaused then
			TweenTable:Play()
		end
	end

	function TweenTable:Stop()
		if isTweening then
			isTweening = false
			isPaused = false
		end
	end

	function TweenTable:Completed(callback)
		assert(type(callback) == "function", "Completion callback must be a function")
		completionCallback = callback
	end

	return TweenTable
end

return TweenLibrary