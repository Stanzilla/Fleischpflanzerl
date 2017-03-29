-- BUFF_FLASH_TIME_ON = 0.8
-- BUFF_FLASH_TIME_OFF = 0.8
-- BUFF_MIN_ALPHA = 0.70

-- local myscale = 1.1
-- local myfont = NAMEPLATE_FONT

-- local glosstex1 = "Interface\\AddOns\\CustomMedia\\Media\\Textures\\gloss"
-- local glosstex2 = "Interface\\AddOns\\CustomMedia\\Media\\Textures\\grey"

-- local addon = CreateFrame("Frame")
-- local _G = getfenv(0)

-- addon:SetScript("OnEvent", function(self, event, ...)
--     local unit = ...
--     if(event=="PLAYER_ENTERING_WORLD") then
--         ConsolidatedBuffs:SetScale(myscale)
--         ConsolidatedBuffs:ClearAllPoints()
--         ConsolidatedBuffs:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -7, -7)
--         ConsolidatedBuffs.SetPoint = function() end

--         TemporaryEnchantFrame:SetScale(myscale)

--         BuffFrame:SetScale(myscale)
--         BuffFrame:ClearAllPoints()
--         BuffFrame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -7, -7)
--         BuffFrame.SetPoint = function() end

--         --addon:runthroughicons()
--     end
-- end)

-- function addon:runthroughicons()
--     local i = 1
--     while _G["BuffButton"..i]
--     do
--         addon:checkgloss("BuffButton"..i,1)
--         i = i + 1
--     end
--     i = 1
--     while _G["DebuffButton"..i]
--     do
--         addon:checkgloss("DebuffButton"..i,2)
--         i = i + 1
--     end
--     i = 1
--     while _G["TempEnchant"..i]
--     do
--         addon:checkgloss("TempEnchant"..i,3)
--         i = i + 1
--     end
-- end

-- function addon:checkgloss(name,icontype)
--     local b = _G[name.."Border"]
--     local i = _G[name.."Icon"]
--     local f = _G[name]
--     local c = _G[name.."Gloss"]
--     local ff = _G[name.."Duration"]

--     ff:SetFont(myfont, 10, nil)
--     ff:ClearAllPoints()
--     ff:SetPoint("TOP",f,"BOTTOM",0,0)

--     if not c then
--         local fg = CreateFrame("Frame", name.."Gloss", f)
--         fg:SetAllPoints(f)

--         local t = f:CreateTexture(name.."GlossTexture","ARTWORK")
--         t:SetTexture(glosstex1)
--         t:SetPoint("TOPLEFT", fg, "TOPLEFT", 0, 0)
--         t:SetPoint("BOTTOMRIGHT", fg, "BOTTOMRIGHT", 0, 0)

--         i:SetTexCoord(0.1,0.9,0.1,0.9)
--         i:SetPoint("TOPLEFT", fg, "TOPLEFT", 2, -2)
--         i:SetPoint("BOTTOMRIGHT", fg, "BOTTOMRIGHT", -2, 2)
--     end

--     local tex = _G[name.."GlossTexture"]
--     if icontype == 2 and b then
--         local red,green,blue = b:GetVertexColor();
--         tex:SetTexture(glosstex2)
--         tex:SetVertexColor(red*0.5,green*0.5,blue*0.5)
--     elseif icontype == 3 and b then
--         tex:SetTexture(glosstex2)
--         tex:SetVertexColor(0.5,0,0.5)
--     else
--         tex:SetTexture(glosstex1)
--         tex:SetVertexColor(1,1,1)
--     end
--     if b then b:SetAlpha(0) end
-- end

-- SecondsToTimeAbbrev = function(time)
--     local hr, m, s, text
--     if time <= 0 then
--         text = ""
--     elseif(time < 3600 and time > 60) then
--         hr = floor(time / 3600)
--         m = floor(mod(time, 3600) / 60 + 1)
--         text = format("%d".."|cffffff00".."m", m) --|cffce3a19 = rot
--     elseif(time < 60 and time > 10) then
--         m = floor(time / 60)
--         s = mod(time, 60)
--         text = (m == 0 and format("%d".."|cffffff00".."s", s))
--     elseif time < 10 then
--         s = mod(time, 60)
--         text = (format("%d".."|cffffff00".."s", s))
--     else
--         --hr = floor(time / 3600 + 1)
--         --text = format("%dh", hr)
--         hr = floor(time / 60 + 1)
--         text = format("%d".."|cffffff00".."m", hr)
--     end
--     text = format("|cffffffff".."%s", text)
--     return text
-- end

-- --hooksecurefunc("BuffFrame_Update",function() addon:runthroughicons() end)
-- addon:RegisterEvent("PLAYER_ENTERING_WORLD")
