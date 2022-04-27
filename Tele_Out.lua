local replicatedSt = game:GetService("ReplicatedStorage")

local mainlobby = workspace:WaitForChild("MainLobby")

local touchwallsGo = mainlobby:WaitForChild("TouchWallsGo")

local touchwallsBack = mainlobby:WaitForChild("TouchWallsBack")

local touched = false

local VipTrue = Instance.new("StringValue")
VipTrue.Name = "VipTrue"
VipTrue.Value = ""

for i , touchwalls in pairs(touchwallsGo:GetChildren()) do
	touchwalls.Touched:Connect(function(hit)
		local player = game.Players:GetPlayerFromCharacter(hit.Parent) or game.Players:GetPlayerFromCharacter(hit.Parent.Parent)
		if player and not player:FindFirstChild("VipTrue") and player.Character and touchwalls.Name ~= "VipTouchWall" and touched == false then
			touched = true
			player.Character.HumanoidRootPart.CFrame = game.Workspace.Spawns[touchwalls.Spawn.Value].CFrame + Vector3.new(0,5,0)
			wait(.075)
			touched = false
		elseif player and player.GameVals.HasVIP.Value == true and not player:FindFirstChild("VipTrue") and player.Character and touchwalls.Name == "VipTouchWall" and touched == false then
			local clonedVip = VipTrue:Clone()
			touched = true
			clonedVip.Parent = player
			replicatedSt.SetGravity:FireClient(player)
			replicatedSt.EnableVIPBtn:FireClient(player,true)
			player.Character.HumanoidRootPart.CFrame = game.Workspace.Spawns.VipSpawnBack.CFrame + Vector3.new(0,5,0)
			wait(.075)
			touched = false
		end
	end)
end


for i , touchwalls in pairs(touchwallsBack:GetChildren()) do
	touchwalls.Touched:Connect(function(hit)
		local player = game.Players:GetPlayerFromCharacter(hit.Parent) or game.Players:GetPlayerFromCharacter(hit.Parent.Parent)
		if player and player.Character and touchwalls.Name ~= "VipTouchWall" and touched == false then
			player.Character.HumanoidRootPart.CFrame = game.Workspace.Spawns.MainSpawn.CFrame + Vector3.new(0,5,0)
			wait(.075)
			touched = false
		end
	end)
end


replicatedSt.backtoLobby.OnServerEvent:Connect(function(player)
	if player.Character and player:FindFirstChild("VipTrue")then
	player.Character.HumanoidRootPart.CFrame = game.Workspace.Spawns.MainSpawn.CFrame + Vector3.new(0,5,0)
	player.VipTrue:Destroy()
	end
end)
