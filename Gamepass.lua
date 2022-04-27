local serverSt = game:GetService("ServerStorage")
local replicatedSt = game:GetService("ReplicatedStorage")

local admins = {"Empyz"}

--local admins = {584556306, 1649655017}

local plrsFldr = serverSt:WaitForChild("Players")

local stamID = 19342212
local vipID = 19342431

local passTBL = {stamID,vipID}
print(passTBL)

local Marketplaceservice = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

local function giveStamPass(player)
	if player.Character then
	player.GameVals.FastRecharge.Value = true
	plrsFldr:FindFirstChild(player.UserId).GameVals.FastRecharge.Value = true
	end
end

local function giveVIP(player)
	if player.Character then
	player.GameVals.HasVIP.Value = true
	local clonedGui = replicatedSt.BillboardGui:Clone()
	clonedGui.Parent = player.Character.Head
	player.Character.Head.BillboardGui.TextLabel.Text = player.Name
	plrsFldr:FindFirstChild(player.UserId).GameVals.HasVIP.Value = true
	end
	player.CharacterAdded:Connect(function(char)
		local clonedGui = replicatedSt.BillboardGui:Clone()
		clonedGui.Parent = player.Character.Head
		player.Character.Head.BillboardGui.TextLabel.Text = player.Name
	end)
end

local function onPlayerAdded(player)
wait(3)
	local hasPass = false

	for i , passIDs in pairs(passTBL) do
	print(passIDs)

	local success,error = pcall(function()
		hasPass = Marketplaceservice:UserOwnsGamePassAsync(player.UserId,passIDs)
	end)
		
	if not success then
		warn("error while checking if played has gamepass")
		return
	end
	
	if hasPass and passIDs == stamID then--and player.GameVals.FastRecharge.Value == true then
	local txtlabel = game.Workspace.Chapter1.BuyRoom.BuyParts.BootsRecharge.buyprompt.SurfaceGui.FrameSpeed
		giveStamPass(player)	
		print(player.Name.." Already owns the stamina pass")
	replicatedSt.textFalse:FireClient(player,txtlabel)
	end

	if hasPass and passIDs == vipID then--and player.GameVals.HasVIP.Value == true  then
	local txtlabel = game.Workspace.Chapter1.BuyRoom.BuyParts.VipLabel.buyprompt.SurfaceGui.FrameVIP
		giveVIP(player)	
		print(player.Name.." Already owns the VIP pass")
	replicatedSt.textFalse:FireClient(player,txtlabel)
	
		local tags = {
			{
				TagText = "S.C.P.", -- Tag
				TagColor = Color3.fromRGB(0, 170, 255) -- VIP Color
			}
		}

		local creator = {			
			{
				TagText = "CREATOR", -- Tag
				TagColor = Color3.fromRGB(255, 0, 0) -- VIP Color
			}
		}
		local ChatService = require(game:GetService("ServerScriptService"):WaitForChild("ChatServiceRunner").ChatService)
		local speaker = nil
		while speaker == nil do
			speaker = ChatService:GetSpeaker(player.Name)
			if speaker ~= nil then break end
			wait(0.01)
			print("waiting")
		end
		print(speaker.Name)
		speaker:SetExtraData("Tags",tags)
		speaker:SetExtraData("ChatColor",Color3.fromRGB(0, 170, 255)) -- Text Color--]]

		if speaker.Name == "EmpyZ" then
		speaker:SetExtraData("Tags",creator)
		speaker:SetExtraData("ChatColor",Color3.fromRGB(255, 0, 0)) -- Text Color--]]
		end

	end
	end

	end


Marketplaceservice.PromptGamePassPurchaseFinished:Connect(function(player,passId,wasPurchased)
	if wasPurchased and passId == stamID and player.GameVals.FastRecharge.Value == true then
	plrsFldr:FindFirstChild(player.UserId).GameVals.FastRecharge.Value = true
	giveStamPass(player)
	player.GameVals.Donated.Value = player.GameVals.Donated.Value + 75
	plrsFldr:FindFirstChild(player.UserId).GameVals.Donated.Value = plrsFldr:FindFirstChild(player.UserId).GameVals.Donated.Value + 75
	print(player.Name.."Purchased the stamina recharge")
	local txtlabel = game.Workspace.Chapter1.BuyRoom.BuyParts.BootsRecharge.buyprompt.SurfaceGui.FrameSpeed
	replicatedSt.textFalse:FireClient(player,txtlabel)
	end
	if wasPurchased and passId == vipID and player.GameVals.HasVIP.Value == true then
	local txtlabel = game.Workspace.Chapter1.BuyRoom.BuyParts.VipLabel.buyprompt.SurfaceGui.FrameVIP
	plrsFldr:FindFirstChild(player.UserId).GameVals.HasVIP.Value = true
	giveVIP(player)
	player.GameVals.Donated.Value = player.GameVals.Donated.Value + 250
	plrsFldr:FindFirstChild(player.UserId).GameVals.Donated.Value = plrsFldr:FindFirstChild(player.UserId).GameVals.Donated.Value + 250
	print(player.Name.."Purchased the Vip Pass")
	replicatedSt.textFalse:FireClient(player,txtlabel)
	end

end)

Players.PlayerAdded:Connect(onPlayerAdded)
