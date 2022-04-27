local DataStoreService = game:GetService("DataStoreService")

local DataStore = DataStoreService:GetDataStore("MyDataStore")

local BadgeService = game:GetService("BadgeService")

local replicatedSt = game:GetService("ReplicatedStorage")

local Morphs = replicatedSt:WaitForChild("Morphs")

local isfast = replicatedSt:WaitForChild("IsFast")

local serverSt = game:GetService("ServerStorage")
local plrsFolder = serverSt:WaitForChild("Players")

local DefaultAnimations = serverSt:WaitForChild("DefaultAnims")

local foundCreatorId = 2124783989

local badgeID = 2124782556

local InsaneID = 2124790115

local tools = serverSt:FindFirstChild("Tools")

local P5 = game:GetService("PhysicsService")
P5:CreateCollisionGroup("BotWalls")
P5:CreateCollisionGroup("Players")

P5:CollisionGroupSetCollidable("Players", "Players", false)
P5:CollisionGroupSetCollidable("Players","BotWalls",false)
	
local function CharacterAdded(Char)
local player = game.Players:GetPlayerFromCharacter(Char)
	if player.GameVals.FastRecharge.Value == true then
isfast:FireClient(player,true)
else 
isfast:FireClient(player,false)
print(player.Name.." Has the fastrecharge.Value false")
end

replicatedSt.OriginalSettings:FireClient(player)

if player:FindFirstChild("VipTrue") then
	player.VipTrue:Destroy()
end

print("running the characteradded")
repeat wait(1) until Char:WaitForChild("Humanoid")

	local humanoid = Char:WaitForChild("Humanoid")
 
	if not Char:FindFirstChild("Morph") then
	for _, playingTracks in pairs(humanoid:GetPlayingAnimationTracks()) do
		playingTracks:Stop(0)
	end

 
	local animateScript = Char:WaitForChild("Animate")
    for _, stuff in pairs(animateScript:GetChildren()) do
		if stuff:IsA("StringValue") or stuff:IsA("NumberValue") then
        	stuff:Destroy()
		end
    end
    for _, stuff in pairs(DefaultAnimations:GetChildren()) do
        local newStuff = stuff:Clone()
        newStuff.Parent = animateScript
    end--]]
	--[[animateScript.run.RunAnim.AnimationId = "rbxassetid://7656405944"        -- Run
	animateScript.walk.WalkAnim.AnimationId = "rbxassetid://7656433383"      -- Walk
	animateScript.jump.JumpAnim.AnimationId = "rbxassetid://616161997"      -- Jump
	animateScript.idle.Animation1.AnimationId = "rbxassetid://616158929"    -- Idle (Variation 1)
	animateScript.idle.Animation2.AnimationId = "rbxassetid://616160636"    -- Idle (Variation 2)
	animateScript.fall.FallAnim.AnimationId = "rbxassetid://616157476"      -- Fall
	animateScript.swim.Swim.AnimationId = "rbxassetid://616165109"          -- Swim (Active)
	animateScript.swimidle.SwimIdle.AnimationId = "rbxassetid://616166655"  -- Swim (Idle)
	animateScript.climb.ClimbAnim.AnimationId = "rbxassetid://616156119"--]]    -- Climb
	end
		for i,playerParts in pairs(Char:GetChildren()) do
			if playerParts:IsA("BasePart") then
				P5:SetPartCollisionGroup(playerParts, "Players")
				print("Ran the character added collision")
			end
		end
end


