# Case RetroBoy

A handheld console for FiveM, built Game & Watch style.

Each console is intended to run one game, either through command or using an item.

Snake and Space Invaders come included and playable out of the box.

Beyond that it's a shell, games hook into it, built by you or bought from someone else, each one its own separate device.

---

## What's Actually In The Box

* Framework bridge - ESX, QBCore, QBX, ND, or custom, with auto-detection
* Inventory bridge - ox_inventory, qb-inventory, or custom
* A game registry so games can hook in, either bundled inside the resource or living in their own separate one
* Optional item-based launching, one item, one game
* Snake and Space Invaders included as working defaults, on by default, toggle them off in `settings.lua` if you don't want them

---

## Registering A Game

Bundled inside the resource itself:

```lua
local registry = require("shared.modules.registry")

registry.register({
    id = "snake",
    title = "SNAKE",
    url = "/games/snake/index.html"
})
```

Seperate resource (for anyone selling a game):

```lua
exports.case_retroboy:register_game({
    id = "invaders",
    title = "SPACE INVADERS",
    url = "nui://your_resource_name/index.html"
})
```

Everything else, config, item setup, the input contract games hook into, is in `_DOCUMENTATION`.

For a working example of a game registered externally instead of bundled in.

Download [case_retroboy_runnergame](https://github.com/caseirl/case_retroboy_runnergame) a simple runner game built as a separate resource, using the export above.

---

## Install

1. Drop it in as `case_retroboy`
2. `ensure case_retroboy` in your `server.cfg`
3. Set your framework and inventory in `configuration/settings.lua`
4. Restart, pull one out in-game

---

## License

Free to use, run, and modify.

Don't resell it, don't bundle it into something you're selling.

Games built to run on it are separate works, sell those all you want.

Full terms in [LICENSE](https://github.com/caseirl/case_retroboy/blob/main/LICENSE).

---

## Support

Bugs and issues go on GitHub.
Anything else, [caseirl.dev](https://caseirl.dev).
