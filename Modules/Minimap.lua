local FPMinimap = CreateFrame('Frame', 'FPMinimap', UIParent)
FPMinimap:SetScript('OnEvent', function(self, event, ...) self[event](self, event, ...) end)
FPMinimap:RegisterEvent('ADDON_LOADED')
--FPMinimap:RegisterEvent('PLAYER_ENTERING_WORLD')
FPMinimap:RegisterEvent('ZONE_CHANGED_NEW_AREA')
FPMinimap:RegisterEvent('INSTANCE_ENCOUNTER_ENGAGE_UNIT')

local total = 0
local myfont = NAMEPLATE_FONT 
local classColor = CUSTOM_CLASS_COLORS and
        CUSTOM_CLASS_COLORS[select(2, UnitClass('player'))] or 
        RAID_CLASS_COLORS[select(2, UnitClass('player'))]
local color = {r=255/255, g=255/255, b=255/255 } -- own textcolor

function FPMinimap:ZONE_CHANGED_NEW_AREA()
    SetMapToCurrentZone()    
    if OQMarquee then
        OQMarquee:Hide()
    else end
end
function FPMinimap:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
    if OQMarquee then
        OQMarquee:Hide()
    else end
end

local function SetFont(obj, font, size, style, r, g, b, sr, sg, sb, sox, soy)
    obj:SetFont(font, size, style)
    if sr and sg and sb then obj:SetShadowColor(sr, sg, sb) end
    if sox and soy then obj:SetShadowOffset(sox, soy) end
    if r and g and b then obj:SetTextColor(r, g, b)
    elseif r then obj:SetAlpha(r) end
end

function FPMinimap:ADDON_LOADED(self)
    CompactRaidFrameContainer:UnregisterAllEvents()
    Minimap:SetFrameStrata("LOW")

    MinimapZoneText:Hide()
    MinimapZoneTextButton:Hide()

    MiniMapTracking:Hide()    
    
    MiniMapChallengeMode:ClearAllPoints()
    MiniMapChallengeMode:SetPoint("BOTTOMRIGHT", Minimap, "TOPRIGHT", -2, -2)
    
    QueueStatusMinimapButtonBorder:SetTexture() 
    QueueStatusMinimapButton:ClearAllPoints()
    QueueStatusMinimapButton:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -2, 0)
    
    GuildInstanceDifficulty:ClearAllPoints()      
    GuildInstanceDifficulty:SetParent(Minimap)
    GuildInstanceDifficulty:SetPoint('TOPLEFT', Minimap, 1, 5)
    GuildInstanceDifficulty:UnregisterAllEvents()    
    GuildInstanceDifficulty:Hide()

    MiniMapInstanceDifficulty:ClearAllPoints()
    MiniMapInstanceDifficulty:SetPoint('TOPLEFT', Minimap, 1, 5)    
    MiniMapInstanceDifficulty:UnregisterAllEvents()
    MiniMapInstanceDifficulty:Hide()

    MiniMapMailIcon:Hide()
    MiniMapMailBorder:SetTexture('')
    MiniMapMailFrame:SetParent(Minimap)
    MiniMapMailFrame:ClearAllPoints()
    MiniMapMailFrame:SetPoint('TOP')
    MiniMapMailFrame:SetHeight(8)

    local MiniMapMailText = MiniMapMailFrame:CreateFontString(nil, 'OVERLAY')
    MiniMapMailText:SetFont(myfont, 13, 'OUTLINE')
    MiniMapMailText:SetPoint('BOTTOM', 0, 2)
    MiniMapMailText:SetText('New Mail!')
    MiniMapMailText:SetTextColor(1, 1, 1)

    MiniMapVoiceChatFrame:Hide()
    MinimapNorthTag:SetAlpha(0)
    
    WorldStateAlwaysUpFrame:ClearAllPoints()
    WorldStateAlwaysUpFrame:SetPoint("TOP", UIParent, "TOP", 0, -40)
    
    SetFont(FriendsFont_Large,          myfont, 12, nil, nil, nil, nil, nil, nil, nil, nil, nil)
    SetFont(FriendsFont_Normal,         myfont, 12, nil, nil, nil, nil, nil, nil, nil, nil, nil)
    SetFont(FriendsFont_Small,          myfont, 11, nil, nil, nil, nil, nil, nil, nil, nil, nil)
    SetFont(FriendsFont_UserText,       myfont, 11, nil, nil, nil, nil, nil, nil, nil, nil, nil)
    
end 

--[[ Tracking Menu ]]--

local Minimap_OnMouseUp = Minimap:GetScript("OnMouseUp")
Minimap:SetScript("OnMouseUp",function(this,button,...)
    if button == "RightButton" then
        ToggleDropDownMenu(1,nil,MiniMapTrackingDropDown,"cursor")
    else
        return Minimap_OnMouseUp(this,button,...)
    end
end)