local function OnPlayerAdded(player)
local beginChar
	--Connect the event
	local playerUserId = player.UserId

	local userId = Instance.new("Folder")
	userId.Name = playerUserId
	userId.Parent = plrsFolder

	local gamevals = Instance.new("Folder")
	gamevals.Name = "GameVals"
	gamevals.Parent = player

	local donated = Instance.new("IntValue")
	donated.Name = "Donated"
	donated.Value = 0
	donated.Parent = gamevals

	local totalcollected = Instance.new("IntValue")
	totalcollected.Name = "TotalCollected"
	totalcollected.Value = 0
	totalcollected.Parent = gamevals

	local fastRecharge = Instance.new("BoolValue")
	fastRecharge.Name = "FastRecharge"
	fastRecharge.Value = false
	fastRecharge.Parent = gamevals

	local hasVIP = Instance.new("BoolValue")
	hasVIP.Name = "HasVIP"
	hasVIP.Value = false
	hasVIP.Parent = gamevals

	local TT1hard = Instance.new("StringValue")
	TT1hard.Name = "TT1Hard"
	TT1hard.Value = "0"
	TT1hard.Parent = gamevals

	local TT1norm = Instance.new("StringValue")
	TT1norm.Name = "TT1Norm"
	TT1norm.Value = "0"
	TT1norm.Parent = gamevals

	local canrun = Instance.new("BoolValue")
	canrun.Name = "CanRun"
	canrun.Value = true
	canrun.Parent = gamevals

	local collectedamount = Instance.new("IntValue")
	collectedamount.Name = "CollectedAmount"
	collectedamount.Value = 0
	collectedamount.Parent = gamevals 

	local partyVal = Instance.new("BoolValue")
	partyVal.Value = false
	partyVal.Name = "PartyVal"
	partyVal.Parent = gamevals

	local SoundChange = Instance.new("StringValue")
	SoundChange.Name = "SoundChange"
	SoundChange.Value = ""
	SoundChange.Parent = gamevals

	local OldSound = Instance.new("StringValue")
	OldSound.Name = "OldSound"
	OldSound.Value = "MainTheme"
	OldSound.Parent = gamevals

	local gamevalsCopy = player.GameVals:Clone()
	gamevalsCopy.Parent = plrsFolder:FindFirstChild(playerUserId)

-------------------------------------------------------------------FOUND CREATOR BADGE------------------------------------------------

	local CreatorName = "EmpyZ"
	local foundCreator = false

	if game.Players:FindFirstChild(CreatorName) then
	local Players = game.Players:GetPlayers()
	for i = 1, #Players do
	local Player = Players[i]

	local success, message = pcall(function()
		foundCreator = BadgeService:UserHasBadgeAsync(Player.UserId, foundCreatorId)
	end)

	if not success then
		warn("Error while checking if player has badge: " .. tostring(message))
		return
	end

	if foundCreator == false then
	BadgeService:AwardBadge(Player.UserId, foundCreatorId)
	else
	print(Player.Name.." Already owns the foundCreator badge")
	end
	end
	end

-------------------------------------------------------------END OF FOUND CREATOR BADGE-----------------------------------------------



-----------------------------------------------------------FIRST BADGE AWARDED FOR JOINING-----------------------------------------------------------------

  -- Change this to your badge ID
print("working")

	local function awardBadge(plr)
	    local hasBadge = false
	 
	    -- Check if the player already has the badge
	    local success, message = pcall(function()
	        hasBadge = BadgeService:UserHasBadgeAsync(plr.UserId, badgeID)
	    end)
	 
	    -- If there's an error, issue a warning and exit the function
	    if not success then
	        warn("Error while checking if player has badge: " .. tostring(message))
	        return
	    end
	 
	    if hasBadge == false then
	        BadgeService:AwardBadge(plr.UserId, badgeID)
		else
			print(plr.Name.." Already owns the first join badge")
	    end
	end

awardBadge(player)

------------------------------------------------------END OF FIRST BADGE AWARDED FOR JOINING------------------------------------------

	local function CheckBadge(player)
	    local hasInsaneBadge = false
	 
	    -- Check if the player already has the badge
	    local success, message = pcall(function()
	        hasInsaneBadge = BadgeService:UserHasBadgeAsync(player.UserId, InsaneID)
	    end)
	 
	    -- If there's an error, issue a warning and exit the function
	    if not success then
	        warn("Error while checking if player has badge: " .. tostring(message))
	        return
	    end
	 
	    if hasInsaneBadge == true then
	        return true
		else
			return false
	    end
	end


-------------------reference the players user id for datastore
 
