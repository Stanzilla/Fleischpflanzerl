-- luacheck: globals KuiNameplates KuiNameplatesCore

-- adds an priority tracker to the left of the nameplate
local addon = KuiNameplates
local core = KuiNameplatesCore

local mod = addon:NewPlugin('AgonyAura',101,3)
if not mod then return end

function mod:Create(f)
    local agony = f.handler:CreateAuraFrame({
        max = 1,
        size = 36,
        squareness = 1,
        point = {'BOTTOMRIGHT','RIGHT','LEFT'},
        rows = 1,
        filter = 'HARMFUL|PLAYER',
        whitelist = {
            [980] = true, -- agony
        },
    })
    agony:SetFrameLevel(0)
    agony:SetWidth(32)
    agony:SetHeight(32)
    agony:SetPoint('LEFT',f.bg,'LEFT',-40,0)
    f.AgonyAura = agony
end

function mod:Initialise()
    self:RegisterMessage('Create')
end
