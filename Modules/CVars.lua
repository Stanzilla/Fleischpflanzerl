local StanUICV = CreateFrame("Frame")

StanUICV:RegisterEvent("VARIABLES_LOADED")
StanUICV:SetScript("OnEvent", function()

    SetCVar("Autointeract", 0)
    SetCVar("cameraDistanceMax", 48) 	    	 			-- Camera's max zoom out Distance. 50 is max.
	SetCVar("cameraDistanceMaxFactor", 3.4) 		 		-- Sets the factor by which cameraDistanceMax is multiplied.
	SetCVar("ShowClassColorInNameplate", 1) 	 			-- Turns on class coloring in nameplates.
	SetCVar("bloatnameplates", 0)
	SetCVar("bloatthreat", 0)				 				-- Might make nameplates larger but it fixes the disappearing ones.
	SetCVar("consolidateBuffs", 0)			 				-- Turns off Consolidated Buffs.
	SetCVar("screenshotQuality", 10) 			 			-- Screenshot quality (0-10)
	SetCVar("useUiScale", 0)					 			-- Turns off UI scaling
	SetCVar("checkAddonVersion", 0) 			 			-- Load out-of-date addons
	SetCVar("autoLootDefault", 1)				 			-- Enable autolooting
	SetCVar("profanityFilter", 0)
	SetCVar("BlockTrades", 0)
	SetCVar("cameraSmoothTrackingStyle", 0)
	SetCVar("colorChatNamesByClass", 1) -- no UI
	SetCVar("violenceLevel", 5) -- no UI

	ToggleChatColorNamesByClassGroup(true, "SAY")
	ToggleChatColorNamesByClassGroup(true, "EMOTE")
	ToggleChatColorNamesByClassGroup(true, "YELL")
	ToggleChatColorNamesByClassGroup(true, "GUILD")
	ToggleChatColorNamesByClassGroup(true, "OFFICER")
	ToggleChatColorNamesByClassGroup(true, "GUILD_ACHIEVEMENT")
	ToggleChatColorNamesByClassGroup(true, "ACHIEVEMENT")
	ToggleChatColorNamesByClassGroup(true, "WHISPER")
	ToggleChatColorNamesByClassGroup(true, "PARTY")
	ToggleChatColorNamesByClassGroup(true, "PARTY_LEADER")
	ToggleChatColorNamesByClassGroup(true, "RAID")
	ToggleChatColorNamesByClassGroup(true, "RAID_LEADER")
	ToggleChatColorNamesByClassGroup(true, "RAID_WARNING")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL1")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL2")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL3")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL4")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL5")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL6")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL7")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL8")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL9")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL10")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL11")
	ToggleChatColorNamesByClassGroup(true, "INSTANCE_CHAT")
	ToggleChatColorNamesByClassGroup(true, "INSTANCE_CHAT_LEADER")
end)
