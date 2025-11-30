local currentBloodLevel = 0
local lastDamageTime = 0
local isBloodShowing = false

-- Function to show blood effect
local function ShowBloodEffect()
    if not Config.Blood.enabled then return end
    
    currentBloodLevel = math.min(currentBloodLevel + 1, #Config.Blood.images)
    lastDamageTime = GetGameTimer()
    
    SendNUIMessage({
        action = 'ShowBlood',
        image = Config.Blood.images[currentBloodLevel]
    })
    
    isBloodShowing = true
end

-- Function to reset blood level
local function ResetBloodLevel()
    if currentBloodLevel > 0 and (GetGameTimer() - lastDamageTime) >= Config.Blood.resetTime then
        currentBloodLevel = 0
        isBloodShowing = false
    end
end

-- Monitor player health
CreateThread(function()
    local lastHealth = GetEntityHealth(PlayerPedId())
    
    while true do
        Wait(100)
        
        local playerPed = PlayerPedId()
        local currentHealth = GetEntityHealth(playerPed)
        
        -- Check if player took damage
        if currentHealth < lastHealth and currentHealth > 0 then
            ShowBloodEffect()
        end
        
        lastHealth = currentHealth
        
        -- Reset blood level after time
        if isBloodShowing then
            ResetBloodLevel()
        end
    end
end)
