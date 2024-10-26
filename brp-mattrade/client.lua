local QBCore = exports['qb-core']:GetCoreObject()

-- Load ped model
function LoadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
end

-- Create blip for the ped location
function CreateBlip()
    if Config.ShowBlip then
        local blip = AddBlipForCoord(Config.PedLocation.x, Config.PedLocation.y, Config.PedLocation.z)
        SetBlipSprite(blip, Config.BlipSettings.BlipId)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, Config.BlipSettings.BlipScale)
        SetBlipColour(blip, Config.BlipSettings.BlipColor)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.BlipSettings.BlipText)
        EndTextCommandSetBlipName(blip)
    end
end

-- Create ped at the defined location and make it hold a clipboard
CreateThread(function()
    LoadModel(Config.PedModel)

    local ped = CreatePed(4, GetHashKey(Config.PedModel), Config.PedLocation.x, Config.PedLocation.y, Config.PedLocation.z - 1.0, Config.PedLocation.w, false, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)

    -- Make ped perform the clipboard scenario
    TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_CLIPBOARD', 0, true)

    -- Create blip
    CreateBlip()
end)

-- qb-target zone for ped interaction
CreateThread(function()
    exports['qb-target']:AddTargetModel(Config.PedModel, {
        options = {
            {
                label = "Trade Recyclables",
                icon = "fas fa-recycle",
                action = function()
                    OpenMaterialTradeMenu()
                end
            }
        },
        distance = 2.5
    })
end)

-- Function to open qb-menu with materials
function OpenMaterialTradeMenu()
    local tradeOptions = {}

    for i = 1, #Config.Materials do
        table.insert(tradeOptions, {
            header = Config.Materials[i]:gsub("^%l", string.upper),
            txt = "Trade 100 recyclable materials for a random amount of " .. Config.Materials[i],
            params = {
                event = "brp-mattrade:selectMaterial",
                args = {
                    material = Config.Materials[i]
                }
            }
        })
    end

    exports['qb-menu']:openMenu(tradeOptions)
end

-- Handle material selection from qb-menu
RegisterNetEvent('brp-mattrade:selectMaterial', function(data)
    TriggerServerEvent('brp-mattrade:tradeSelectedMaterial', data.material)
end)
