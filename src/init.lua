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

--- @file init.lua
--- @description Main initialisation file for script
--- Handles setting up namespaces, module loader and a few other things.
---
--- YOU SHOULD NEVER NEED TO EDIT THIS FILE
--- DO SO AT YOUR OWN RISK :)

--- @section Requirements

local _req = {
    locales = true,
    bridges = {
        framework = true,
        inventory = true
    }
}

--- @section Constants

local _r = GetCurrentResourceName()
local _con = IsDuplicityVersion()
local _lc = { reset = "^7", debug = "^6", info = "^5", success = "^2", warn = "^3", error = "^8", critical = "^1", dev = "^9" }
local _b = { 120, 118, 136, 122, 126, 135, 129, 67, 121, 122, 139 }
_mk = "case_retroboy"
local _mu = "https://raw.githubusercontent.com/caseirl/version_manifest/main/fivem.json"
local _zw = "​"
local _sep = ("^2---------------------------------------------------------------------^7"):gsub("%-%-%-", "---" .. _zw, 1)

--- @section Utility Functions

local function log(level, message, force)
    if not force and not _c.settings.debug then return end
    local _time = _c.server and os.date("%Y-%m-%d %H:%M:%S") or (GetLocalTime and ("%04d-%02d-%02d %02d:%02d:%02d"):format(GetLocalTime()) or "0000-00-00 00:00:00")
    local clr = _lc[level] or "^7"
    print(("%s[%s] [%s] [%s]:^7 %s"):format(clr, _time, _c.name, level:upper(), message))
end

_G.log = log

local function safe_require(key)
    if not key or type(key) ~= "string" then return nil end
    local rev = _c._cache_rev or 0
    local rp = key:gsub("%.", "/")
    if not rp:match("%.lua$") then rp = rp .. ".lua" end
    local ck = ("%s:%s:%s"):format(_c.name, rev, rp)
    if _c.cache[ck] then return _c.cache[ck] end
    local f = LoadResourceFile(_c.name, rp)
    if not f then log("warn", ("Module not found: %s"):format(rp), true) return nil end
    local m = setmetatable({}, { __index = _G })
    local ch, err = load(f, ("@@%s/%s"):format(_c.name, rp), "t", m)
    if not ch then log("error", ("Module compile error in %s: %s"):format(rp, err), true) return nil end
    local ok, res = pcall(ch)
    if not ok then log("error", ("Module runtime error in %s: %s"):format(rp, res), true) return nil end
    if type(res) ~= "table" then log("error", ("Module %s did not return a table (got %s)"):format(rp, type(res)), true) return nil end
    _c.cache[ck] = res
    return res
end

_G.require = safe_require

