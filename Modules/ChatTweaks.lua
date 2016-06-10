-- Fix the broken ass fading of the chat frames
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
SCREENSHOT_SUCCESS = ""


-- -- Making the chat background invisibile
-- for index, value in ipairs(CHAT_FRAME_TEXTURES) do
-- 	for i=1, NUM_CHAT_WINDOWS, 1 do
-- 		_G["ChatFrame" .. i .. value]:Hide();
-- 		_G["ChatFrame" .. i .. value].Show = function() end;
-- 		_G["ChatFrame" .. i .. value]:SetAlpha(0);
-- 		_G["ChatFrame" .. i .. value].SetAlpha = function() end;
-- 	end
-- end

local function RemoveCurrentRealmName(self, event, msg, author, ...)   --code from Epicgrim remade by Tukz
	local realmName = string.gsub(GetRealmName(), " ", "")
	if msg:find("-" .. realmName) then
		return false, gsub(msg, "%-"..realmName, ""), author, ...
	end
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", RemoveCurrentRealmName)

local raidIcons = {
    ["%{[sS][tT][eE][rR][nN]%}"] = "{rt1}",
    ["%{[kK][rR][eE][iI][sS]%}"] = "{rt2}",
    ["%{[dD][iI][aA][mM][aA][nN][tT]%}"] = "{rt3}",
    ["%{[dD][rR][eE][iI][eE][cC][kK]%}"] = "{rt4}",
    ["%{[mM][oO][nN][dD]%}"] = "{rt5}",
    ["%{[qQ][uU][aA][dD][rR][aA][tT]%}"] = "{rt6}",
    ["%{[kK][rR][eE][uU][zZ]%}"] = "{rt7}",
    -- \195\132 Ä, \195\164 ä
    ["%{[tT][oO][tT][eE][nN][sS][cC][hH]\195[\132\164][dD][eE][lL]%}"] = "{rt8}",
}
 
-- raid icons
local function filter(self, event, msg, ...)
    if msg then
        for k, v in pairs(raidIcons) do
            msg = msg:gsub(k, v)
        end
    end
    return false, msg, ...
end
for _,event in pairs{"SAY", "YELL", "GUILD", "GUILD_OFFICER", "WHISPER", "WHISPER_INFORM", "PARTY", "PARTY_LEADER", "RAID", "RAID_LEADER", "INSTANCE_CHAT", "INSTANCE_CHAT_LEADER", "BATTLEGROUND", "BATTLEGROUND_LEADER", "CHANNEL"} do
        ChatFrame_AddMessageEventFilter("CHAT_MSG_"..event, filter)
end