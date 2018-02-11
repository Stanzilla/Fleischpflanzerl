-- luacheck: globals ChatFrame5 C_Reputation

local frame = CreateFrame("Frame")
frame:RegisterEvent("UPDATE_FACTION")
local reps = {}
frame:SetScript("OnEvent", function()
    local difference
    for factionIndex=1, GetNumFactions() do
        local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader,
        isCollapsed, hasRep, isWatched, isChild, factionID, hasBonusRepGain, canBeLFGBonus = GetFactionInfo(factionIndex)
        if C_Reputation.IsFactionParagon(factionIndex) then
            local currentValue, threshold = C_Reputation.GetFactionParagonInfo(factionIndex)
            barMin, barMax, barValue = 0, threshold, currentValue
        end
        if not isHeader and name then
            if (reps[name]) then
                difference = barValue - reps[name]
                if (difference > 0) then
                    --ChatFrame5:AddMessage(format("Reputation with %s increased by %d. (%d remaining until %s)", --long version
                    ChatFrame5:AddMessage(format("%s + %d. (%d until %s)", name, difference, barMax - barValue, (standingID == 8) and "max" or _G["FACTION_STANDING_LABEL"..standingID + 1]), 0.5, 0.5, 1)
                elseif (difference < 0) then
                    difference = 0 - difference
                    --ChatFrame5:AddMessage(format("Reputation with %s decreased by %d. (%d remaining until %s)", --long version
                    ChatFrame5:AddMessage(format("%s - %d. (%d until %s)", name, difference,  barValue - barMin, (standingID == 1) and "min" or _G["FACTION_STANDING_LABEL"..standingID - 1]), 0.5, 0.5, 1)
                end
            end
            reps[name] = barValue
        end
    end
end)
