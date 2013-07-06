--[[ Revert some globals and settings back to the pre-3.3.5 defaults 

for i=1,NUM_CHAT_WINDOWS do
	local tab = _G["ChatFrame"..i.."Tab"]
	tab.noMouseAlpha = 0
	tab:SetAlpha(0)
end

CHAT_FRAME_FADE_OUT_TIME = 0
-- Seconds to wait before fading out chat frames the mouse moves out of.
-- Default is 2.

CHAT_TAB_HIDE_DELAY = 0
-- Seconds to wait before fading out chat tabs the mouse moves out of.
-- Default is 1.

CHAT_FRAME_TAB_SELECTED_MOUSEOVER_ALPHA = 1
CHAT_FRAME_TAB_SELECTED_NOMOUSE_ALPHA = 0
-- Opacity of the currently selected chat tab.
-- Defaults are 1 and 0.4.

CHAT_FRAME_TAB_ALERTING_MOUSEOVER_ALPHA = 1
CHAT_FRAME_TAB_ALERTING_NOMOUSE_ALPHA = 0
-- Opacity of currently alerting chat tabs.
-- Defaults are 1 and 1.

CHAT_FRAME_TAB_NORMAL_MOUSEOVER_ALPHA = 1
CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA = 0
-- Opacity of non-selected, non-alerting chat tabs.
-- Defaults are 0.6 and 0.2.
]]--

--[[  Profanity Filter Disabler 
local frame = CreateFrame("FRAME", "DisableProfanityFilter")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
local function eventHandler(self, event, ...)
	BNSetMatureLanguageFilter(false)
	frame:UnregisterEvent("PLAYER_ENTERING_WORLD")
end
frame:SetScript("OnEvent", eventHandler)
]]--

--[[ Fix the broken ass fading of the chat frames ]]--
hooksecurefunc("FCF_FadeOutChatFrame", function(chatFrame)
		local frameName = chatFrame:GetName()

		for index, value in pairs(CHAT_FRAME_TEXTURES) do
			local object = _G[frameName..value]
			if object:IsShown() then
				UIFrameFadeRemoveFrame(object)
				object:SetAlpha(0)
			end
		end
		if chatFrame == FCFDock_GetSelectedWindow(GENERAL_CHAT_DOCK) then
			if GENERAL_CHAT_DOCK.overflowButton:IsShown() then
				UIFrameFadeRemoveFrame(GENERAL_CHAT_DOCK.overflowButton)
				GENERAL_CHAT_DOCK.overflowButton:SetAlpha(0)
			end
		end

		local chatTab = _G[frameName.."Tab"]
		if not chatTab.alerting then
			UIFrameFadeRemoveFrame(chatTab)
			chatTab:SetAlpha(0)
		end

		if not chatFrame.isDocked then
			UIFrameFadeRemoveFrame(chatFrame.buttonFrame)
			chatFrame.buttonFrame:SetAlpha(0.2)
		end
	end)
hooksecurefunc("FCFTab_UpdateAlpha", function(chatFrame)
	local chatTab = _G[chatFrame:GetName().."Tab"]
	if not chatFrame.hasBeenFaded and not chatTab.alerting then
		chatTab:SetAlpha(0)
	end
end)

-- Update alpha for non-docked chat frame tabs
for i=1, NUM_CHAT_WINDOWS do
	local chatTab = _G[("ChatFrame%dTab"):format(i)]
	chatTab:SetAlpha(0)
end

-- Remove the delay between mousing away from the chat frame and the fade starting
CHAT_TAB_HIDE_DELAY = 0
CHAT_FRAME_TAB_ALERTING_MOUSEOVER_ALPHA = 1
CHAT_FRAME_TAB_ALERTING_NOMOUSE_ALPHA = 0


-- Making the chat background invisibile
for index, value in ipairs(CHAT_FRAME_TEXTURES) do
	for i=1, NUM_CHAT_WINDOWS, 1 do
		_G["ChatFrame" .. i .. value]:Hide();
		_G["ChatFrame" .. i .. value].Show = function() end;
		_G["ChatFrame" .. i .. value]:SetAlpha(0);
		_G["ChatFrame" .. i .. value].SetAlpha = function() end;
	end
end