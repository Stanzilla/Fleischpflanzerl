--[[ Custom Slash Handlers ]]--

	SlashCmdList['FRAME'] = function() ChatFrame1:AddMessage(GetMouseFocus():GetName()) end
	SLASH_FRAME1 = '/frame'

	SlashCmdList['RELOAD'] = function() ReloadUI() end
	SLASH_RELOAD1 = '/rl'

	SlashCmdList['GM'] = function() ToggleHelpFrame() end
	SLASH_GM1 = '/gm'

--[[ Dungeon Group Ready Spam ]]--

	local frame = CreateFrame("Frame")  
	frame:RegisterEvent("LFG_PROPOSAL_SHOW")  
	frame:SetScript("OnEvent", function()  
		print("|CFFFF0000------------------------------------------")
		print("|CFFFFFF00Your Dungeon Group is ready now!")
		print("|CFFFF0000------------------------------------------")
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

-- fixes the issue with InterfaceOptionsFrame_OpenToCategory not actually opening the Category (and not even scrolling to it)
-- Confirmed still broken in Mists of Pandaria as of build 16016 (5.0.4) 
do
	local doNotRun = false
	local function get_panel_name(panel)
		local cat = INTERFACEOPTIONS_ADDONCATEGORIES
		if ( type(panel) == "string" ) then
			for i, p in pairs(cat) do
				if p.name == panel then
					if p.parent then
						return get_panel_name(p.parent)
					else
						return panel
					end
				end
			end
		elseif ( type(panel) == "table" ) then
			for i, p in pairs(cat) do
				if p == panel then
					if p.parent then
						return get_panel_name(p.parent)
					else
						return panel.name
					end
				end
			end
		end
	end

	local function InterfaceOptionsFrame_OpenToCategory_Fix(panel)
		if InCombatLockdown() then return end
		if doNotRun then return end
		local panelName = get_panel_name(panel);
		if not panelName then return end -- if its not part of our list return early
		local noncollapsedHeaders = {}
		local shownpanels = 0
		local mypanel 
		local t = {}
		for i, panel in ipairs(INTERFACEOPTIONS_ADDONCATEGORIES) do
			if not panel.parent or noncollapsedHeaders[panel.parent] then
				if panel.name == panelName then
					panel.collapsed = true
					t.element = panel
					InterfaceOptionsListButton_ToggleSubCategories(t)
					noncollapsedHeaders[panel.name] = true
					mypanel = shownpanels + 1
				end
				if not panel.collapsed then
					noncollapsedHeaders[panel.name] = true
				end
				shownpanels = shownpanels + 1
			end
		end
		local Smin, Smax = InterfaceOptionsFrameAddOnsListScrollBar:GetMinMaxValues()
		InterfaceOptionsFrameAddOnsListScrollBar:SetValue((Smax/(shownpanels-15))*(mypanel-2))
		doNotRun = true
		InterfaceOptionsFrame_OpenToCategory(panel)
		doNotRun = false
	end
	hooksecurefunc("InterfaceOptionsFrame_OpenToCategory", InterfaceOptionsFrame_OpenToCategory_Fix)
end