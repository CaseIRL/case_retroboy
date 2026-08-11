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

--- @file configuration/bridge/framework/nd.lua
--- @description Handles all bridge functions for ND framework.

--- @section Module

local m = {}

--- @section Client

if not _c.server then



end

--- @section Server

if _c.server then

    function m.get_identifier(source)
        local p = exports.ND_Core:getPlayer(source)
        if not player then return false end
        
        return player.identifier
    end

    function m.get_name(source)
        local player = exports.ND_Core:getPlayer(source)
        if not player then return false end
        
        return {
            first_name = player.firstname,
            last_name = player.lastname
        }
    end

end

return m