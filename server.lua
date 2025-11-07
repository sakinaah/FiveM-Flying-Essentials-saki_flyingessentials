local faaPlayers = {}

-- Command to toggle FAA duty status
RegisterCommand('faaduty', function(source, args, rawCommand)
    local playerId = source
    local playerName = GetPlayerName(playerId)
    
    if faaPlayers[playerId] then
        -- Player is already on duty, turn off
        faaPlayers[playerId] = nil
        TriggerClientEvent('saki_flyingessentials:toggleFAADuty', playerId, false)
        TriggerClientEvent('saki_flyingessentials:updateFAAPlayers', -1, faaPlayers)
    else
        -- Player is not on duty, turn on
        faaPlayers[playerId] = {
            name = playerName,
            id = playerId
        }
        TriggerClientEvent('saki_flyingessentials:toggleFAADuty', playerId, true)
        TriggerClientEvent('saki_flyingessentials:updateFAAPlayers', -1, faaPlayers)
    end
end, false)

-- Handle player disconnect
AddEventHandler('playerDropped', function()
    local playerId = source
    if faaPlayers[playerId] then
        faaPlayers[playerId] = nil
        TriggerClientEvent('saki_flyingessentials:updateFAAPlayers', -1, faaPlayers)
    end
end)

-- Send current FAA players to a newly connected player
RegisterNetEvent('saki_flyingessentials:requestFAAPlayers')
AddEventHandler('saki_flyingessentials:requestFAAPlayers', function()
    local playerId = source
    TriggerClientEvent('saki_flyingessentials:updateFAAPlayers', playerId, faaPlayers)
end)