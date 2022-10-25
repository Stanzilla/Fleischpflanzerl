-- luacheck: globals WOW_PROJECT_ID WOW_PROJECT_CLASSIC

local addonName, Fleischpflanzerl = ...

function Fleischpflanzerl.IsClassic()
    return LE_EXPANSION_WRATH_OF_THE_LICH_KING == 2
end

function Fleischpflanzerl.IsClassicEra()
    return WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
end

function Fleischpflanzerl.IsRetail()
    return WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
end
