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

--- @file src/shared/commands.lua
--- @module commands
--- @description ACE permission-based command registration with chat suggestion support.
---
--- YOU SHOULD NEVER NEED TO EDIT THIS FILE
--- DO SO AT YOUR OWN RISK :)

--- @section Guard

if rawget(_G, "__commands_module") then
    return _G.__commands_module
end

--- @section Module

local m = {}
_G.__commands_module = m

--- @section Server

if _c.server then

    local chat_suggestions = {}

    --- @section Local Functions

    local function has_permission(source, required_ace)
        if not required_ace then return true end

        local aces = type(required_ace) == "table" and required_ace or { required_ace }

        for _, ace in ipairs(aces) do
            if IsPlayerAceAllowed(source, ace) then
                return true
            end
        end

        return false
    end

    local function register_chat_suggestion(command, help, params)
        chat_suggestions[#chat_suggestions + 1] = {
            command = command,
            help = help,
            params = params
        }
    end

    --- @section Module Functions

    function m.register(opts)
        if not opts or not opts.name or not opts.handler then
            print("[commands] Registration failed: missing name or handler")
            return false
        end

        if opts.help and opts.params then
            register_chat_suggestion(opts.name, opts.help, opts.params)
        end

        RegisterCommand(opts.name, function(source, args, raw)
            if has_permission(source, opts.ace) then
                opts.handler(source, args, raw)
            else
                TriggerClientEvent("chat:addMessage", source, {
                    args = { "^1PERMISSION DENIED", "You don't have permission to use this command." }
                })
            end
        end, false)

        return true
    end

    --- @section Events

    RegisterServerEvent(_mk .. ":sv:get_command_suggestions")
    AddEventHandler(_mk .. ":sv:get_command_suggestions", function()
        local src = source
        local formatted = {}

        for _, suggestion in ipairs(chat_suggestions) do
            formatted[#formatted + 1] = {
                name = "/" .. suggestion.command,
                help = suggestion.help,
                params = suggestion.params
            }
        end

        TriggerClientEvent("chat:addSuggestions", src, formatted)
    end)

end

--- @section Client

if not _c.server then

    function m.get_suggestions()
        TriggerServerEvent(_mk .. ":sv:get_command_suggestions")
    end

end

return m