QBCore = exports['qb-core']:GetCoreObject()

function EnumerateVehicles()
    return coroutine.wrap(function()
        local findHandle, veh = FindFirstVehicle()
        local success
        repeat
            coroutine.yield(veh)
            success, veh = FindNextVehicle(findHandle)
        until not success
        EndFindVehicle(findHandle)
    end)
end

RegisterNetEvent("qb-trafficbomb:Client:UseTrafficBomb")
AddEventHandler("qb-trafficbomb:Client:UseTrafficBomb", function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    local hackedCount = 0

    for vehicle in EnumerateVehicles() do
        local vehicleCoords = GetEntityCoords(vehicle)
        if #(coords - vehicleCoords) < 100 then
            local driver = GetPedInVehicleSeat(vehicle, -1)

            if driver ~= ped then
                if driver == 0 then
                    driver = CreateRandomPedAsDriver(vehicle, true)
                    SetBlockingOfNonTemporaryEvents(driver, true)
                end

                SetEntityAsMissionEntity(vehicle, true, true)
                SetVehicleEngineOn(vehicle, true, true, false)
                TaskVehicleDriveToCoordLongrange(driver, vehicle, coords.x, coords.y, coords.z, 100.0, 16777216, 2.0)
                SetPedKeepTask(driver, true)
                SetEntityAsMissionEntity(vehicle, false, false)

                if driver ~= 0 then
                    hackedCount = hackedCount + 1
                end
            end
        end
    end

    QBCore.Functions.Notify(tostring(hackedCount) .. " véhicules piratés !", "danger")
end)


-- ======================================================================================

-- QBCore = exports['qb-core']:GetCoreObject()

-- function EnumerateVehicles()
--     return coroutine.wrap(function()
--         local findHandle, veh = FindFirstVehicle()
--         local success
--         repeat
--             coroutine.yield(veh)
--             success, veh = FindNextVehicle(findHandle)
--         until not success
--         EndFindVehicle(findHandle)
--     end)
-- end

-- RegisterNetEvent("qb-trafficbomb:Client:UseTrafficBomb")
-- AddEventHandler("qb-trafficbomb:Client:UseTrafficBomb", function()
--     local ped = PlayerPedId()
--     local coords = GetEntityCoords(ped)

--     for vehicle in EnumerateVehicles() do
--         local vehicleCoords = GetEntityCoords(vehicle)
--         if #(coords - vehicleCoords) < 100 then
--             local driver = GetPedInVehicleSeat(vehicle, -1)

--             if driver == 0 then
--                 driver = CreateRandomPedAsDriver(vehicle, true)
--                 SetBlockingOfNonTemporaryEvents(driver, true)
--             end

--             SetEntityAsMissionEntity(vehicle, true, true)
--             TaskVehicleDriveToCoordLongrange(driver, vehicle, coords.x, coords.y, coords.z, 300.0, 16777216, 2.0)
--             SetVehicleEngineOn(vehicle, true, true, false)
--             SetPedKeepTask(driver, true)

--             SetEntityAsMissionEntity(vehicle, false, false)
--         end
--     end

--     QBCore.Functions.Notify("You have used a Traffic Bomb!", "success")
-- end)