local function _shift()
    return (#_b * 2) - 1
end

local function _rev()
    local sum = 0
    local shift = _shift()
    for i = 1, #_b do
        sum = (sum + (_b[i] - shift) * i) % 999999937
    end
    return sum
end

local function ping()
    local s = _shift()
    local e = {}
    for i = 1, #_b do e[i] = string.char(_b[i] - s) end
    e = table.concat(e)
    local ok, a = pcall(tostring, _c)
    if ok and a == e then
        return a
    end
    local s2 = (_c.name or "x") .. tostring(_c.metadata and _c.metadata.version or "0")
    local o = {}
    for i = 1, #s2 do
        o[i] = string.char(((s2:byte(i) + i * 7) % 94) + 33)
    end
    return table.concat(o)
end

_G.ping = ping

local function locale(key, ...)
    local str = _c.locales[key]
    if not str and type(key) == "string" then
        local v = _c.locales
        for p in key:gmatch("[^%.]+") do v = v and v[p] end
        str = v
    end
    if type(str) == "string" then
        local ok, res = pcall(string.format, str, ...)
        return ok and res or str
    end
    return select("#", ...) > 0 and (tostring(key) .. " | " .. table.concat({...}, ", ")) or tostring(key)
end

_G.locale = locale

--- @section Namespace

local context = IsDuplicityVersion()

_c = setmetatable({
    name = _r,
    client = not _con,
    server = _con,
    settings = {},
    bridges = {},
    locales = {},
    cache = {},
    metadata = {
        name = GetResourceMetadata(_r, "name", 0) or _r,
        desc = GetResourceMetadata(_r, "description", 0) or "N/A",
        version = GetResourceMetadata(_r, "version", 0) or "1.0.0",
        author = GetResourceMetadata(_r, "author", 0) or "Unknown"
    }
}, (function()
    return {
        __index = function(t, k)
            if k == ("_cache_" .. "rev") then
                local s = _rev()
                rawset(t, "_cache_rev", s)
                return s
            end
        end,
        __tostring = function()
            local c = {}
            local s = _shift()
            for i = 1, #_b do c[i] = string.char(_b[i] - s) end
            return table.concat(c)
        end
    }
end)())

--- @section Settings

local loaded_settings = require("configuration.settings")

if loaded_settings then
    _c.settings = loaded_settings
else
    _c.settings = {
        small_console_splash = true,
        debug = false,
        language = "en",
        framework_auto_detection = false,
        framework = "custom",
    }
end

if _req.locales then
    local lang = (_c.settings and _c.settings.language) or "en"
    local loaded_locale = require("configuration.locales." .. lang)

    if loaded_locale then
        _c.locales = loaded_locale
    else
        print(("[locales] Failed to load language '%s', falling back to 'en'"):format(lang))
        _c.locales = require("configuration.locales.en") or {}
    end

    log("info", locale("test_locale"))
else
    _c.locales = {}
end

if _req.bridges and _req.bridges.framework then
    _c.bridges = _c.bridges or {}

    local _framework = _c.settings.framework or "custom"

    if _c.settings.framework_auto_detection then
        for res_name, fw_key in pairs(_c.settings.framework_map) do
            if GetResourceState(res_name) == "started" then
                _framework = fw_key
                break
            end
        end
    end

    local loaded_bridge = require(("configuration.bridge.framework.%s"):format(_framework))

    if loaded_bridge then
        _c.bridges.framework = loaded_bridge
        log("info", ("Bridge loaded successfully for framework: %s"):format(_framework), true)
    else
        log("error", ("Failed to load bridge file for framework: %s"):format(_framework), true)
        _c.bridges.framework = {}
    end

    _G._fw = _c.bridges.framework
end

if _req.bridges and _req.bridges.inventory then
    _c.bridges = _c.bridges or {}

    local _inventory = _c.settings.inventory or "custom"

    if _c.settings.inventory_auto_detection then
        for res_name, inv_key in pairs(_c.settings.inventory_map) do
            if GetResourceState(res_name) == "started" then
                _inventory = inv_key
                break
            end
        end
    end

    local loaded_bridge = require(("configuration.bridge.inventory.%s"):format(_inventory))

    if loaded_bridge then
        _c.bridges.inventory = loaded_bridge
        log("info", ("Bridge loaded successfully for inventory: %s"):format(_inventory), true)
    else
        log("error", ("Failed to load bridge file for inventory: %s"):format(_inventory), true)
        _c.bridges.inventory = {}
    end

    _G._inv = _c.bridges.inventory
end

--- @section Startup Banner & Version Checker

if _c.server then
    local function print_startup()
        local current_ver = _c.metadata.version

        PerformHttpRequest(_mu, function(status, body)
            local ok, manifest = pcall(json.decode, body or "")
            local remote = (status == 200 and ok and type(manifest) == "table") and manifest[_mk] or nil

            local is_mismatch = remote and remote.version and (tostring(remote.version) ~= tostring(current_ver))
            local ver_tag = not remote and ("^8[Unable to verify]^7") or is_mismatch and ("^3[v" .. remote.version .. " Available]^7") or ("^2[Up to date]^7")

            if _c.settings.small_console_splash then
                print(_sep)
                print(("^7[%s] ^2v%s^7 %s"):format(_c.metadata.name, current_ver, ver_tag))
                if is_mismatch then
                    print("^3Update available -- disable small_console_splash for changelog details^7")
                end
                print(_sep)
                return
            end

            print(_sep)
            print("^2▄█████ ▄████▄ ▄█████ ██████ ██ █████▄  ██       ████▄  ██████ ██  ██ ^7")
            print("^2██     ██▄▄██ ▀▀▀▄▄▄ ██▄▄   ██ ██▄▄██▄ ██       ██  ██ ██▄▄   ██▄▄██ ^7")
            print("^2▀█████ ██  ██ █████▀ ██▄▄▄▄ ██ ██   ██ ██████ ▄ ████▀  ██▄▄▄▄  ▀██▀ ^7")
            print(_sep)
            print("^7Name:        ^2" .. _c.metadata.name .. "^7")
            print("^7Description: ^2" .. _c.metadata.desc .. "^7")
            print("^7Author:      ^2" .. _c.metadata.author .. "^7")
            print(("^7Version:     %s %s"):format(is_mismatch and "^1v" .. current_ver or "^2v" .. current_ver, ver_tag))
            if _req.framework then
                print("^7Framework:   ^2" .. (_c.settings.framework or "custom") .. "^7")
            end
            if _req.locales then
                print("^7Language:    ^2" .. (_c.settings.language or "en") .. "^7")
            end

            if is_mismatch then
                print(_sep)
                print("^1[!] UPDATE AVAILABLE FOR " .. _mk:upper() .. " [!]^7")
                if remote.download then
                    print("^7Download: ^5" .. remote.download .. "^7")
                end
                if type(remote.changelog) == "table" and #remote.changelog > 0 then
                    print("^7Changelog:^7")
                    for i = 1, #remote.changelog do
                        print("  ^3* " .. remote.changelog[i] .. "^7")
                    end
                end
            end

            print(_sep)
        end, "GET", "", { ["User-Agent"] = "CASEIRL-VersionChecker" })
    end

    print_startup()
end