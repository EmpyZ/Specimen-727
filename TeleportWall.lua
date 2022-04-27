local Allplayers = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local replicatedSt = game:GetService("ReplicatedStorage")
local BadgeService = game:GetService("BadgeService")
local teleportEventGui = replicatedSt:WaitForChild("TeleportEventGui")
local chapterMap = 8157483468  ----------------------- Change to placeid
local badgeID = 2124770968

local ship = script.Parent
local teleWall = ship:WaitForChild("TeleWall")
local telepad = ship:WaitForChild("Telepad")
local canTouch = teleWall:WaitForChild("CanTouch")
local timeamount = ship:WaitForChild("TimeAmount")
local teleportTime = timeamount:WaitForChild("gui")
local waitingtotele = ship:WaitForChild("WaitingToTeleport")
local waitinggui = waitingtotele:WaitForChild("gui")
local playerstoTele = waitinggui:WaitForChild("amount")
local teleporting = waitinggui:WaitForChild("teleporting")
local playerstoTeleTitle = waitinggui:WaitForChild("title")
local touched = false
local readyPlayers = {}

replicatedSt.leftReady.OnServerEvent:Connect(function(player) -- this function removes the player from the ready table
--print(readyPlayers)
	for i, p in pairs(readyPlayers) do
		if player.UserId == p.UserId then
			readyPlayers[i] = nil
			print("Removed"..p.Name.." From Chapter 1 Easy table")
			--print(readyPlayers)
			playerstoTele.Text = #readyPlayers
			player.GameVals.PartyVal.Value = false
			p.Character.HumanoidRootPart.CFrame = game.Workspace.Spawns.EventMiddle.CFrame + Vector3.new(0,5,0)
		end
	end
end)

replicatedSt.DiedInParty.OnServerEvent:Connect(function(player)
	--print(readyPlayers)
	for i, p in pairs(readyPlayers) do
		if player.UserId == p.UserId and table.find(readyPlayers,player) then
			readyPlayers[i] = nil
			print("Removed"..p.Name.." From Chapter 1 Easy table")
			--print(readyPlayers)
			playerstoTele.Text = #readyPlayers
			player.GameVals.PartyVal.Value = false
		end
	end
end)

local function onplayerleave(player)
	for i, p in pairs(readyPlayers) do
		if player.UserId == p.UserId then
			readyPlayers[i] = nil
			print("Removed"..p.Name.." From chapter 1 easy table")
		--print(readyPlayers)
		playerstoTele.Text = #readyPlayers
	end
	end
end

	local function CheckBadge(player)
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


teleWall.Touched:Connect(function(hit)
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)
	if #readyPlayers <5 then   -- change to the num of players to join [MAX AMOUNT OF #PLAYERS]
		if canTouch.Value == true then
			if touched == false then
				touched = true
				if player and not table.find(readyPlayers,player) and player.GameVals:FindFirstChild("PartyVal").Value == false then --and CheckBadge(player) == true then
					replicatedSt.leavebtn:FireClient(player,true) -- leavebtn is now enabled
					print(player.Name.." Touched the part")
					player.Character.HumanoidRootPart.CFrame = telepad.CFrame + Vector3.new(0,5,0)
					table.insert(readyPlayers,player)
					player.GameVals.PartyVal.Value = true
					playerstoTele.Text = #readyPlayers  -- adding players to table, increasing playerstoTele text by the #of players 
					wait(.25)
					touched = false
				end
				touched = false
			end
		end
	end
end)

-------------------------------------------------F O R    T E L E P O R T I N G-------------------------------------------------------

local function runtime()
	teleporting.Visible = false
	playerstoTele.Visible = true
	playerstoTeleTitle.Visible = true
	canTouch.Value = true
	for i = 20,0,-1 do
		teleportTime.amount.Text = i
		wait(1)
	if i == 1 then
		canTouch.Value = false
	end
		if i == 0 then
			for i, players in pairs(readyPlayers) do
				local success, result = pcall(function()
					local serverCode = TeleportService:ReserveServer(chapterMap)
			  		return TeleportService:TeleportToPrivateServer(chapterMap,serverCode,readyPlayers) ----- disable for studio, unless testing for roblox game
				end)
				if success then
					for i , plrs in pairs(readyPlayers) do
						if plrs and plrs.GameVals:FindFirstChild("PartyVal") then
						replicatedSt.leavebtn:FireClient(plrs,false) -- leave btn becomes false and teleporting starts
						teleporting.Visible = true
						playerstoTele.Visible = false
						playerstoTeleTitle.Visible = false
						replicatedSt.stopMovement:FireClient(plrs) -- stops the movement of all players
						teleportEventGui:FireClient(plrs,replicatedSt.WinterGui) 
							print("Successfully teleported the party")
						end
					end
				repeat wait(.25) until #readyPlayers == 0
				else
					for i , plrs in pairs(readyPlayers) do
						if plrs and plrs.GameVals:FindFirstChild("PartyVal") then
						replicatedSt.leavebtn:FireClient(plrs,false) -- leave btn becomes false there was an error while teleporting
							replicatedSt.retry:FireClient(plrs,true) -- teleport failed, retry message appears and teleports players back to EventMiddle
							plrs.Character.HumanoidRootPart.CFrame = game.Workspace.Spawns.EventMiddle.CFrame + Vector3.new(0,5,0)
							warn(result)
						end
					end
				end--]]
			end
			playerstoTele.Visible = true
			playerstoTeleTitle.Visible = true
			wait(1)
			print(readyPlayers)
			for i, p in pairs(readyPlayers) do
				readyPlayers[i] = nil
				print("Removed"..p.Name.." From Chapter 1 Easy table")
				p.GameVals.PartyVal.Value = false
				print(readyPlayers)
			end
			playerstoTele.Text = #readyPlayers -- num of players active should go back to 0
			return runtime()
		end
	end
end

Allplayers.PlayerRemoving:Connect(onplayerleave)


runtime()
