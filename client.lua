local QBCore = exports['qb-core']:GetCoreObject()

local dumpsters = {}

CreateThread(function()
    for _, model in pairs(Config.Dumpsters) do
        exports['qb-target']:AddTargetModel(model, {
            options = {
                {
                    type = "client",
                    event = "qb-dumpsterdive:startSearch",
                    icon = "fas fa-trash",
                    label = "Search Dumpster",
                },
            },
            distance = 2.0
        })
    end
end)

RegisterNetEvent("qb-dumpsterdive:startSearch", function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local foundDumpster = nil
    local dumpsterID = nil

    for _, dumpsterModel in pairs(Config.Dumpsters) do
        local dumpster = GetClosestObjectOfType(playerCoords.x, playerCoords.y, playerCoords.z, 2.0, dumpsterModel, false, false, false)
        if dumpster ~= 0 then
            foundDumpster = dumpster
            if DoesEntityExist(dumpster) then
                -- Start animation: Searching dumpster
                TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_BUM_WASH", 0, true) -- Customize the animation as needed
                -- Ensure the object is networked
                NetworkRegisterEntityAsNetworked(dumpster)
                dumpsterID = ObjToNet(dumpster)
            else
                print("Dumpster is not valid!")
            end
            break
        end
    end

    if foundDumpster then
        QBCore.Functions.Progressbar("dumpster_dive", "Searching Dumpster...", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
            TriggerServerEvent("qb-dumpsterdive:startSearch", dumpsterID)
        end, function()
            QBCore.Functions.Notify("Search Cancelled!", "error")
        end)
    else
        QBCore.Functions.Notify("No dumpster nearby!", "error")
    end
end)

