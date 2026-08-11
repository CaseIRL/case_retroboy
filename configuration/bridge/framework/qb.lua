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

--- @file configuration/bridge/framework/qb.lua
--- @description Handles all bridge functions for QBCore framework.

--- @section Module

local m = {}

--- @section Client

if not _c.server then



end

--- @section Server

if _c.server then

    function m.get_identifier(source)
        local p = exports['qb-core']:GetPlayer(source)
        if not player then return false end
        
        return player.PlayerData.citizenid
    end

    function m.get_name(source)
        local player = exports['qb-core']:GetPlayer(source)
        if not player then return false end
        
        return {
            first_name = player.PlayerData.charinfo.firstname,
            last_name = player.PlayerData.charinfo.lastname
        }
    end

end

return m