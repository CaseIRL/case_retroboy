# Locales

The script includes locale files to handle translations.
English language users can customise the language within `configuration/locales/en.lua`.

If you want to add your own language you can add a new file into `configuration/locales/` 
Make sure to COPY the `en.lua` in full and edit ONLY the strings not the table keys.
Every key must match `en.lua` exactly or the script will fail to read the translations.

Once you have created your custom language file update `language = "en"` in settings to your language.

Since the script is relatively small there isn't many language strings to edit.

```lua
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
```