local data

	local success, errormsg = pcall(function()
		 data = DataStore:GetAsync(player.UserId)
	print("got the right player")
	end)

	if data ~= nil then

	if plrsFolder:FindFirstChild(playerUserId).Name == tostring(player.UserId) then

		if data.Donated then
			plrsFolder[player.UserId].GameVals.Donated.Value = data.Donated
			donated.Value = data.Donated
		end

		if data.TotalCollected then
			plrsFolder[player.UserId].GameVals.TotalCollected.Value = data.TotalCollected
			totalcollected.Value = data.TotalCollected
			print(plrsFolder[player.UserId].GameVals.TotalCollected.Value)
		end

		if data.FastRecharge then
			plrsFolder[player.UserId].GameVals.FastRecharge.Value = data.FastRecharge
			fastRecharge.Value = data.FastRecharge
			print(plrsFolder[player.UserId].GameVals.FastRecharge.Value)
		end

		if data.HasVIP then
			plrsFolder[player.UserId].GameVals.HasVIP.Value = data.HasVIP
			hasVIP.Value = data.HasVIP
			print(plrsFolder[player.UserId].GameVals.HasVIP.Value)
		end

		if data.TT1Hard then
			plrsFolder[player.UserId].GameVals.TT1Hard.Value = data.TT1Hard
			TT1hard.Value = data.TT1Hard
			print(plrsFolder[player.UserId].GameVals.TT1Hard.Value)
		end

		if data.TT1Norm then
			plrsFolder[player.UserId].GameVals.TT1Norm.Value = data.TT1Norm
			TT1norm.Value = data.TT1Norm
			print(plrsFolder[player.UserId].GameVals.TT1Norm.Value)
		end

	else

	print(player.Name.." Has no data")

	end
	end


if player.GameVals.FastRecharge.Value == true then
isfast:FireClient(player,fastRecharge.Value)
else 
print(player.Name.." Has the fastrecharge.Value false")
end

	player.CharacterAdded:Connect(CharacterAdded)
	
	--Take care of when it already exists
	local Char = player.Character or player.CharacterAdded:Wait()
	print("Added A Wait")
	if Char then
		CharacterAdded(Char)
		if Char and not Morphs:FindFirstChild(player.Name) then
			print("hey")
			Char.Archivable = true
			beginChar = Char:Clone()
			beginChar.Parent = Morphs
			print("ran")
			end
	end
end -------------------------------------------- ENDING THE PLAYERADDED FUNCTION

--Connect the event
game.Players.PlayerAdded:Connect(OnPlayerAdded)

--Take care of when it already exists
for i,v in pairs(game.Players:GetPlayers()) do
	OnPlayerAdded(v)
end


local function onplayerleave(player)
	local playerUserId = plrsFolder:FindFirstChild(player.UserId)

	if playerUserId.Name == tostring(player.UserId) then

	local data = {} -- userid,donations,totalcollected,etc

	data.TotalCollected = plrsFolder[player.UserId].GameVals.TotalCollected.Value
	data.Donated = plrsFolder[player.UserId].GameVals.Donated.Value
	data.FastRecharge = plrsFolder[player.UserId].GameVals.FastRecharge.Value
	data.HasVIP = plrsFolder[player.UserId].GameVals.HasVIP.Value
	data.TT1Hard = plrsFolder[player.UserId].GameVals.TT1Hard.Value
	data.TT1Norm = plrsFolder[player.UserId].GameVals.TT1Norm.Value

	print(data.Donated)
	print(data.TotalCollected)
	print(data.FastRecharge)
	print(data.HasVIP)
	print(data.TT1Hard)
	print(data.TT1Norm)

	local success,errormsg = pcall(function()
		DataStore:SetAsync(player.UserId,data)
	end)

	if success then
		print("Successfully Saved")
	else
		warn(errormsg)
	end
	end

	if Morphs:FindFirstChild(player.Name) then
		Morphs[player.Name]:Destroy()
		print("Deleted "..player.Name.." From Morphs in replicated storage")
	end
end

game.Players.PlayerRemoving:Connect(onplayerleave)

local RunService = game:GetService("RunService")
  
game:BindToClose(function(save)

        if #game.Players:GetPlayers() <= 1 then return end
		-- will run when the server is about to shutdown
	for i, player in pairs(game.Players:GetPlayers()) do
			local data = {} -- userid,donations,collectedamount,etc
			local playerUserId = plrsFolder:FindFirstChild(player.UserId)

		if playerUserId.Name == tostring(player.UserId) then
		
		data.TotalCollected = plrsFolder[player.UserId].GameVals.TotalCollected.Value
		data.Donated = plrsFolder[player.UserId].GameVals.Donated.Value
		data.FastRecharge = plrsFolder[player.UserId].GameVals.FastRecharge.Value
		data.HasVIP = plrsFolder[player.UserId].GameVals.HasVIP.Value
		data.TT1Hard = plrsFolder[player.UserId].GameVals.TT1Hard.Value
		data.TT1Norm = plrsFolder[player.UserId].GameVals.TT1Norm.Value

print("running the bindtoclose")

	wait(10)

		local success,errormsg = pcall(function()
			DataStore:SetAsync(player.UserId,data)
		end)

		if success then
			print("Successfully Saved")
		else
			warn(errormsg)
		end
		end
	end
end)
