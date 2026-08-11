# Install

Follow the steps bellow to install the resource in your server
This is mostly straight forward stuff
Make sure to read `2-Settings.md` for detailed instructions on the settings available

## Quick Steps

1. Download the latest version of `case_retroboy`.
2. Drop the folder into your server's root `resources` directory (do not put it inside your standalone folder if using qb/qbx).
3. Add `ensure case_retroboy` to your `server.cfg` below your framework and inventory.
4. Open `configuration/settings.lua` and adjust your required settings:
    - `standalone`: Set `true` to bypass frameworks, or `false` to use them.
    - `require_item`: Set `true` if players need an item to open it.
    - `framework` / `inventory`: Manual override options if auto-detection fails.
5. If you have `require_item` set to `true` add the items and images into your server:
    - Copy item list for your inventory from `_INSTALL/items.md` and paste into your server item list
    - Copy the images from `_INSTALL/images` and paste into your inventory resource
6. Restart server *(or type `refresh; ensure case_retroboy` into the console if standalone)*.
7. Test it in-game.