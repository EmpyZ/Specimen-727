local collectables = game.Workspace:WaitForChild("Collectables")
local replicatedSt = game:GetService("ReplicatedStorage")
local serverSt = game:GetService("ServerStorage")
local BadgeService = game:GetService("BadgeService")
local collected = false

local plrsFolder = serverSt:WaitForChild("Players")


local proxyPrompt = Instance.new("ProximityPrompt")
proxyPrompt.ClickablePrompt = true
proxyPrompt.Enabled = true
proxyPrompt.Exclusivity = Enum.ProximityPromptExclusivity.OnePerButton
proxyPrompt.GamepadKeyCode = Enum.KeyCode.ButtonX
proxyPrompt.HoldDuration = 0
proxyPrompt.KeyboardKeyCode = Enum.KeyCode.E
proxyPrompt.MaxActivationDistance = 10
proxyPrompt.Name = "proxyPrompt"
proxyPrompt.RequiresLineOfSight = false
proxyPrompt.ActionText = "Grab" -- String Value
proxyPrompt.ObjectText = "Collectable" -- String Value



for i , Collectable in pairs(collectables:GetChildren()) do
	local CPP = proxyPrompt:Clone()
	if Collectable:IsA("Model") and Collectable:FindFirstChild("CanCollect") then
		CPP.Parent = Collectable.Head
			Collectable.Head.proxyPrompt.Triggered:Connect(function(player)
			local userId = player.UserId
			local playerUserId = plrsFolder:FindFirstChild(userId)
			local badgeID = Collectable.BadgeId.Value  -- Change this to your badge ID
			local function awardBadge(player)
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
			 
			    if hasBadge == false then
					if player.GameVals.HasVIP.Value == true then
			        BadgeService:AwardBadge(player.UserId, badgeID)
					if collected == false then
						collected = true
						player.GameVals.TotalCollected.Value = player.GameVals.TotalCollected.Value + 1	
						playerUserId.GameVals.TotalCollected.Value = playerUserId.GameVals.TotalCollected.Value + 1
						replicatedSt.Collected:FireClient(player,Collectable)
						wait(.25)
						collected = false	
					end
					end	
				else
					if collected == false then
						collected = true
						replicatedSt.Collected:FireClient(player,Collectable)
						print(player.Name.." Already owns this badge")
						wait(1.15)
						collected = false
					end
			    end
			end
			awardBadge(player)
		end)
	end
end
