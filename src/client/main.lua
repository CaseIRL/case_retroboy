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

--- @file src/client/main.lua
--- @description Handles all client side functionality for resource.
---
--- YOU SHOULD NEVER NEED TO EDIT THIS FILE
--- DO SO AT YOUR OWN RISK :)

--- @section Imports

local _cmd = require("src.shared.commands")

--- @section State

local current_game = nil

--- @section Functions

local function notify_closed()
    TriggerEvent(_mk .. ":cl:on_close", current_game)
    current_game = nil
end

local function close()
    SetNuiFocus(false, false)
    SendNUIMessage({ func = "close" })
    notify_closed()
end

exports("close_console", close)

--- @section NUI Callbacks

RegisterNUICallback("nui:close", function(data, cb)
    SetNuiFocus(false, false)
    notify_closed()
    cb({})
end)

--- @section Events

RegisterNetEvent(_mk .. ":cl:play")
AddEventHandler(_mk .. ":cl:play", function(game)
    current_game = game.id
    SetNuiFocus(true, true)
    SendNUIMessage({
        func = "play",
        game_title = game.title,
        game_colour = game.colour,
        faceplate_colour = game.faceplate_colour,
        faceplate_image = game.faceplate_image,
        game_url = game.url
    })
end)

RegisterNetEvent(_mk .. ":cl:close")
AddEventHandler(_mk .. ":cl:close", function()
    close()
end)

--- @section CFX Event Handlers

AddEventHandler("onClientResourceStart", function(resource_name)
    if resource_name == GetCurrentResourceName() then
        _cmd.get_suggestions()
    end
end)

AddEventHandler("playerSpawned", function()
    _cmd.get_suggestions()
end)