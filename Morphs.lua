local replicatedSt = game:GetService("ReplicatedStorage")
local serverSt = game:GetService("ServerStorage")
local BadgeService = game:GetService("BadgeService")
local Players = game:GetService("Players")

local Morphs = replicatedSt:WaitForChild("Morphs")
local MorphWall = game.Workspace:WaitForChild("MorphWall")
local Cave_Morphs = MorphWall:WaitForChild("Morphs")

--local teleporters = MorphWall:WaitForChild("Teleporters")
local badgeID = 2124790115
local badgeHE = 2124836882
local badgeHECandy = 2124838245

local clicked = false

	local function CheckBadgeTT(player)
	    local hasBadge = false
	 
	    -- Check if the player already has the badge
	    local success, message = pcall(function()
	        hasBadge = BadgeService:UserHasBadgeAsync(player.UserId, badgeID)
	    end)
	 
	    -- If there's an error, issue a warning and exit the function
	    if not success then
	        warn("Error while checking if player has badge: " .. tostring(message))
	        return
	    end
	 
	    if hasBadge == true then
	        return true
		else
			return false
	    end
	end


	local function CheckBadgeHECandy(player)
	    local hasBadge = false
	 
	    -- Check if the player already has the badge
	    local success, message = pcall(function()
	        hasBadge = BadgeService:UserHasBadgeAsync(player.UserId, badgeHECandy)
	    end)
	 
	    -- If there's an error, issue a warning and exit the function
	    if not success then
	        warn("Error while checking if player has badge: " .. tostring(message))
	        return
	    end
	 
	    if hasBadge == true then
	        return true
		else
			return false
	    end
	end

	local function CheckBadgeHE(player)
	    local hasBadge = false
	 
	    -- Check if the player already has the badge
	    local success, message = pcall(function()
	        hasBadge = BadgeService:UserHasBadgeAsync(player.UserId, badgeHE)
	    end)
	 
	    -- If there's an error, issue a warning and exit the function
	    if not success then
	        warn("Error while checking if player has badge: " .. tostring(message))
	        return
	    end
	 
	    if hasBadge == true then
	        return true
		else
			return false
	    end
	end

wait(10)


for i ,proxys in pairs(Cave_Morphs:GetDescendants()) do
	if proxys:IsA("ProximityPrompt") then
		proxys.Triggered:Connect(function(player)
			if proxys.Parent.Parent:FindFirstChild("TTMorph") and CheckBadgeTT(player) == true then
				if clicked == false then
				clicked = true
					if proxys.Parent.Parent.Name == tostring(Morphs[proxys.Parent.Parent.Name]) then
					print(player.Name.." Is changing into "..tostring(Morphs[proxys.Parent.Parent.Name]))
					local character = Morphs[proxys.Parent.Parent.Name]:Clone()
						if player.Character then
						character.Name = player.Name
						player.Character = character
						character.Parent = game.Workspace
						character.HumanoidRootPart.CFrame = MorphWall.TeleportAfterMorph.CFrame + Vector3.new(0,5,0)
						end
					end
				wait(.75)
				clicked = false
			end
			elseif proxys.Parent.Parent:FindFirstChild("HEMorph") and CheckBadgeHE(player) == true then
				if clicked == false then
				clicked = true
					if proxys.Parent.Parent.Name == tostring(Morphs[proxys.Parent.Parent.Name]) then
					print(player.Name.." Is changing into "..tostring(Morphs[proxys.Parent.Parent.Name]))
					local character = Morphs[proxys.Parent.Parent.Name]:Clone()
						if player.Character then
						character.Name = player.Name
						player.Character = character
						character.Parent = game.Workspace
						character.HumanoidRootPart.CFrame = MorphWall.TeleportAfterMorph.CFrame + Vector3.new(0,5,0)
						end
					end
				wait(.75)
				clicked = false
			end
			elseif proxys.Parent.Parent:FindFirstChild("HEMorphCandy") and CheckBadgeHECandy(player) == true then
				if clicked == false then
				clicked = true
					if proxys.Parent.Parent.Name == tostring(Morphs[proxys.Parent.Parent.Name]) then
					print(player.Name.." Is changing into "..tostring(Morphs[proxys.Parent.Parent.Name]))
					local character = Morphs[proxys.Parent.Parent.Name]:Clone()
						if player.Character then
						character.Name = player.Name
						player.Character = character
						character.Parent = game.Workspace
						character.HumanoidRootPart.CFrame = MorphWall.TeleportAfterMorph.CFrame + Vector3.new(0,5,0)
						end
					end
				wait(.75)
				clicked = false
			end
			end
		end)	
	end	
end


local playerMorph = Instance.new("StringValue")
playerMorph.Name = "PlayerMorph"
playerMorph.Value = ""

local clonedPMorphString = playerMorph:Clone()

MorphWall.PlayerName.CloneBack.ProximityPrompt.Triggered:Connect(function(player)
	if player.Character and not player.Character:FindFirstChild("PlayerMorph") then
		if clicked == false and Morphs:FindFirstChild(player.Name) then
      clicked = true
      local character = Morphs[player.Name]:Clone()
      character.Name = player.Name
      player.Character = character
      clonedPMorphString.Parent = character
      character.Parent = game.Workspace
      character.HumanoidRootPart.CFrame = MorphWall.TeleportAfterMorph.CFrame + Vector3.new(0,5,0)
      wait(.75)
      clicked = false
		end
	end
end)
