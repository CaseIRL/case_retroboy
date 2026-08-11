# Settings

Quick settings overview
Some settings are important so read the more detailed instructions below

* `small_console_splash`: Hides startup changelogs to keep the console clean; leave false for full logs.
* `debug`: Enables script logging; keep false during normal play and turn true only for troubleshooting.
* `language`: Sets the active language string; matching translation files must be set up properly in code/locales.
* `standalone`: Bypasses framework and inventory checks; set true only for non-framework servers, forcing players to use `/retroboy:play "game"`.
* `require_item`: Enforces an inventory check; keep true so players need a physical item, or set false to use commands.
* `games`: Configures built-in mini-games (Snake, Pong) including titles and hex colors, but new games require editing UI and client code.
* `framework_map`: Maps server resource names to framework bridge files in configuration/bridge/framework/ for developers.
* `framework_auto_detection`: Automatically scans for supported frameworks; leave true for ESX, QBCore, Qbox, or ND Core.
* `framework`: Manual framework option (esx, nd, qb, qbx, custom) used when auto-detection is off.
* `inventory_map`: Maps inventory resource names to bridge files in configuration/bridge/inventory/ for developers.
* `inventory_auto_detection`: Automatically scans for supported inventories; leave true for ox_inventory or qb-inventory.
* `inventory`: Manual inventory option (qb, ox, custom) used when auto-detection is off.

## `standalone`

Toggle this to true if you are running a server without any framework or inventory system.
This completely disables all automatic integration layers.
Because of this, players will need to use the chat command `/retroboy:play "game"` to launch and play the mini-games.

## `require_item`

This setting determines whether players need a physical item in their inventory to open the console UI.
When enabled, the script checks for the item before granting access.
If disabled, the item check is skipped entirely and players can open it using commands instead.

## `framework_map`

This is a lookup table used by the auto-detection system to map active server resource names to internal bridge files.
The keys represent the exact folder names of your frameworks, while the values point to their matching bridge scripts inside `configuration/bridge/framework/`. 

## `framework`

This specifies which framework bridge file to load manually if auto-detection is turned off.
It is completely ignored when auto-detection is enabled. 
Valid options that you can configure here include `esx`, `nd`, `qb`, `qbx`, or `custom`.

## `inventory_map`

A lookup table used by the auto-detection system to match live inventory resource names with internal bridge files.
The keys match the exact folder names of your inventories, while the values point to the correct handlers inside `configuration/bridge/inventory/`.

## `inventory_auto_detection`

Toggles whether the script automatically scans for supported inventory systems on your server.
Leave this set to true if you are running a standard inventory like `ox_inventory` or `qb-inventory`.
Disable it only if you are using a custom inventory setup.

## `inventory`

Specifies which inventory bridge file to load manually when auto-detection is turned off.
This setting is completely ignored if `inventory_auto_detection` is enabled.
Valid options that you can configure here include `qb`, `ox`, or `custom`.