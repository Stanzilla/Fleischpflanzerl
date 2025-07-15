-- luacheck: globals WOW_PROJECT_ID WOW_PROJECT_CLASSIC WOW_PROJECT_MISTS_CLASSIC

local addonName, Fleischpflanzerl = ...

function Fleischpflanzerl.IsClassic()
    return WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC
end

function Fleischpflanzerl.IsClassicEra()
    return WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
end

function Fleischpflanzerl.IsRetail()
    return WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
end
