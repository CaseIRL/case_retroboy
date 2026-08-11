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

--- @file src/shared/registry.lua
--- @module registry
--- @description Game registry. Games register a url + display info, then get launched via export.
---
--- YOU SHOULD NEVER NEED TO EDIT THIS FILE
--- DO SO AT YOUR OWN RISK :)

--- @section Guard

if rawget(_G, "__registry_module") then
    return _G.__registry_module
end

--- @section Module

local m = {}
_G.__registry_module = m

m.games = {}

--- @section Module Functions

--- @param opts table { id, title, url, colour?, faceplate_colour?, faceplate_image? }
function m.register(opts)
    if not opts or not opts.id or not opts.title or not opts.url then
        log("error", "[registry] register() requires id, title, url", true)
        return false
    end

    m.games[opts.id] = {
        id = opts.id,
        title = opts.title,
        url = opts.url,
        colour = opts.colour or "#4dcbc2",
        faceplate_colour = opts.faceplate_colour or "",
        faceplate_image = opts.faceplate_image or "",
        resource = GetInvokingResource() or GetCurrentResourceName()
    }

    log("success", ("[registry] Registered '%s' (%s)"):format(opts.title, opts.id), true)
    return true
end

function m.get(id)
    return m.games[id]
end

function m.list()
    local out = {}
    for _, game in pairs(m.games) do out[#out + 1] = game end
    return out
end

function m.play_game(source, id)
    local game = m.get(id)

    if not game then
        log("warn", ("[registry] play_game failed -- '%s' not registered"):format(tostring(id)), true)
        return false
    end

    TriggerClientEvent(_mk .. ":cl:play", source, game)
    return true
end

--- @section Server

if _c.server then

    exports("register_game", function(opts)
        return m.register(opts)
    end)

    exports("play_game", function(source, id)
        return m.play_game(source, id)
    end)

end

--- @section Cleanup

AddEventHandler("onResourceStop", function(resource_name)
    for id, game in pairs(m.games) do
        if game.resource == resource_name then
            m.games[id] = nil
        end
    end
end)

return m