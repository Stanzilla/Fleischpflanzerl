-- GLOBALS: ChatFrame5

local frame = CreateFrame("Frame")
frame:RegisterEvent("UPDATE_FACTION")
local reps = {}
frame:SetScript("OnEvent", function()
    local name, standingID, bottomValue, topValue, earnedValue, isHeader, _
    local difference
    for factionIndex=1, GetNumFactions() do
        name, _, standingID, bottomValue, topValue, earnedValue, _, _, isHeader = GetFactionInfo(factionIndex)
        if not isHeader then
            if (reps[name]) then
                difference = earnedValue - reps[name]
                if (difference > 0) then
                    --ChatFrame5:AddMessage(format("Reputation with %s increased by %d. (%d remaining until %s)", --long version
                    ChatFrame5:AddMessage(format("%s + %d. (%d until %s)", name, difference, topValue - earnedValue, (standingID == 8) and "max" or _G["FACTION_STANDING_LABEL"..standingID + 1]), 0.5, 0.5, 1)
                elseif (difference < 0) then
                    difference = 0 - difference
                    --ChatFrame5:AddMessage(format("Reputation with %s decreased by %d. (%d remaining until %s)", --long version
                    ChatFrame5:AddMessage(format("%s - %d. (%d until %s)", name, difference,  earnedValue - bottomValue, (standingID == 1) and "min" or _G["FACTION_STANDING_LABEL"..standingID - 1]), 0.5, 0.5, 1)
                end
            end
            reps[name] = earnedValue
        end
    end
end)