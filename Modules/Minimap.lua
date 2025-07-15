local addonName, Fleischpflanzerl = ...

-- luacheck: globals Minimap MiniMapTracking MiniMapChallengeMode QueueStatusMinimapButton QueueStatusMinimapButtonBorder
-- luacheck: globals GuildInstanceDifficulty MiniMapInstanceDifficulty MiniMapMailIcon MiniMapMailFrame MiniMapMailBorder
-- luacheck: globals MiniMapVoiceChatFrame MinimapNorthTag WorldStateAlwaysUpFrame FriendsFont_Large FriendsFont_Normal FriendsFont_Small FriendsFont_UserText
-- luacheck: globals MiniMapTrackingDropDown GameTimeFrame TimeManagerClockTicker OrderHallCommandBar GarrisonLandingPageMinimapButton GarrisonLandingPageTutorialBox
-- luacheck: globals TimeManagerClockButton TimeManagerAlarmFiredTexture GameTimeCalendarEventAlarmTexture GameTimeCalendarInvitesTexture GameTimeCalendarInvitesGlow
-- luacheck: globals MinimapZoneText MinimapZoneTextButton

local FPMinimap = CreateFrame("Frame", "FPMinimap", UIParent)
FPMinimap:SetScript("OnEvent", function(self, event, ...)
    self[event](self, event, ...)
end)
FPMinimap:RegisterEvent("ADDON_LOADED")
FPMinimap:RegisterEvent("ZONE_CHANGED")
FPMinimap:RegisterEvent("ZONE_CHANGED_INDOORS")
FPMinimap:RegisterEvent("ZONE_CHANGED_NEW_AREA")
--FPMinimap:RegisterEvent('INSTANCE_ENCOUNTER_ENGAGE_UNIT')

local myFont = "Interface\\AddOns\\CustomMedia\\Media\\Fonts\\myriadprosemibold.ttf"
local myLowerFont = "Interface\\AddOns\\CustomMedia\\Media\\Fonts\\lowMyriad.TTF"
local classColor = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[select(2, UnitClass("player"))] or RAID_CLASS_COLORS[select(2, UnitClass("player"))]
local color = { r = 255 / 255, g = 255 / 255, b = 255 / 255 }

local function FixButtons()
    if Fleischpflanzerl.IsClassic() then
        Minimap:SetFrameStrata("LOW")
        MiniMapTracking:Hide()
        MiniMapWorldMapButton:Hide()
        MiniMapInstanceDifficulty:ClearAllPoints()
        MiniMapInstanceDifficulty:SetPoint("TOPLEFT", Minimap, 1, 5)
        MiniMapInstanceDifficulty:UnregisterAllEvents()
        MiniMapInstanceDifficulty:Hide()
        MiniMapLFGFrameBorder:SetTexture()
        MiniMapLFGFrameIcon:ClearAllPoints()
        MiniMapLFGFrameIcon:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -2, 0)
        MiniMapLFGFrameIcon:SetFrameStrata("FULLSCREEN")
        MiniMapMailIcon:Hide()

        local MiniMapMailText = MiniMapMailFrame:CreateFontString(nil, "OVERLAY")
        MiniMapMailText:SetFont(myFont, 13, "OUTLINE")
        MiniMapMailText:SetPoint("BOTTOM", 0, 2)
        MiniMapMailText:SetText("New Mail!")
        MiniMapMailText:SetTextColor(1, 1, 1)
        MiniMapMailBorder:SetTexture("")
        MiniMapMailFrame:SetParent(Minimap)
        MiniMapMailFrame:ClearAllPoints()
        MiniMapMailFrame:SetPoint("BOTTOM", 0, -8)
        MiniMapMailFrame:SetHeight(8)
        MinimapNorthTag:SetAlpha(0)
        -- MiniMapVoiceChatFrame:Hide()
        MiniMapMailIcon:SetTexture("Interface\\AddOns\\Fleischpflanzerl\\Modules\\mail.tga")

    elseif TomCats_MiniMapInstanceDifficulty then
        TomCats_MiniMapInstanceDifficulty:ClearAllPoints()
        TomCats_MiniMapInstanceDifficulty:SetPoint("TOPLEFT", Minimap, 1, 5)
        -- TomCats_MiniMapInstanceDifficulty:UnregisterAllEvents()
        -- TomCats_MiniMapInstanceDifficulty:Hide()
    end
    if not IsInInstance() then
        --MinimapZoneTextButton:ClearAllPoints()
        --MinimapZoneTextButton:SetPoint("BOTTOM", Minimap, "TOP", -8, -10)

        --MinimapZoneText:SetPoint("TOP", MinimapZoneTextButton, "TOP", 9, -4)
        MinimapZoneText:SetPoint("TOP", Minimap, 0, -2)
        MinimapZoneText:SetFont(myFont, 12, "OUTLINE")
        MinimapZoneText:SetTextColor(1, 1, 1, 0.6)
        MinimapZoneText:SetShadowOffset(0, 0)
    else
        MinimapZoneText:Hide()
    end
