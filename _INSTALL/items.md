# Item Lists

> **Note:** Only needed if `require_item = true` in `configuration/settings.lua`.

1. Copy item list below for your inventory and paste into your servers item list 
2. Copy the images from `_INSTALL/images` and paste into your inventory resource

If you are creating your own seperate games but don't want to make an image you can use the `crb_default.png` provided

## `qb-inventory`

- Paste item list into `qb-core/shared/items.lua`
- Add images into `qb-inventory/html/images`

```lua
crb_snake = { name = "crb_snake", label = "RetroBoy: Snake", weight = 100, type = "item", image = "crb_snake.png", unique = true, useable = true, shouldClose = true, combinable = nil, description = "A handheld Retro Boy console, Snake edition!" },
```

## `ox_inventory`

- Paste item list into `ox_inventory/data/items.lua`
- Paste images into `ox_inventory/web/images`

```lua
["crb_snake"] = {
    label = "RetroBoy: Snake",
    weight = 1,                                                                                                                           
    stack = false,
    close = true,
    server = {
        export = "case_retroboy.crb_snake"
    }
}
```