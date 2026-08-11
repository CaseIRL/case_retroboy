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

--- @file configuration/bridge/framework/custom.lua
--- @description Handles all bridge functions for your custom framework or standalone setup.
--- You are expected to know how to do this if you are not using a supported framework.
--- Support can be given but is limited.

--- @section Core Object

-- Import your custom core object if needed
-- Example: local CustomCore = exports.my_custom_core:GetCore()

--- @section Module

local m = {}

--- @section Client

if not _c.server then
    -- Add client-side custom bridge functions here if needed
end

--- @section Server

if _c.server then

    function m.get_identifier(source)
        -- Use source to get players unique identifier

        return false -- Return it here
    end

    function m.get_name(source)
        -- Use source to get players character name

        return {
            first_name = "n/a",
            last_name = "n/a"
        }
    end

end

return m