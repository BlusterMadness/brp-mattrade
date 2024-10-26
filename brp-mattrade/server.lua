local QBCore = exports['qb-core']:GetCoreObject()

-- Server-side trade logic for selected material
RegisterNetEvent('brp-mattrade:tradeSelectedMaterial', function(material)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local recyclableAmount = Player.Functions.GetItemByName(Config.RecyclableMaterial)

    if recyclableAmount and recyclableAmount.amount >= Config.RequiredAmount then
        -- Remove recyclable materials from player
        Player.Functions.RemoveItem(Config.RecyclableMaterial, Config.RequiredAmount)

        -- Give the selected material with random quantity
        local rewardAmount = math.random(Config.RewardRange[1], Config.RewardRange[2])
        Player.Functions.AddItem(material, rewardAmount)

        TriggerClientEvent('QBCore:Notify', src, "You traded recyclables for " .. rewardAmount .. " " .. material .. ".", 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have enough recyclable materials.", 'error')
    end
end)
