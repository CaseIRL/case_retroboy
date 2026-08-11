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

--- @file src/server/main.lua
--- @description Handles all server side functionality for resource.
---
--- YOU SHOULD NEVER NEED TO EDIT THIS FILE
--- DO SO AT YOUR OWN RISK :)

--- @section Imports

local _cmd = require("src.shared.commands")
local _registry = require("src.shared.registry")

--- @section Commands

--- Handlers
local _cmd_handlers = {
    play = function(source, args, raw)
        local game_name = args[1]

        if not game_name then
            TriggerClientEvent("chat:addMessage", source, {
                args = { "^1RETRO BOY", locale("server.commands.play.usage") }
            })
            return
        end

        if not _registry.get(game_name) then
            TriggerClientEvent("chat:addMessage", source, {
                args = { "^1RETRO BOY", locale("server.commands.play.not_registered", game_name) }
            })
            return
        end

        _registry.play_game(source, game_name)
    end,

    close = function(source, args, raw)
        TriggerClientEvent("case_retroboy:cl:close", source)
    end
}

--- Registration
for name, def in pairs(_c.locales.server.commands) do
    if name == "play" and not (_c.settings.standalone or not _c.settings.require_item) then

    else
        if not _cmd_handlers[name] then
            log("warn", ("[commands] No handler defined for '%s'"):format(name), true)
        else
            _cmd.register({
                name = "retroboy:" .. name,
                help = def.help,
                params = def.params or {},
                handler = _cmd_handlers[name]
            })
        end
    end
end
--- @section Items

if _c.settings.require_item then

    local function register_items()
        for game_id, game_config in pairs(_c.settings.games) do
            if game_config and game_config.enabled then
                local item_name = "crb_" .. game_id

                local game_data = {
                    id = game_id,
                    title = game_config.title,
                    colour = game_config.colour,
                    faceplate_colour = game_config.faceplate_colour,
                    faceplate_image = game_config.faceplate_image or nil,
                    url = ("/games/%s/index.html"):format(game_id)
                }

                _registry.register(game_data)

                _inv.register_item(item_name, function(src)
                    _registry.play_game(src, game_id)
                end)
            end
        end
    end

    register_items()

end

--- @section Commands / Fallback

if not _c.settings.require_item then
    for game_id, game_config in pairs(_c.settings.games) do
        if game_config and game_config.enabled then

            local game_data = {
                id = game_id,
                title = game_config.title,
                colour = game_config.colour,
                faceplate_colour = game_config.faceplate_colour,
                faceplate_image = game_config.faceplate_image or nil,
                url = ("/games/%s/index.html"):format(game_id)
            }

            _registry.register(game_data)
        end
    end
end