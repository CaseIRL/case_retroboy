Here is the updated documentation incorporating the lifecycle events (`handheld:open` and `handheld:close`) alongside the input handler.

---

# Custom Games

The script works as a loader for iframes.
You can create your own custom HTML games to load with it.
You can use a regular DOM-based game or a canvas if you prefer, both work.

Screen size is enforced to **320px width** and **288px height**—make sure your game canvas matches.

All custom games must be registered using the server export first, otherwise they will not load:

```lua
exports.case_retroboy:register_game({
    id = "snake", -- Unique ID for game
    title = "Snake", -- Title for console
    url = "nui://your_resource_name/index.html", -- Path to your HTML page for game
    colour = "#4dcbc2", -- Optional: changes the shell colour on console
    faceplate_colour = "", -- Optional: changes the colour of the face
    faceplate_image = "" -- Optional: sets a background image on the face instead of colour
})

```

## Launching

Trigger the device to open and launch the game for a player:

```lua
exports.case_retroboy:play_game(source, "snake")

```

## Window Messages & Communication

Your game iframe communicates with the parent handheld via `window.addEventListener('message')`.
The parent console posts three main event types (`handheld:open`, `handheld:close`, and `handheld:input`).

```javascript
window.addEventListener('message', (e) => {
    if (!e.data || !e.data.type) return;

    switch (e.data.type) {
        case 'handheld:open':
            // Triggered when the handheld UI mounts/loads
            // Use this to display UI, initialize canvas, or start title screens
            open_game();
            break;

        case 'handheld:close':
            // Triggered when the user hits CLOSE on the handheld
            // Use this to cancel requestAnimationFrames, clear intervals, or mute audio
            close_game();
            break;

        case 'handheld:input':
            // Triggered when a console button is pressed
            const btn = e.data.button;
            handle_button_press(btn);
            break;
    }
});

```

### Event Types Breakdown

| Event Type | Sent When | Recommended Action |
| --- | --- | --- |
| `handheld:open` | Handheld shell mounts iframe | Display body (`display: flex`), reset variables, show title screen |
| `handheld:close` | Player clicks CLOSE button | Hide body (`display: none`), `cancelAnimationFrame()`, pause game loops |
| `handheld:input` | Player clicks console buttons | Perform in-game actions (jump, pause, select, move) |

### Available Buttons (`handheld:input`)

* **D-Pad:** `dpad_up`, `dpad_down`, `dpad_left`, `dpad_right`
* **Top Buttons:** `pause` *(Note: `close` and `time` are handled internally by the console)*
* **Option Buttons:** `select`, `start`
* **Action Buttons:** `a`, `b`

## Client-Side Lua Events

When a game is closed, the script also triggers a client-side Lua event in GTA V that you can hook into:

```lua
AddEventHandler('case_retroboy:cl:on_close', function(current_game)
    print("Game closed:", current_game)
end)
```