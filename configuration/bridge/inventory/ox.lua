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

--- @file configuration/bridge/inventory/ox.lua
--- @description Handles all bridge functions for ox_inventory

--- @section Module

local m = {}

--- @section Server

if _c.server then

    function m.has_item(source, item_name, item_amount)
        local required_amount = item_amount or 1
        local count = exports.ox_inventory:GetItemCount(source, item_name)

        return (count or 0) >= required_amount
    end

    function m.register_item(item_name, cb)
        if not item_name then return false end

        exports(item_name, function(event, itemData, inventory, slot, data)
            local src = inventory.id
            if event == "usingItem" then
                cb(src)
                return false
            end
        end)

        return true
    end

end

return m