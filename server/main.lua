QBCore = exports['qb-core']:GetCoreObject()

local trafficBombItem = {
    name = "trafficbomb",
    label = "Appareil bombe bouchons",
    weight = 200,
    type = 'item',
    image = 'shell_device.png',
    unique = true,
    useable = true,
    shouldClose = true,
    description = "Un appareil qui pirate tous les voitures a proximité et les fait foncer sur un même point GPS a la vitesse maximale.",
}

exports['qb-core']:AddItem('trafficbomb', trafficBombItem)

-- RegisterServerEvent("qb-trafficbomb:UseTrafficBomb")
-- AddEventHandler("qb-trafficbomb:UseTrafficBomb", function()
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)
    
--     if Player.Functions.GetItemByName('trafficbomb') then
--         TriggerClientEvent("qb-trafficbomb:Client:UseTrafficBomb", src)
--         Player.Functions.RemoveItem('trafficbomb', 1)
--     end
-- end)

QBCore.Functions.CreateUseableItem("trafficbomb", function(source)
    -- local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("qb-trafficbomb:Client:UseTrafficBomb", source)
end)