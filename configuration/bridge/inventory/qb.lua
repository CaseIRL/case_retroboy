--[[
--------------------------------------------------

Author: Case | https://caseirl.dev
GitHub: https://github.com/caseirl/case_retroboy
License: https://github.com/caseirl/case_retroboy/blob/main/LICENSE

Do not resell or bundle.
Retain this header in all files.
Support honest open source development.

--------------------------------------------------
]]

--- @file configuration/bridge/inventory/qb.lua
--- @description Handles all bridge functions for qb-inventory

--- @section Module

local m = {}

--- @section Server

if _c.server then

    function m.has_item(source, item_name, item_amount)
        local required_amount = item_amount or 1
        local has_item = exports['qb-inventory']:HasItem(source, item_name, required_amount)

        return has_item
    end

    function m.register_item(item_name, cb)
        if not item_name then return false end

        local QBCore = exports['qb-core']:GetCoreObject()

        QBCore.Functions.CreateUseableItem(item_name, function(source, item)
            cb(source)
        end)
        return true
    end

end

return m