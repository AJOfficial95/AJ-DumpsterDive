local QBCore = exports['qb-core']:GetCoreObject()
local dumpsterCooldown = {}

RegisterServerEvent("qb-dumpsterdive:startSearch")
AddEventHandler("qb-dumpsterdive:startSearch", function(dumpsterID)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    -- Cooldown check to prevent frequent searches
    if dumpsterCooldown[dumpsterID] and dumpsterCooldown[dumpsterID] > os.time() then
        TriggerClientEvent("QBCore:Notify", src, "This dumpster was recently searched!", "error")
        return
    end

    -- Set the cooldown for this dumpster
    dumpsterCooldown[dumpsterID] = os.time() + Config.Cooldown
    TriggerClientEvent("qb-dumpsterdive:searchAnimation", src)  -- Trigger the animation on the client side

    -- Shorter wait time before showing the notification
    Citizen.Wait(500)  -- Reduced wait time (half a second)

    -- Randomly determine the number of items found (between 1 and 3)
    local numItems = math.random(1, 3)
    local itemsFound = {}

    -- Loop through and determine which items are found
    for i = 1, numItems do
        local item = Config.LootTable[math.random(#Config.LootTable)]

        -- Check the chance of finding the item, if no chance is defined, the item is guaranteed
        if not item.chance or math.random(1, 100) <= item.chance then
            local amount = math.random(item.min, item.max)
            Player.Functions.AddItem(item.item, amount)  -- Add the item to the player's inventory
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.item], 'add', amount)  -- Show the item in the UI
            table.insert(itemsFound, amount .. "x " .. QBCore.Shared.Items[item.item].label)  -- Add the item to the list of found items
        end
    end

    -- Notify the player of the items they found
    if #itemsFound > 0 then
        TriggerClientEvent("QBCore:Notify", src, "You found: " .. table.concat(itemsFound, ", "), "success")
    else
        TriggerClientEvent("QBCore:Notify", src, "The dumpster was empty!", "error")
    end
end)
