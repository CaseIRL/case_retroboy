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

--- @file configuration/settings.lua
--- @description Main configuration options for resource

--- Settings here do not control script content (e.g., item prices, locations, or rewards)
--- They dictate core resource behavior, system integrations, and global toggles
---
--- DO NOT REMOVE OR ADD KEYS TO THIS FILE. ONLY MODIFY VALUES.

return {

    --- @section General

    --- Sets the server side console splash spam to a smaller version
    --- It is less intrusive and will still inform you when you need to update
    --- But you will not get change logs or other info
    small_console_splash = false,

    --- Enable debug prints throughout resource
    --- This gets spammy so leave it off unless script is not working right
    debug = true,

    --- Choose your default language here
    --- If you add new languages make sure to add language files into configuration/locales/
    --- Options: en
    language = "en",

    --- Run the script in standalone mode
    --- If enabled, framework and inventory checks will be completely bypassed
    --- Players must use /retroboy:play "game" to play
    standalone = true,

    --- Require players to use a item to open the console
    --- If disabled, players can open the console using /retroboy:play "game"
    require_item = false,

    --- Enable or disable default games here
    --- These games are nothing special just quick examples however they are functional
    games = {
        snake = {
            enabled = true,
            title = "SNAKE",
            colour = "#27b423",
            faceplate_image = "https://c4.wallpaperflare.com/wallpaper/74/678/384/cartoons-wallpaper-preview.jpg",
        },
        invaders = {
            enabled = true,
            title = "INVADERS",
            colour = "#1494a5",
            faceplate_image = "https://wallpaperswide.com/download/space_invaders_6-wallpaper-1280x720.jpg",
        }
    },

    --- @section Framework

    --- Map of all default supported frameworks
    --- Key = resource name to detect, Value = matching file in configuration/bridge/framework/
    --- Only used when framework_auto_detection = true
    --- Add an entry here if you want auto-detection to support another framework
    framework_map = {
        es_extended = "esx",
        ND_Core = "nd",
        ["qb-core"] = "qb",
        qbx_core = "qbx"
    },

    --- Enable/Disable framework auto detection here
    --- If you are using a supported framework you can leave this on `true`
    --- For custom frameworks disable it and update framework to `custom`
    framework_auto_detection = true,

    --- Set your framework choice here, if framework_auto_detection = true leave this
    --- Options: esx, nd, qb, qbx, custom
    framework = "custom",

    --- @section Inventory

    --- Map of all default supported inventories
    --- Key = resource name to detect, Value = matching file in configuration/bridge/inventory/
    --- Only used when inventory_auto_detection = true
    --- Add an entry here if you want auto-detection to support another inventory
    inventory_map = {
        ["qb-inventory"] = "qb",
        ox_inventory = "ox"
    },

    --- Enable/Disable inventory auto detection here
    --- If you are using a supported inventory you can leave this on `true`
    --- For custom inventories disable it and update inventory to `custom`
    inventory_auto_detection = true,

    --- Set your inventory choice here, if inventory_auto_detection = true leave this
    --- Options: qb, ox, custom
    inventory = "custom",

}