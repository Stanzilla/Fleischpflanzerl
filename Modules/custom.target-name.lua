-- luacheck: globals KuiNameplates KuiNameplatesCore

-- add the unit's target's name above their name. Difficult to describe in a
-- coherent sentence.
local folder,ns=...
local addon = KuiNameplates
local core = KuiNameplatesCore

local mod = addon:NewPlugin('TargetName',101,3)
if not mod then return end

local UPDATE_INTERVAL = .1
local interval = 0

local function ClassColorName(unit)
    local _, class = UnitClass(unit)
    if not class then return end
    return RAID_CLASS_COLORS[class]:WrapTextInColorCode(UnitName(unit))
end

local update = CreateFrame('Frame')
update:SetScript('OnUpdate',function(self,elap)
    -- units changing target doesn't fire an event, so we have to check constantly
    interval = interval + elap

    if interval >= UPDATE_INTERVAL then
        interval = 0

        for _,f in addon:Frames() do
            if f:IsShown() and f.unit then
                local name = UnitName(f.unit..'target')
                if name then
                    f.TargetName:SetText(ClassColorName(name) or "")
                else
                    f.TargetName:SetText("")
                end
            end
        end
    end
end)

function mod:Create(frame)
    local tn = frame:CreateFontString(nil,'OVERLAY')
    tn:SetFont(frame.NameText:GetFont())
    tn:SetPoint('CENTER',frame,'BOTTOM')

    frame.TargetName = tn
end
function mod:Initialise()
    self:RegisterMessage('Create')
end
