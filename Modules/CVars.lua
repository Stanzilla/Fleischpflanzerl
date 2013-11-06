local sCheatsCV = CreateFrame("Frame")

sCheatsCV:RegisterEvent("VARIABLES_LOADED")
sCheatsCV:SetScript("OnEvent", function()

    SetCVar("Autointeract", 0)
    SetCVar("cameraDistanceMax", 50) 	    	 			-- Camera's max zoom out Distance. 50 is max.
	SetCVar("cameraDistanceMaxFactor", 3.4) 	 			-- Sets the factor by which cameraDistanceMax is multiplied.
	SetCVar("ShowClassColorInNameplate", 1) 	 			-- Turns on class coloring in nameplates.
	SetCVar("bloattest", 0)
	SetCVar("bloatnameplates", 0)
	SetCVar("bloatthreat", 0) 					 			-- Might make nameplates larger but it fixes the disappearing ones.
	SetCVar("consolidateBuffs", 0) 			 				-- Turns off Consolidated Buffs.
	SetCVar("screenshotQuality", 10) 			 			-- Screenshot quality (0-10)
	SetCVar("useUiScale", 0)					 			-- Turns off UI scaling
	SetCVar("checkAddonVersion", 0) 			 			-- Load out-of-date addons
	SetCVar("autoLootDefault", 1)				 			-- Enable autolooting
	SetCVar("profanityFilter", 0)
	SetCVar("BlockTrades", 0)
	
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
	ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND")
	ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND_LEADER")	
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

--[[
	SetCVar("uiScale", "0.73142857142857")
	SetCVar("groundEffectDensity", 256)
	SetCVar("groundEffectDist", 600)
	SetCVar("farclip", 1600)
	SetCVar("skyCloudLod", 3)
	SetCVar("spellEffectLevel", 125)

]]
