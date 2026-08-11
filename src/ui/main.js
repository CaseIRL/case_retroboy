/*
--------------------------------------------------

Author: Case | https://caseirl.dev
GitHub: https://github.com/caseirl/case_retroboy
License: https://github.com/caseirl/case_retroboy/blob/main/LICENSE

Do not resell or bundle.
Retain this header in all files.
Support honest open source development.

--------------------------------------------------
*/

import { Handheld } from './js/handheld.js';

let handheld = null;

const handlers = {
    play: (data) => {
        if (handheld) { handheld = null; }

        handheld = new Handheld({
            game_title: data.game_title,
            game_colour: data.game_colour,
            faceplate_colour: data.faceplate_colour,
            faceplate_image: data.faceplate_image,
            game_url: data.game_url
        });
    },

    close: () => {
        $("#ui_container").empty();
        handheld = null;
    }
}

window.addEventListener('message', (event) => {
    const data = event.data;
    if (data && data.func && handlers[data.func]) {
        handlers[data.func](data);
    }
});

/*
$(document).ready(function () {
    new Handheld({ 
        game_title: "RETRO SNAKE",
        game_colour: "#27b423", 
        game_url: "/games/snake/index.html"
    });
});
*/
