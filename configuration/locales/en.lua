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

--- @file configuration/locales/en.lua
--- @description English language translations
--- 
--- If you want to add you own language files copy this file and save as your language e.g. es.lua
--- Replace the text with your language translations
--- Open configuration/settings.lua and set language = "en" to your language

return {

    server = {
        commands = {
            play = {
                help = "Opens the Retro Boy device and loads your chosen game.",
                params = {
                    { name = "game", help = "The name of the game to play (e.g. tetris, snake)" }
                },
            },
            close = {
                help = "Force close your Retro Boy device.",
                params = {},
            }
        }
    }
}