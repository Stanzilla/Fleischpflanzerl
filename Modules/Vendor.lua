-- Repair Config
local guildRepair = true -- Always use guild repair (true) or always use own money (false)
local guildOnlyRaid = false -- Guild repair ONLY while in a raid group
local printMessage = true -- Prints how much the repair was

local function SellTrash()
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
end

local rm = CreateFrame("Frame", "RepairMe")
rm:RegisterEvent("MERCHANT_SHOW")
rm:SetScript("OnEvent", function()
    C_Timer.NewTicker(0.2, SellTrash, 3)
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
            if guildOnlyRaid and GetNumGroupMembers() ~= 0 then
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
