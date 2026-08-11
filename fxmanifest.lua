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

fx_version "cerulean"
games { "gta5" }

name "case_retroboy"
version "1.0.0"
description "A retro handheld console NUI for loading iframes in FiveM."
author "CaseIRL"
lua54 "yes"

ui_page "src/ui/index.html"
nui_callback_strict_mode "true"

files {
    "games/**",
    "configuration/ui/*",
    "configuration/locales/*.lua",
    "configuration/settings.lua",
    "configuration/bridge/**/*.lua",
    "src/ui/**",
    "src/shared/*.lua"
}

shared_scripts {
    "src/init.lua"
}

server_scripts {
    "src/server/main.lua"
}

client_scripts {
    "src/client/main.lua"
}