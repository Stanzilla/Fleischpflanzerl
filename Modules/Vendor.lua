-- Repair Config
local guildRepair = true -- Always use guild repair (true) or always use own money (false)
local guildOnlyRaid = false -- Guild repair ONLY while in a raid group
local printMessage = true -- Prints how much the repair was

local function FormatMoney(value)  
    if value >= 10000 or value <= -10000 then  
            return format("%d|cffffd700g|r %d|cffc7c7cfs|r %d|cffeda55fc|r", abs(value / 10000), abs(mod(value / 100, 100)), abs(mod(value, 100)))  
    elseif value >= 100 or value <= -100 then  
            return format("%d|cffc7c7cfs|r %d|cffeda55fc|r", abs(mod(value / 100, 100)), abs(mod(value, 100)))  
    else  
            return format("%d|cffeda55fc|r", abs(mod(value, 100)))  
    end  
end  

-- local UseGuildRepair = false


-- SLASH_USEGUILDREPAIR1 = "/ugr"
-- hash_SlashCmdList["USEGUILDREPAIR"] = nil
-- SlashCmdList["USEGUILDREPAIR"] = function(text)
--     UseGuildRepair = not UseGuildRepair
--     print("|cFF33FF99Vendorz0r|r: We're using guild bank repair: " .. tostring(UseGuildRepair))
-- end

local frame = CreateFrame("Frame")  
frame:RegisterEvent("MERCHANT_SHOW")  
frame:SetScript("OnEvent", function()  
    --sell trash  
    local bag, slot, item  
    for bag = 0, 4 do  
        if GetContainerNumSlots(bag) > 0 then  
            for slot = 1, GetContainerNumSlots(bag) do  
                item = GetContainerItemLink(bag, slot)  
                if item and select(3, GetItemInfo(item)) == 0 then --item is "poor" (gray) quality  
                    UseContainerItem(bag, slot)  
                end  
            end  
        end  
    end  
  
    -- --auto-repair  
    -- if CanMerchantRepair() then  
    --     --if IsInInstance() and UnitName("player") == "Arcádia" or UnitName("player") == "Maiel" then UseGuildRepair = true else end
    --     local cost, canRepair = GetRepairAllCost()  
    --     if (GetMoney() < cost) then  
    --         DEFAULT_CHAT_FRAME:AddMessage("Can't afford repair bill!")  
    --     elseif (canRepair) then  
    --         local guildRepair = CanGuildBankRepair()                     
    --         local funds = GetGuildBankWithdrawMoney()  
    --         if funds == -1 then  
    --             funds = GetGuildBankMoney()  
    --         else  
    --             funds = math.min(funds, GetGuildBankMoney())  
    --         end  
    --         if UseGuildRepair and CanGuildBankRepair() and cost <= GetGuildBankMoney() and (cost <= GetGuildBankWithdrawMoney() or GetGuildBankWithdrawMoney() == -1) then
    --             RepairAllItems(guildRepair) 
    --             DEFAULT_CHAT_FRAME:AddMessage("|cFF33FF99Vendorz0r|r: Repaired for ".. FormatMoney(math.min(cost, funds),12) .. " with guild funds.")  
    --         else
    --             RepairAllItems() 
    --             DEFAULT_CHAT_FRAME:AddMessage("|cFF33FF99Vendorz0r|r: Repaired for ".. FormatMoney(math.min(cost, funds),12) .. ".")  
    --             guildRepair = nil 
    --         end
    --         -- if (guildRepair and cost > funds) then  
    --         --     local final = cost - funds
    --         --     RepairAllItems()                
    --         --     DEFAULT_CHAT_FRAME:AddMessage("|cFF33FF99Vendorz0r|r: Repaired for ".. FormatMoney(math.min(cost, funds),12) .. ".")    --GetCoinTextureString
    --         -- end  
    --     end  
    -- end
end)

--  The goods
local rm = CreateFrame("Frame", "RepairMe")
rm:RegisterEvent("MERCHANT_SHOW")
rm:SetScript("OnEvent", function()
    local cost = GetRepairAllCost()
    local function gr()
        if printMessage then
            if cost > 1e4 then
                print(format("Repaired from the guild bank for %d|cffffd700g|r %d|cffc7c7cfs|r %d|cffeda55fc|r", cost / 1e4, mod(cost, 1e4) / 1e2, mod(cost, 1e2)))
            elseif cost > 1e2 then
                print(format("Repaired from the guild bank for %d|cffc7c7cfs|r %d|cffeda55fc|r", cost / 1e2, mod(cost, 1e2)))
            else
                print(format("Repaired from the guild bank for %d|cffeda55fc|r", cost))
            end
        end
        RepairAllItems(1)
    end
    local function sr()
        if printMessage then
            if cost > 1e4 then
                print(format("Repaired for %d|cffffd700g|r %d|cffc7c7cfs|r %d|cffeda55fc|r", cost / 1e4, mod(cost, 1e4) / 1e2, mod(cost, 1e2)))
            elseif cost > 1e2 then
                print(format("Repaired for %d|cffc7c7cfs|r %d|cffeda55fc|r", cost / 1e2, mod(cost, 1e2)))
            else
                print(format("Repaired for %d|cffeda55fc|r", cost))
            end
        end
        RepairAllItems()
    end
    if IsModifierKeyDown() then
        return
    elseif CanMerchantRepair() and cost ~= 0 then
        if guildRepair and CanGuildBankRepair() and cost <= GetGuildBankMoney() and (cost <= GetGuildBankWithdrawMoney() or GetGuildBankWithdrawMoney() == -1) then
            if guildOnlyRaid and GetNumRaidMembers() ~= 0 then
                gr()
            elseif not guildOnlyRaid then
                gr()
            elseif cost <= GetMoney() then
                sr()
            else
                print("Not enough money to automatically repair")
            end
        elseif cost <= GetMoney() then
            sr()
        else
            print("Not enough money to automatically repair")
        end
    end
end)