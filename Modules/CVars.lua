local StanUICV = CreateFrame("Frame")
StanUICV:RegisterEvent("VARIABLES_LOADED")
StanUICV:SetScript("OnEvent", function()
        C_TransmogCollection.SetShowMissingSourceInItemTooltips(true)
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
        CameraZoomOut(100)
end)

-- Disable 8.0 XML warnings
UIParent:UnregisterEvent("LUA_WARNING")
local f = CreateFrame("Frame")
f:SetScript("OnEvent",
function(f, ev, warnType, warnMessage)
    if warnMessage:match("^Couldn't open") or warnMessage:match("^Error loading") or warnMessage:match("^%(null%)") then
        return
    end
    geterrorhandler()(warnMessage)
end)
f:RegisterEvent("LUA_WARNING")

-- https://www.townlong-yak.com/bugs/afKy4k-HonorFrameLoadTaint
-- luacheck: globals UIDROPDOWNMENU_VALUE_PATCH_VERSION UIDROPDOWNMENU_MAXLEVELS UIDROPDOWNMENU_MAXBUTTONS
if (UIDROPDOWNMENU_VALUE_PATCH_VERSION or 0) < 2 then
	UIDROPDOWNMENU_VALUE_PATCH_VERSION = 2
	hooksecurefunc("UIDropDownMenu_InitializeHelper", function()
		if UIDROPDOWNMENU_VALUE_PATCH_VERSION ~= 2 then
			return
		end
		for i=1, UIDROPDOWNMENU_MAXLEVELS do
			for j=1, UIDROPDOWNMENU_MAXBUTTONS do
				local b = _G["DropDownList" .. i .. "Button" .. j]
				if not (issecurevariable(b, "value") or b:IsShown()) then
					b.value = nil
					repeat
						j, b["fx" .. j] = j + 1, nil
					until issecurevariable(b, "value")
				end
			end
		end
	end)
end