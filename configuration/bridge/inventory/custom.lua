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

--- @file configuration/bridge/inventory/custom.lua
--- @description Handles all bridge functions for your custom inventory or standalone setup.
--- You are expected to know how to do this if you are not using a supported inventory.
--- Support can be given but is limited.

--- @section Module

local m = {}

--- @section Client

if not _c.server then
    -- Add client-side custom bridge functions here if needed
end

--- @section Server

if _c.server then

    function m.has_item(source, item_name, item_amount)
        local required_amount = item_amount or 1

        -- Check if source has item_name >= required_amount

        return false -- Return true/false here
    end

    function m.register_item(item_name, cb)
        -- Hook into your inventory's "on item use" event/export
        -- Call cb(source) when item_name is used

        return false
    end

end

return m