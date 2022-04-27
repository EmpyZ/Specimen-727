local userInputService = game:GetService("UserInputService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local isfast = replicatedStorage:WaitForChild("IsFast")
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local player = players.LocalPlayer
local playergui = player:WaitForChild("PlayerGui")
local maingui = playergui:WaitForChild("MainGUI")
local runbtn = maingui:WaitForChild("RunBtn")

repeat wait() until player.Character
local character = player.Character

repeat wait(2) until player.GameVals.CanRun
local enabled = false

local Fastrecharge = player.GameVals:WaitForChild("FastRecharge")

local bar = playergui.Stamina.Bar

local maxStamina = 1000
local staminaCost = 2

local regen

local staminaRegen
local connection 

local function fastchange()
connection = isfast.OnClientEvent:Connect(function(boolV)
if Fastrecharge.Value == true and boolV == true then
regen = 3
else
regen = 1
end
end)
if connection then
	connection:Disconnect()
end
end

fastchange()

staminaRegen = regen

local sprintSpeed = 30
local walkSpeed = 24

local currentStamina = maxStamina
local percent = playergui.Stamina.TextBox

-- Update Stamina GUI
function updateGui(current, max)
 if character.Humanoid.Health <= 0 then
  playergui.Stamina.Enabled = true
	percent.Text = "100%"
	bar.BackgroundColor3 = Color3.fromRGB(25, 255, 0)
	currentStamina = maxStamina
 end
 
bar.Size = UDim2.new((current / max) * .31, 0, .037, 0)
end

local function sprinting()
	if currentStamina >= staminaCost and character.Humanoid.MoveDirection.Magnitude > 0 then
    character.Humanoid.WalkSpeed = sprintSpeed
	end
end

local function stopsprinting()
	 character.Humanoid.WalkSpeed = walkSpeed
end

runbtn.MouseButton1Click:Connect(function()
if enabled == false then
	enabled = true
		if player.GameVals.CanRun.Value == true then
		runbtn.Visible = false
			print("running the runbtn")
		sprinting()
		wait(5)
			print("Stopped the runbtn")
		runbtn.Visible = true
		stopsprinting()
		else
			character.Humanoid.WalkSpeed = 0
		end
		enabled = false
	end
end)



-- Sprint Key Pressed
userInputService.InputBegan:Connect(function(input)
 if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.ButtonL2 then
 if player.GameVals.CanRun.Value == true then
	sprinting()
	else
		print("gamevsl is false")
  end
 end
end)

-- Sprint Key Released
userInputService.InputEnded:Connect(function(input)
 if player.GameVals.CanRun.Value == true then
 if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.ButtonL2 then
 	stopsprinting()
 end
 else
	character.Humanoid.WalkSpeed = 0
 end
end)



runService.Heartbeat:Connect(function()
if player.GameVals.CanRun.Value == true then
if character.Humanoid.Health >0 then
 if character.Humanoid.WalkSpeed == sprintSpeed then
  if currentStamina >= staminaCost and character.Humanoid.MoveDirection.Magnitude > 0 then
   currentStamina = currentStamina - staminaCost
	local currentNum = currentStamina / 10
	percent.Text = currentStamina / 10 .."%"
	--print(currentStamina - staminaCost)
		if currentNum >= 90 then
			--print("worked")
		bar.BackgroundColor3 = Color3.fromRGB(103, 231, 44)
		elseif currentNum > 80 then
		bar.BackgroundColor3 = Color3.fromRGB(175, 231, 52)
		elseif currentNum > 70 then
		bar.BackgroundColor3 = Color3.fromRGB(184, 213, 56)
		elseif currentNum > 60 then
		bar.BackgroundColor3 = Color3.fromRGB(220, 209, 84)
		elseif currentNum > 50 then
		bar.BackgroundColor3 = Color3.fromRGB(255, 152, 61)
		elseif currentNum > 40 then
		bar.BackgroundColor3 = Color3.fromRGB(255, 99, 52)
		elseif currentNum > 30 then
		bar.BackgroundColor3 = Color3.fromRGB(255, 70, 53)
		elseif currentNum > 20 then
		bar.BackgroundColor3 = Color3.fromRGB(255, 49, 49)
		elseif currentNum > 10 then
		bar.BackgroundColor3 = Color3.fromRGB(226, 0, 0)
		elseif currentNum >= 0 then
		bar.BackgroundColor3 = Color3.fromRGB(185, 0, 0)
	--	else
		--	bar.BackgroundColor3 = Color3.fromRGB(25, 255, 0)
		end
  else
   character.Humanoid.WalkSpeed = walkSpeed
  end
 else
  if currentStamina < maxStamina then
   currentStamina = currentStamina + regen
	percent.Text = currentStamina / 10 .."%"
	local currentNum = currentStamina / 10
	if currentNum == 100 then
		bar.BackgroundColor3 = Color3.fromRGB(25, 255, 0)
		elseif currentNum == 90 then
		bar.BackgroundColor3 = Color3.fromRGB(103, 231, 44)
		elseif currentNum == 80 then
		bar.BackgroundColor3 = Color3.fromRGB(175, 231, 52)
		elseif currentNum == 70 then
		bar.BackgroundColor3 = Color3.fromRGB(184, 213, 56)
		elseif currentNum == 60 then
		bar.BackgroundColor3 = Color3.fromRGB(220, 209, 84)
		elseif currentNum == 50 then
		bar.BackgroundColor3 = Color3.fromRGB(255, 152, 61)
		elseif currentNum == 40 then
		bar.BackgroundColor3 = Color3.fromRGB(255, 99, 52)
		elseif currentNum == 30 then
		bar.BackgroundColor3 = Color3.fromRGB(255, 70, 53)
		elseif currentNum == 20 then
		bar.BackgroundColor3 = Color3.fromRGB(255, 49, 49)
		elseif currentNum == 10 then
		bar.BackgroundColor3 = Color3.fromRGB(226, 0, 0)
		elseif currentNum == 0 then
		bar.BackgroundColor3 = Color3.fromRGB(185, 0, 0)
	end
	if currentStamina >= 1000 then
	--print(currentStamina + staminaRegen)
	percent.Text = "100%"
	end
  elseif currentStamina > maxStamina then
   currentStamina = maxStamina
	percent.Text = "100%"
	--print(maxStamina)
  end
 end
 
 updateGui(currentStamina, maxStamina)
else
	bar.Size = UDim2.new(.31,0,.037,0)
	currentStamina = maxStamina
	percent.Text = "100%"
	bar.BackgroundColor3 = Color3.fromRGB(25, 255, 0)
end
else
character.Humanoid.WalkSpeed = 0
end
end)
