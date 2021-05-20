-- luacheck: globals WOW_PROJECT_ID WOW_PROJECT_CLASSIC

local addonName, Fleischpflanzerl = ...

function Fleischpflanzerl.IsClassic()
    return WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
end

function Fleischpflanzerl.IsRetail()
    return WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
end
