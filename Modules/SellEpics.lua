local ItemSellerEventHandlerFrame = CreateFrame("Frame", "ItemSellerEventHandlerFrame", UIParent)
ItemSellerEventHandlerFrame:SetSize(1, 1)
ItemSellerEventHandlerFrame:Hide()

local SellEpicItemsButton = CreateFrame("Button", "SellEpicItemsButton", UIParent, "UIPanelButtonTemplate")
SellEpicItemsButton:SetSize(150, 25)
SellEpicItemsButton:SetText("Sell Epic Items (101-499)")
SellEpicItemsButton:Hide()

local function ShouldSellItem(itemLink)
    if not itemLink then
        return false
    end

    local itemName, _, quality, _, _, _, _, _, _, _, _, _ = C_Item.GetItemInfo(itemLink)

    if not itemName then
        return false
    end

    if quality ~= 4 then
        return false
    end

    local actualItemLevel, _, _ = C_Item.GetDetailedItemLevelInfo(itemLink)

    if not actualItemLevel then
        return false
    end

    if actualItemLevel > 100 and actualItemLevel < 500 then
        return true
    else
        return false
    end
end

local function ProcessSellQueue(itemsToSell, index)
    if not MerchantFrame:IsVisible() then
        return
    end

    if index <= #itemsToSell then
        local itemInfo = itemsToSell[index]
        local itemName, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _ = C_Item.GetItemInfo(itemInfo.itemLink)
        itemName = itemName or "Unknown Item"

        C_Container.UseContainerItem(itemInfo.bag, itemInfo.slot)

        -- Check for confirmation dialogs and auto-accept if present
        C_Timer.After(0.2, function()
            local dialogsToAutoAccept = {"DELETE_GOOD_ITEM", "CONFIRM_BINDER", "USE_BIND_CONFIRM", "CONFIRM_MERCHANT_TRADE_TIMER_REMOVAL"}
            for _, dialogName in ipairs(dialogsToAutoAccept) do
                if StaticPopup_Visible(dialogName) then
                    for i = 1, STATICPOPUP_NUMDIALOGS do
                        local frame = _G["StaticPopup" .. i]
                        if frame and frame.which == dialogName and frame:IsShown() then
                            StaticPopup_OnClick(frame, 1)
                        end
                    end
                end
            end
            ProcessSellQueue(itemsToSell, index + 1)
        end)
    else
        -- ...existing code...
    end
end


local function GetItemsToSell()
    local itemsToSell = {}
    for bag = 0, 4 do
        local numSlots = C_Container.GetContainerNumSlots(bag)
        if numSlots and numSlots > 0 then
            for slot = 1, numSlots do
                local itemLink = C_Container.GetContainerItemLink(bag, slot)
                if ShouldSellItem(itemLink) then
                    tinsert(itemsToSell, {bag = bag, slot = slot, itemLink = itemLink})
                end
            end
        end
    end
    return itemsToSell
end

local function SellEpicItems()
    if not MerchantFrame:IsVisible() then
        return
    end

    local itemsToSell = GetItemsToSell()

    if #itemsToSell == 0 then
        StaticPopup_Show("GENERIC_POPUP", "No epic items found between item level 101 and 499 to sell.")
        return
    end

    local maxItemsToShow = 10
    local confirmMessage = "Are you sure you want to sell the following epic items (ilvl 101-499)?\n"
    for i, itemInfo in ipairs(itemsToSell) do
        if i > maxItemsToShow then break end
        local itemName, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _ = C_Item.GetItemInfo(itemInfo.itemLink)
        itemName = itemName or "Unknown Item"
        confirmMessage = confirmMessage .. "- " .. itemName .. "\n"
    end
    if #itemsToSell > maxItemsToShow then
        confirmMessage = confirmMessage .. string.format("...and %d more items not shown\n", #itemsToSell - maxItemsToShow)
    end
    confirmMessage = confirmMessage .. "\nThis action cannot be undone!"

    StaticPopupDialogs["CONFIRM_ITEM_SELLING"] = {
        text = confirmMessage,
        button1 = "Sell Items",
        button2 = "Cancel",
        OnAccept = function()
            ProcessSellQueue(itemsToSell, 1)
        end,
        OnCancel = function()
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }
    StaticPopup_Show("CONFIRM_ITEM_SELLING")
end

SellEpicItemsButton:SetScript("OnClick", SellEpicItems)

ItemSellerEventHandlerFrame:RegisterEvent("MERCHANT_SHOW")
ItemSellerEventHandlerFrame:RegisterEvent("MERCHANT_CLOSED")

local originalItemSellerEventHandlerFrameOnEvent = ItemSellerEventHandlerFrame:GetScript("OnEvent")
ItemSellerEventHandlerFrame:SetScript("OnEvent", function(self, event, ...)
    if originalItemSellerEventHandlerFrameOnEvent then
        originalItemSellerEventHandlerFrameOnEvent(self, event, ...)
    end

    if event == "MERCHANT_SHOW" then
        local itemsToSell = GetItemsToSell()
        if #itemsToSell > 0 then
            SellEpicItemsButton:Show()
            SellEpicItemsButton:SetPoint("BOTTOMLEFT", MerchantFrame, "BOTTOMLEFT", 10, 2)
            SellEpicItemsButton:SetFrameStrata("HIGH")
            SellEpicItemsButton:SetFrameLevel(10)
        else
            SellEpicItemsButton:Hide()
        end
    elseif event == "MERCHANT_CLOSED" then
        StaticPopup_Hide("CONFIRM_ITEM_SELLING")
        SellEpicItemsButton:Hide()
    end
end)
