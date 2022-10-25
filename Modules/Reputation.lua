-- luacheck: globals ChatFrame5 C_Reputation CreateAtlasMarkup ViragDevTool_AddData

local reps = {}
local paragonReps = {}
local paragonBagIcon = CreateAtlasMarkup("ParagonReputation_Bag")

local loginFrame = CreateFrame("Frame")
loginFrame:RegisterEvent("PLAYER_LOGIN")
loginFrame:SetScript("OnEvent", function()
    for factionIndex = 1, GetNumFactions() do
        local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild, factionID, hasBonusRepGain, canBeLFGBonus =
            GetFactionInfo(factionIndex)
        if not isHeader and name then
            if C_Reputation and C_Reputation.IsFactionParagon(factionID) then
                local currentValue, threshold, _, hasRewardPending = C_Reputation.GetFactionParagonInfo(factionID)
                while currentValue > threshold do
                    currentValue = currentValue - threshold
                end
                paragonReps[name] = currentValue
            end
        end
    end
    if IsAddOnLoaded("ViragDevTool") then
        ViragDevTool_AddData(paragonReps, "paragonReps")
    end
end)

local frame = CreateFrame("Frame")
frame:RegisterEvent("UPDATE_FACTION")
frame:SetScript("OnEvent", function()
    local difference
    for factionIndex = 1, GetNumFactions() do
        local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild, factionID, hasBonusRepGain, canBeLFGBonus =
            GetFactionInfo(factionIndex)
        if not isHeader and name then
            if reps[name] then
                difference = barValue - reps[name]
                if C_Reputation and C_Reputation.IsFactionParagon(factionID) then
                    local currentValue, threshold, _, hasRewardPending = C_Reputation.GetFactionParagonInfo(factionID)
                    while currentValue > threshold do
                        currentValue = currentValue - threshold
                    end
                    if paragonReps[name] and paragonReps[name] < currentValue then
                        ChatFrame5:AddMessage(format("%s + %d. (%d until Supplies)", name, currentValue - paragonReps[name], threshold - currentValue), 0.5, 0.5, 1)
                    end
                    if paragonReps[name] and hasRewardPending then
                        ChatFrame5:AddMessage(format("%s %s Supplies available!", name, paragonBagIcon), 0.5, 0.5, 1)
                    else
                        paragonReps[name] = currentValue
                    end
                elseif difference > 0 then
                    ChatFrame5:AddMessage(
                        format("%s + %d. (%d until %s)", name, difference, barMax - barValue, (standingID == 8) and "max" or _G["FACTION_STANDING_LABEL" .. standingID + 1]),
                        0.5,
                        0.5,
                        1
                    )
                elseif difference < 0 then
                    difference = 0 - difference
                    ChatFrame5:AddMessage(
                        format("%s - %d. (%d until %s)", name, difference, barValue - barMin, (standingID == 1) and "min" or _G["FACTION_STANDING_LABEL" .. standingID - 1]),
                        0.5,
                        0.5,
                        1
                    )
                end
            end
            reps[name] = barValue
        end
    end
end)
