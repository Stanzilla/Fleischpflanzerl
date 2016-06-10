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

local function func(self, val) ScrollFrameTemplate_OnMouseWheel(InterfaceOptionsFrameAddOnsList, val) end

for i=1,#InterfaceOptionsFrameAddOns.buttons do
	local f = _G["InterfaceOptionsFrameAddOnsButton"..i]
	f:EnableMouseWheel()
	f:SetScript("OnMouseWheel", func)
end

--[[ Bypass the buggy cancel cinematic confirmation dialog ]]--

hooksecurefunc(CinematicFrame.closeDialog,"Show",function()
	CinematicFrame.closeDialog:Hide()
	CinematicFrame_CancelCinematic()
end)
