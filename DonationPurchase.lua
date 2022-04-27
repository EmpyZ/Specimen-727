local MarketplaceService = game:GetService("MarketplaceService")
local DataStoreService = game:GetService("DataStoreService")
local serverSt = game:GetService("ServerStorage")

local currencyName = "Donated"

local plrsFolder = serverSt:WaitForChild("Players")

local PreviousPurchases = DataStoreService:GetDataStore("PreviousPurchases")

local one_hundred = 0000000000
local five_hundred = 0000000000
local one_thousand = 0000000000
local twentyFive_hundred = 0000000000
local five_thousand = 0000000000
local ten_thousand = 0000000000
local one_hundred_thousand = 0000000000

MarketplaceService.ProcessReceipt = function(receipt)


		-- Receipt has PurchaseId, ProductId, CurrencySpentValue.CurrencyType, PlaceIdWherePurchased

		local ID = receipt.PlayerId.."-"..receipt.PurchaseId

		local success = nil

		pcall(function()
			success = PreviousPurchases:GetAsync(ID)
		end)

		if success then -- has it already been bought?
			-- Purchase has already been done
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end

		local player = game.Players:GetPlayerByUserId(receipt.PlayerId)
			print(player.UserId)
		local playerUserId = plrsFolder:FindFirstChild(player.UserId)
		if not player then
			-- left, disconnected
			return Enum.ProductPurchaseDecision.NotProcessedYet -- we're going to give their rewards next time they join/next time fired
		else

			if receipt.ProductId == one_hundred then
				--They've bought 75 currency
				player.GameVals[currencyName].Value = player.GameVals[currencyName].Value + 100
				playerUserId.GameVals[currencyName].Value = playerUserId.GameVals[currencyName].Value + 100
			end
			if receipt.ProductId == five_hundred then
				--They've bought 150 currency
				player.GameVals[currencyName].Value = player.GameVals[currencyName].Value + 500
				playerUserId.GameVals[currencyName].Value = playerUserId.GameVals[currencyName].Value + 500
			end
			if receipt.ProductId == one_thousand then
				--They've bought 400 currency
				player.GameVals[currencyName].Value = player.GameVals[currencyName].Value + 1000
				playerUserId.GameVals[currencyName].Value = playerUserId.GameVals[currencyName].Value + 1000
			end
			if receipt.ProductId == twentyFive_hundred then
				--They've bought 1200 currency
				player.GameVals[currencyName].Value = player.GameVals[currencyName].Value + 2500
				playerUserId.GameVals[currencyName].Value = playerUserId.GameVals[currencyName].Value + 2500
			end	
			if receipt.ProductId == five_thousand then
				--They've bought 2000 currency
				player.GameVals[currencyName].Value = player.GameVals[currencyName].Value + 5000
				playerUserId.GameVals[currencyName].Value = playerUserId.GameVals[currencyName].Value + 5000
			end
			if receipt.ProductId == ten_thousand then
				--They've bought 4000 currency
				player.GameVals[currencyName].Value = player.GameVals[currencyName].Value + 10000
				playerUserId.GameVals[currencyName].Value = playerUserId.GameVals[currencyName].Value + 10000
			end
			if receipt.ProductId == one_hundred_thousand then
				--They've bought 4000 currency
				player.GameVals[currencyName].Value = player.GameVals[currencyName].Value + 100000
				playerUserId.GameVals[currencyName].Value = playerUserId.GameVals[currencyName].Value + 100000
			end

			pcall(function()
				PreviousPurchases:SetAsync(ID,true)
			end)
			return Enum.ProductPurchaseDecision.PurchaseGranted

	end
end
