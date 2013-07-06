local SilentRespecFrame = CreateFrame("FRAME", "SilentRespecFrame")
SilentRespecFrame:RegisterEvent("UNIT_SPELLCAST_START");
SilentRespecFrame:RegisterEvent("UNIT_SPELLCAST_STOP");
SilentRespecFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
SilentRespecFrame:RegisterEvent("ADDON_LOADED");
local changingspec = false;
local learnspellmsg = "^" .. string.gsub(ERR_LEARN_SPELL_S, "%%s", ".*") .. "$"
local learnabilitymsg = "^" .. string.gsub(ERR_LEARN_ABILITY_S, "%%s", ".*") .. "$"
--local learnapassivemsg = "^" .. string.gsub(ERR_LEARN_PASSIVE_S, "%%s", ".*") .. "$"
local unlearnspellmsg = "^" .. string.gsub(ERR_SPELL_UNLEARNED_S, "%%s", ".*") .. "$"
local petlearnspellmsg = "^" .. string.gsub(ERR_PET_LEARN_SPELL_S, "%%s", ".*") .. "$"
local petlearnabilitymsg = "^" .. string.gsub(ERR_PET_LEARN_ABILITY_S, "%%s", ".*") .. "$"
local petunlearnspellmsg = "^" .. string.gsub(ERR_PET_SPELL_UNLEARNED_S, "%%s", ".*") .. "$"
local gaintitlemsg = "^" .. string.gsub(NEW_TITLE_EARNED, "%%s", ".*") .. "$"
local losetitlemsg = "^" .. string.gsub(OLD_TITLE_LOST, "%%s", ".*") .. "$"
local function TalentSpam(self, event, ...)
	local msg = ...;
	-- If System Chat Message is "You have Learned..."
	if strfind(msg, learnspellmsg) or strfind(msg, learnabilitymsg) --or strfind(msg, learnapassivemsg) 
	then
		-- If option for hiding "Learned" messages is set for dual or respec and if for dual spec player is changing between dual specs.
		return true
	-- If System Chat Message is "You have unlearned..."
	elseif strfind(msg, unlearnspellmsg) then
		-- If option for hiding "Unlearned" messages is set for dual or respec and if for dual spec player is changing between dual specs.
		return true
	-- If System Chat Message is "Your pet has learned..."
	elseif strfind(msg, petlearnspellmsg) or strfind(msg, petlearnabilitymsg) then
		-- If option for hiding pet "Learned" messages is set.
		return true
	-- If System Chat Message is "Your pet has unlearned..."
	elseif strfind(msg, petunlearnspellmsg) then
		-- If option for hiding pet "Unlearned" messages is set.
		return true
	-- If System Chat Message is "You have lost the title..." or "You have earned the title..."
	elseif strfind(msg, gaintitlemsg) or strfind(msg, losetitlemsg) then
		-- If option for hiding "Titles" messages is set.
		return true
	end
end

local spellcastprimaryspec = GetSpellInfo(63645);
local spellcastsecondaryspec = GetSpellInfo(63644);
local function eventHandler(self, event, ...)
	local arg1, arg2 = ...;
	if event == "ADDON_LOADED" then
		ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", TalentSpam);
	end
	-- If player starts casting spell to change dual spec.
	if event == "UNIT_SPELLCAST_START" and arg1 == "player"
		and	(arg2 == spellcastprimaryspec or arg2 == spellcastsecondaryspec) then
		changingspec = true;
	end
	-- If player has finished or interrupted casting dual spec.
	if (event == "UNIT_SPELLCAST_STOP" or event == "UNIT_SPELLCAST_SUCCEEDED") and arg1 == "player"
		and	(arg2 == spellcastprimaryspec or arg2 == spellcastsecondaryspec) then
		changingspec = false;
	end
end
SilentRespecFrame:SetScript("OnEvent", eventHandler);