end

-- [[ Calendar Button Module ]]
local function StyleCalendar()
    if GameTimeFrame then
        for i = 1, select("#", GameTimeFrame:GetRegions()) do
            local texture = select(i, GameTimeFrame:GetRegions())
            if texture and texture:GetObjectType() == "Texture" then
                texture:SetTexture(nil)
            end
        end

        GameTimeFrame:SetWidth(14)
        GameTimeFrame:SetHeight(14)
        GameTimeFrame:SetHitRectInsets(0, 0, 0, 0)
        GameTimeFrame:ClearAllPoints()
        GameTimeFrame:SetPoint("TOPRIGHT", Minimap, -2, -2)
        if Fleischpflanzerl.IsClassic() then
            GameTimeFrame:GetFontString():SetFont(myFont, 16, "OUTLINE")
            GameTimeFrame:GetFontString():SetShadowOffset(0, 0)
            GameTimeFrame:GetFontString():SetPoint("TOPRIGHT", GameTimeFrame)
        end
        if GameTimeFrame:GetFontString() then
            for _, texture in pairs({
                GameTimeCalendarEventAlarmTexture,
                GameTimeCalendarInvitesTexture,
                GameTimeCalendarInvitesGlow,
            }) do
                texture.Show = function()
                    GameTimeFrame:GetFontString():SetTextColor(1, 0, 1)
                end

                texture.Hide = function()
                    GameTimeFrame:GetFontString():SetTextColor(1, 1, 1, 0.6)
                end
            end
        end
    end
end

function FPMinimap:ADDON_LOADED()
    FixButtons()
    StyleCalendar()
end

function FPMinimap:ZONE_CHANGED()
    FixButtons()
    StyleCalendar()
end

function FPMinimap:ZONE_CHANGED_INDOORS()
    FixButtons()
end

function FPMinimap:ZONE_CHANGED_NEW_AREA()
    --SetMapToCurrentZone()
    FixButtons()
end

function FPMinimap:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
    return
end

--[[ Tracking Menu ]]
if Fleischpflanzerl.IsClassic() then
    local Minimap_OnMouseUp = Minimap:GetScript("OnMouseUp")
    Minimap:SetScript("OnMouseUp", function(this, button, ...)
        if button == "RightButton" then
            ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, "cursor")
        else
            return Minimap_OnMouseUp(this, button, ...)
        end
    end)
end

--[[ Coordinates Module ]]
FPMinimap.Coord = CreateFrame("Button", nil, Minimap)
FPMinimap.Coord:SetWidth(40)
FPMinimap.Coord:SetHeight(14)
FPMinimap.Coord:SetPoint("BOTTOMRIGHT", Minimap, -10, 2)
FPMinimap.Coord:RegisterForClicks("AnyUp")

FPMinimap.Coord.Text = FPMinimap.Coord:CreateFontString(nil, "OVERLAY")
FPMinimap.Coord.Text:SetPoint("CENTER", FPMinimap.Coord)
FPMinimap.Coord.Text:SetFont(myFont, 16, "OUTLINE")
FPMinimap.Coord.Text:SetTextColor(1, 1, 1, 0.6)
FPMinimap.Coord.Text:SetShadowOffset(0, 0)

FPMinimap.Coord:SetScript("OnClick", function()
    ToggleFrame(WorldMapFrame)
end)

local total = 0
local function updatefunc(self, elapsed)
    total = total + elapsed
    if total <= 0.2 then
        return
    end
    total = 0
    local x, y = GetPlayerMapPosition("player")
    self.Text:SetFormattedText("%.1f,%.1f", x * 100, y * 100)
end

function FPMinimap:PLAYER_ENTERING_WORLD()
    --SetMapToCurrentZone()
    if IsInInstance() then
        self.Coord.Text:SetText()
        self.Coord:SetScript("OnUpdate", nil)
    else
        self.Coord:SetScript("OnUpdate", updatefunc)
    end
