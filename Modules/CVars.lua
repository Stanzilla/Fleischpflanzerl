C_TransmogCollection.SetShowMissingSourceInItemTooltips(false)

local StanUICV = CreateFrame("Frame")
StanUICV:RegisterEvent("VARIABLES_LOADED")
StanUICV:SetScript("OnEvent", function()

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
        CameraZoomOut(100)
end)
