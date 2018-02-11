-- luacheck: globals SLASH_GM1 SLASH_RELOAD1 SLASH_PQUIT
-- luacheck: globals ScrollFrameTemplate_OnMouseWheel InterfaceOptionsFrameAddOnsList CinematicFrame CinematicFrame_CancelCinematic InterfaceOptionsFrameAddOns
-- luacheck: globals PaperDollFrame_SetMovementSpeed MovementSpeed_OnUpdate MovementSpeed_OnEnter CharacterStatsPane PAPERDOLL_STATCATEGORIES FramePool_HideAndClearAnchors

--[[ Custom Slash Handlers ]]--
SlashCmdList['RELOAD'] = function() ReloadUI() end
SLASH_RELOAD1 = '/rl'

SlashCmdList['GM'] = function() ToggleHelpFrame() end
SLASH_GM1 = '/gm'

SlashCmdList['PQUIT'] = function() LeaveParty() end
SLASH_PQUIT = '/pquit'

--[[ Dungeon Group Ready Spam ]]--
local frame = CreateFrame("Frame")
frame:RegisterEvent("LFG_PROPOSAL_SHOW")
frame:SetScript("OnEvent", function()
    print("|CFFFF0000----------------------------------------")
    print("|CFFFFFF00Your Dungeon Group is ready!")
    print("|CFFFF0000----------------------------------------")
end)

--[[ Addon Config Scroll Fix ]]--
local function func(self, val)
    ScrollFrameTemplate_OnMouseWheel(InterfaceOptionsFrameAddOnsList, val)
end

for i = 1, #InterfaceOptionsFrameAddOns.buttons do
    local f = _G["InterfaceOptionsFrameAddOnsButton"..i]
    f:EnableMouseWheel()
    f:SetScript("OnMouseWheel", func)
end

--[[ Bypass the buggy cancel cinematic confirmation dialog ]]--
hooksecurefunc(CinematicFrame.closeDialog,"Show",function()
    CinematicFrame.closeDialog:Hide()
    CinematicFrame_CancelCinematic()
end)

-- Stops ADDON_BLOCKED errors when entering combat with your map open.

-- local fu = CreateFrame("Frame")
-- fu:SetScript("OnEvent", function(self, event)
-- 	self:UnregisterEvent(event)
-- 	RefreshWorldMap()
-- end)

-- WorldMapFrame.UIElementsFrame.ActionButton.SetMapAreaID = function(...)
-- 	if InCombatLockdown() then
-- 		fu:RegisterEvent("PLAYER_REGEN_ENABLED")
-- 		return
-- 	end
-- 	WorldMapActionButtonMixin.SetMapAreaID(...)
-- end

-- WorldMapFrame.UIElementsFrame.ActionButton.SetHasWorldQuests = function(...)
-- 	if InCombatLockdown() then
-- 		fu:RegisterEvent("PLAYER_REGEN_ENABLED")
-- 		return
-- 	end
-- 	WorldMapActionButtonMixin.SetHasWorldQuests(...)
-- end

-- orig_WorldMapFrame_UpdateOverlayLocations = WorldMapFrame_UpdateOverlayLocations
-- WorldMapFrame_UpdateOverlayLocations = function()
-- 	if InCombatLockdown() then
-- 		fu:RegisterEvent("PLAYER_REGEN_ENABLED")
-- 		return
-- 	end
-- 	orig_WorldMapFrame_UpdateOverlayLocations()
-- end

-- orig_WorldMapScrollFrame_ResetZoom = WorldMapScrollFrame_ResetZoom
-- WorldMapScrollFrame_ResetZoom = function()
-- 	if InCombatLockdown() then
-- 		fu:RegisterEvent("PLAYER_REGEN_ENABLED")
-- 		return
-- 	end
-- 	orig_WorldMapScrollFrame_ResetZoom()
-- end

-- add the movement speed to the character stat sheet

function PaperDollFrame_SetMovementSpeed(statFrame, unit)
	statFrame.wasSwimming = nil
	statFrame.unit = unit
	MovementSpeed_OnUpdate(statFrame)

	statFrame.onEnterFunc = MovementSpeed_OnEnter
	statFrame:SetScript("OnUpdate", MovementSpeed_OnUpdate)
	statFrame:Show()
end

CharacterStatsPane.statsFramePool.resetterFunc =
	function(pool, frame)
		frame:SetScript("OnUpdate", nil)
		frame.onEnterFunc = nil
		frame.UpdateTooltip = nil
		FramePool_HideAndClearAnchors(pool, frame)
	end
table.insert(PAPERDOLL_STATCATEGORIES[1].stats, { stat = "MOVESPEED"})