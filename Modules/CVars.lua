local addonName, Fleischpflanzerl = ...

local StanUICV = CreateFrame("Frame")
StanUICV:RegisterEvent("VARIABLES_LOADED")
StanUICV:SetScript("OnEvent", function()
    if Fleischpflanzerl.IsRetail() then
        -- C_TransmogCollection.SetShowMissingSourceInItemTooltips(true)
        SetCVar("fstack_preferParentKeys", 0)
    end
    SetCVar("minimumAutomaticUiScale", 0.64)
    SetCVar("Autointeract", 0)
    SetCVar("cameraDistanceMaxZoomFactor", 2.6) -- Sets the factor by which cameraDistanceMax is multiplied.
    SetCVar("ShowClassColorInNameplate", 1) -- Turns on class coloring in nameplates.
    SetCVar("screenshotQuality", 10) -- Screenshot quality (0-10)
    SetCVar("useUiScale", 0) -- Turns off UI scaling
    SetCVar("checkAddonVersion", 0) -- Load out-of-date addons
    SetCVar("autoLootDefault", 1) -- Enable autolooting
    SetCVar("profanityFilter", 0)
    SetCVar("BlockTrades", 0)
    SetCVar("cameraSmoothTrackingStyle", 0)
    SetCVar("colorChatNamesByClass", 1) -- no UI
    SetCVar("violenceLevel", 5) -- no UI
    SetCVar("gameTip", 0)
    SetCVar("UnitNameOwn", 1)
    SetCVar("UnitNameGuildTitle", 0)
    SetCVar("UnitNamePlayerGuild", 0)
    SetCVar("UnitNamePlayerPVPTitle", 0)
    SetCVar("SkyCloudLOD", 3)
    SetCVar("nameplateMotion", 1)
    SetCVar("nameplatePersonalShowInCombat", 0)
    SetCVar("nameplatePersonalShowAlways", 0)
    SetCVar("nameplatePersonalShowWithTarget", 0)
    SetCVar("nameplateShowAll", 1)
    SetCVar("nameplateOccludedAlphaMult", 0.1)
    CameraZoomOut(100)
end)

-- Disable 8.0 XML warnings
UIParent:UnregisterEvent("LUA_WARNING")
local f = CreateFrame("Frame")
f:SetScript("OnEvent", function(f, ev, warnType, warnMessage)
    if warnMessage:match("^Couldn't open") or warnMessage:match("^Error loading") or warnMessage:match("^%(null%)") then
        return
    end
    geterrorhandler()(warnMessage)
end)
f:RegisterEvent("LUA_WARNING")
