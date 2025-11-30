local currentBloodLevel = 0
local lastDamageTime = 0

-- Function to show blood effect
local function ShowBloodEffect()
    if not Config.Blood.enabled then return end
    
    currentBloodLevel = math.min(currentBloodLevel + 1, #Config.Blood.images)
    lastDamageTime = GetGameTimer()
    
    SendNUIMessage({
        action = 'ShowBlood',
        image = Config.Blood.images[currentBloodLevel]
    })
end

-- Function to reset blood level
local function ResetBloodLevel()
    currentBloodLevel = 0
end

-- Event handler for player damage
AddEventHandler('gameEventTriggered', function(event, data)
    if event == 'CEventNetworkEntityDamage' then
        local victim = data[1]
        local attacker = data[2]
        local isDead = data[4]
        
        -- Check if the victim is the local player and not dead
        if victim == PlayerPedId() and not isDead then
            ShowBloodEffect()
            
            -- Check if we need to reset blood level
            local currentTime = GetGameTimer()
            if (currentTime - lastDamageTime) >= Config.Blood.resetTime then
                ResetBloodLevel()
            end
        end
    end
end)