end

--[[ Clock Styling Module ]]
if C_AddOns then
    if not C_AddOns.IsAddOnLoaded("Blizzard_TimeManager") then
        C_AddOns. LoadAddOn("Blizzard_TimeManager")
    else
        if not IsAddOnLoaded("Blizzard_TimeManager") then
            LoadAddOn("Blizzard_TimeManager")
        end
    end
end
TimeManagerClockTicker:SetFont(myFont, 16, "OUTLINE")
TimeManagerClockTicker:SetShadowOffset(0, 0)
TimeManagerClockTicker:SetTextColor(1, 1, 1, 0.6) --(classColor.r, classColor.g, classColor.b)
TimeManagerClockTicker:SetPoint("BOTTOMLEFT", TimeManagerClockButton)

TimeManagerClockButton:GetRegions():Hide()
TimeManagerClockButton:ClearAllPoints()
TimeManagerClockButton:SetWidth(40)
TimeManagerClockButton:SetHeight(15)
TimeManagerClockButton:SetPoint("BOTTOMLEFT", Minimap, 2, 2)

TimeManagerAlarmFiredTexture.Show = function()
    TimeManagerClockTicker:SetTextColor(1, 0, 1)
end

TimeManagerAlarmFiredTexture.Hide = function()
    TimeManagerClockTicker:SetTextColor(classColor.r, classColor.g, classColor.b)
end

--[[ Sexy Dungeon Difficulty ]]
local rd = CreateFrame("Frame", nil, Minimap)
rd:SetSize(24, 8)
rd:RegisterEvent("PLAYER_ENTERING_WORLD")
if Fleischpflanzerl.IsRetail() then
    rd:RegisterEvent("PLAYER_DIFFICULTY_CHANGED")
end
rd:RegisterEvent("GUILD_PARTY_STATE_UPDATED")
rd:RegisterEvent("ZONE_CHANGED_NEW_AREA")

local rdt = rd:CreateFontString(nil, "OVERLAY")
rdt:SetPoint("BOTTOMRIGHT", Minimap, -2, 0)
rdt:SetTextColor(1, 1, 1, .6)

rd:SetScript("OnEvent", function()
    if UIWidgetTopCenterContainerFrame then
        UIWidgetTopCenterContainerFrame:SetPoint("TOP", UIParent, 0, -3.5)
    end
    rdt:SetFont(myFont, 16, "OUTLINE")
    local _, _, difficulty, _, maxPlayers = GetInstanceInfo()
    if difficulty == 0 then
        rdt:SetText("")
        SetCVar("chatBubbles", 1)
    elseif maxPlayers == 1 then
        rdt:SetText("1")
    elseif difficulty == 1 then
        rdt:SetText("5")
    elseif difficulty == 2 then
        rdt:SetText("5 H")
    elseif difficulty == 3 then
        rdt:SetText("10")
    elseif difficulty == 4 then
        rdt:SetText("25")
    elseif difficulty == 5 then
        rdt:SetText("10 H")
    elseif difficulty == 6 then
        rdt:SetText("25 H")
    elseif difficulty == 7 then
        rdt:SetText("LFR")
    elseif difficulty == 8 then
        rdt:SetText("5 M+")
        SetCVar("chatBubbles", 1)
    elseif difficulty == 9 then
        rdt:SetText("40")
    elseif difficulty == 11 then
        rdt:SetText("3 H")
    elseif difficulty == 12 then
        rdt:SetText("3")
    elseif difficulty == 13 then
        rdt:SetText("")
    elseif difficulty == 14 then
        rdt:SetText("N") -- Flex
    elseif difficulty == 15 then
        rdt:SetText("H") -- Flex
    elseif difficulty == 16 then
        rdt:SetText("M")
    elseif difficulty == 17 then
        rdt:SetText("LFR")
    elseif difficulty == 18 then
        rdt:SetText("Event")
    elseif difficulty == 19 then
        rdt:SetText("Event")
    elseif difficulty == 20 then
        rdt:SetText("Event")
    elseif difficulty == 23 then
        rdt:SetText("5 M")
    end
    if Fleischpflanzerl.IsRetail() then
        if GuildInstanceDifficulty and GuildInstanceDifficulty:IsShown() then
            rdt:SetTextColor(color.r, color.g, color.b, 0.6)
        else
            rdt:SetTextColor(color.r, color.g, color.b, 0.6)
        end
    end
end)
