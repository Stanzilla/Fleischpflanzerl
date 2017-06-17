--[[
-- THIS IS PROBABLY NOT ALL THAT INEFFICIENT ANYMORE
-- IT MIGHT BE FINE TO USE IN RAIDS
--
-- Fade out frames which are out of your characters line of sight,
-- leaving their clickboxes and motion behaviour intact, as that can't be
-- arbitrarily changed by addons.
--
-- This relies on the CVar "nameplateOccludedAlphaMult" being set to 0.4 or
-- lower, and "nameplateMinAlpha" being 0.3 or above. The defaults are fine.
--]]
local folder,ns=...
local addon = KuiNameplates
local core = KuiNameplatesCore
local mod = addon:NewPlugin('LOSFader',101)
local plugin_fading

local function sizer_OnSizeChanged(self,x,y)
    if self.f.parent:IsShown() then
        -- add LOS state
        if self.f.parent:GetAlpha() <= .4 then
            self.f.state.LOS = false
        else
            self.f.state.LOS = true
        end

        if self.f.state.was_LOS == nil or
           self.f.state.was_LOS ~= self.f.state.LOS
        then
            -- LOS state has changed,
            -- calculate frame alpha upon moving
            plugin_fading:UpdateFrame(self.f)
            self.f.state.was_LOS = self.f.state.LOS
        end
    end
end
local function fading_FadeRulesReset()
    -- add LOS rule
    plugin_fading:AddFadeRule(function(f)
        return not f.state.LOS and 0
    end,21)
end
function mod:Create(frame)
    -- hook to frames' sizer
    local sizer = _G[frame:GetName()..'PositionHelper']
    if sizer then
        sizer:HookScript('OnSizeChanged',sizer_OnSizeChanged)
    end
end
function mod:Initialise()
    print('|cff9966ffKui Nameplates|r: |cffff6666You are using Kui_Nameplates_Custom which is not updated by the Curse package.|r If you experience errors, check the repository on GitHub for updates.')

    plugin_fading = addon:GetPlugin('Fading')
    self:AddCallback('Fading','FadeRulesReset',fading_FadeRulesReset)
    fading_FadeRulesReset()

    self:RegisterMessage('Create')
end