--[[ Coordinates Module 

    FPMinimap.Coord = CreateFrame('Button', nil, Minimap)
    FPMinimap.Coord:SetPoint('TOPLEFT', Minimap, -3.5, -3.5)
    FPMinimap.Coord:SetWidth(40)
    FPMinimap.Coord:SetHeight(14)
    FPMinimap.Coord:RegisterForClicks('AnyUp')
    FPMinimap.Coord:SetAlpha(0.5)

    FPMinimap.Coord.Text = FPMinimap.Coord:CreateFontString(nil, 'OVERLAY')
    FPMinimap.Coord.Text:SetPoint('CENTER', FPMinimap.Coord)
    FPMinimap.Coord.Text:SetFont(myfont, 13, 'OUTLINE')
    FPMinimap.Coord.Text:SetTextColor(1, 1, 1)  
    FPMinimap.Coord:SetScript('OnClick', function() ToggleFrame(WorldMapFrame) end)

local function updatefunc(self, elapsed)
    total = total + elapsed
    if(total > 0.25) then
        local x, y = GetPlayerMapPosition('player')
        self.Text:SetFormattedText('%.0f,%.0f', x * 100, y * 100)
        total = 0
    end
end

function FPMinimap:PLAYER_ENTERING_WORLD()
    if(IsInInstance()) then
        self.Coord.Text:SetText()
        self.Coord:SetScript('OnUpdate', nil)
    else
        self.Coord:SetScript('OnUpdate', updatefunc)
    end
end 
]]--


--[[ Calendar Button Module ]]-- 

for i = 1, select('#', GameTimeFrame:GetRegions()) do
    local texture = select(i, GameTimeFrame:GetRegions())
    if (texture and texture:GetObjectType() == 'Texture') then
        texture:SetTexture(nil)
    end
end

    GameTimeFrame:SetWidth(14)
    GameTimeFrame:SetHeight(14)
    GameTimeFrame:SetHitRectInsets(0, 0, 0, 0)
    GameTimeFrame:ClearAllPoints()
    GameTimeFrame:SetPoint('TOPRIGHT', Minimap, -2, -2)

    GameTimeFrame:GetFontString():SetFont(myfont, 16, 'OUTLINE')
    GameTimeFrame:GetFontString():SetShadowOffset(0, 0)
    GameTimeFrame:GetFontString():SetPoint('TOPRIGHT', GameTimeFrame)

for _, texture in pairs({
    GameTimeCalendarEventAlarmTexture,
    GameTimeCalendarInvitesTexture,
    GameTimeCalendarInvitesGlow,
}) do
    texture.Show = function()
    GameTimeFrame:GetFontString():SetTextColor(1, 0, 1)
    end
    
    texture.Hide = function() 
    GameTimeFrame:GetFontString():SetTextColor(1, 1, 1) --(classColor.r, classColor.g, classColor.b)
    GameTimeFrame:GetFontString():SetAlpha(0.6)
    end
end
    
    
--[[ Clock Styling Module ]]--

if (not IsAddOnLoaded('Blizzard_TimeManager')) then
    LoadAddOn('Blizzard_TimeManager')
end
    TimeManagerClockTicker:SetFont(myfont, 16, 'OUTLINE')
    TimeManagerClockTicker:SetShadowOffset(0, 0)
    TimeManagerClockTicker:SetTextColor(1, 1, 1) --(classColor.r, classColor.g, classColor.b)
    TimeManagerClockTicker:SetAlpha(0.6)
    TimeManagerClockTicker:SetPoint('BOTTOMLEFT', TimeManagerClockButton)
    
    TimeManagerClockButton:GetRegions():Hide()
    TimeManagerClockButton:ClearAllPoints()
    TimeManagerClockButton:SetWidth(40)
    TimeManagerClockButton:SetHeight(15)
    TimeManagerClockButton:SetPoint('BOTTOMLEFT', Minimap, 2, 2)

    TimeManagerAlarmFiredTexture.Show = function()
        TimeManagerClockTicker:SetTextColor(1, 0, 1)
    end

    TimeManagerAlarmFiredTexture.Hide = function() 
        TimeManagerClockTicker:SetTextColor(classColor.r, classColor.g, classColor.b)
    end

--[[ Sexy Dungeon Difficulty ]]--

local rd = CreateFrame("Frame", nil, Minimap)
rd:SetSize(24, 8)
rd:RegisterEvent("PLAYER_ENTERING_WORLD")
rd:RegisterEvent("PLAYER_DIFFICULTY_CHANGED")
rd:RegisterEvent("GUILD_PARTY_STATE_UPDATED")

local rdt = rd:CreateFontString(nil, "OVERLAY")
rdt:SetPoint('TOP', Minimap, 0, -3.5)
rdt:SetFont(myfont, 16, 'OUTLINE')
rdt:SetTextColor(1, 1, 1)

rd:SetScript("OnEvent", function()
    local _, _, difficulty, _, maxPlayers = GetInstanceInfo()

    if difficulty == 0 then
        rdt:SetText("")
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
        rdt:SetText("5 CM")
    elseif difficulty == 9 then
        rdt:SetText("40")
    elseif difficulty == 11 then
        rdt:SetText("3 H")
    elseif difficulty == 12 then
        rdt:SetText("3")
    end

    if GuildInstanceDifficulty:IsShown() then
        rdt:SetTextColor(color.r, color.g, color.b)
        rdt:SetAlpha(0.6)
    else
        rdt:SetTextColor(color.r, color.g, color.b)
        rdt:SetAlpha(0.6)
    end
end)
