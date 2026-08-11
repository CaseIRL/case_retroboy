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

export class Handheld {
    constructor(payload) {
        this.data = payload || {};
        this.game_title = this.data.game_title || 'RETRO BOY';
        this.game_colour = this.data.game_colour || '#4dcbc2';
        this.faceplate_colour = this.data.faceplate_colour || '';
        this.faceplate_image = this.data.faceplate_image || '';

        this.game_url = this.data.game_url || '';
        this.time_interval = null;
        this.show_time = false;

        this.svgs = {
            dpad_up: `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-arrow-big-up-icon lucide-arrow-big-up"><path d="M9 19a1 1 0 0 0 1 1h4a1 1 0 0 0 1-1v-6a1 1 0 0 1 1-1h3.293a.707.707 0 0 0 .5-1.207l-7.086-7.086a1 1 0 0 0-1.414 0l-7.086 7.086a.707.707 0 0 0-1.414 0l-7.086 7.086a.707.707 0 0 0 .5 1.207H8a1 1 0 0 1 1 1z"/></svg>`,
            dpad_down: `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-arrow-big-down-icon lucide-arrow-big-down"><path d="M9 5a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v6a1 1 0 0 0 1 1h3.293a.707.707 0 0 1 .5 1.207l-7.086 7.086a1 1 0 0 1-1.414 0l-7.086-7.086a.707.707 0 0 1-.5-1.207H8a1 1 0 0 0 1-1z"/></svg>`,
            dpad_left: `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-arrow-big-left-icon lucide-arrow-big-left"><path d="M10.793 19.793a.707.707 0 0 0 1.207-.5V16a1 1 0 0 1 1-1h6a1 1 0 0 0 1-1v-4a1 1 0 0 0-1-1h-6a1 1 0 0 1-1-1V4.707a.707.707 0 0 0-1.207-.5l-6.94 6.94a1.207 1.207 0 0 0 0 1.707z"/></svg>`,
            dpad_right: `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-arrow-big-right-icon lucide-arrow-big-right"><path d="M13.207 19.793a.707.707 0 0 1-1.207-.5V16a1 1 0 0 1-1-1H5a1 1 0 0 1-1-1v-4a1 1 0 0 1 1-1h6a1 1 0 0 0 1-1V4.707a.707.707 0 0 1 1.207-.5l6.94 6.94a1.207 1.207 0 0 1 0 1.707z"/></svg>`,
            dpad_center: `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-circle-icon lucide-circle"><circle cx="12" cy="12" r="10"/></svg>`
        };

        this.build();
        this.bind_events();
        this.start_time_ticker();
    }

    render_dpad() {
        const directions = ['up', 'left', 'center', 'right', 'down'];
        return directions.map(dir => {
            const key = `dpad_${dir}`;
            return `<div class="crb_dpad_${dir}" data-btn="${key}">${this.svgs[key]}</div>`;
        }).join('');
    }

    render_buttons(items, extra_class = '', label_before = false) {
        return items.map(item => {
            const btn_html = `<button class="crb_btn ${extra_class}" data-btn="${item.id}"></button>`;
            const label_html = `<span class="crb_btn_label ${item.label_class || ''}">${item.label}</span>`;
            
            return `
                <div class="crb_btn_wrapper">
                    ${label_before ? label_html + btn_html : btn_html + label_html}
                </div>
            `;
        }).join('');
    }

    get_formatted_time() {
        const now = new Date();
        return now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', hour12: false });
    }

    start_time_ticker() {
        if (this.time_interval) clearInterval(this.time_interval);
        this.time_interval = setInterval(() => {
            $("#crb_time_overlay").text(this.get_formatted_time());
        }, 1000);
    }

    toggle_time_display() {
        this.show_time = !this.show_time;
        $("#crb_time_overlay").toggle(this.show_time);
    }

    build() {
        const top_buttons_data = [
            { id: 'close', label: 'CLOSE'},
            { id: 'time', label: 'TIME' },
            { id: 'pause', label: 'PAUSE' }
        ];

        const option_buttons_data = [
            { id: 'select', label: 'SELECT' },
            { id: 'start', label: 'START' }
        ];

        const action_buttons_data = [
            { id: 'b', label: 'B', label_class: 'large', extra_class: 'crb_btn_action crb_btn_b' },
            { id: 'a', label: 'A', label_class: 'large', extra_class: 'crb_btn_action crb_btn_a' }
        ];

        let faceplate_styles = [];
        if (this.faceplate_colour) {
            faceplate_styles.push(`background-color: ${this.faceplate_colour};`);
        }
        if (this.faceplate_image) {
            faceplate_styles.push(`background-image: url('${this.faceplate_image}'); background-size: cover; background-position: center;`);
        }
        const faceplate_style_attr = faceplate_styles.length > 0 ? `style="${faceplate_styles.join(' ')}"` : '';

        const screen_content = this.game_url ? `<iframe id="crb_game_iframe" src="${this.game_url}" style="width: 100%; height: 100%; display: block; border: none; background: transparent;" sandbox="allow-scripts allow-same-origin"></iframe>` : '';

        const content = `
            <div class="crb_console_outer" style="--game_colour: ${this.game_colour};">
                <div class="crb_console_shell">
                    <div class="crb_faceplate" ${faceplate_style_attr}>
                        <div class="crb_face_side">
                            <div class="crb_logo">
                                <img src="/src/ui/assets/case_icon.png" alt="Logo" />
                            </div>
                            <div class="crb_dpad">
                                ${this.render_dpad()}
                            </div>
                        </div>
                        <div class="crb_face_center">
                            <div class="crb_screen_header">${this.game_title}</div>
                            <div class="crb_screen_outer">
                                <div class="crb_screen_border">
                                    <div class="crb_screen" style="position: relative;">
                                        ${screen_content}
                                        <div id="crb_time_overlay" class="crb_time_overlay" style="display: none;">${this.get_formatted_time()}</div>
                                    </div>
                                </div>
                            </div>
                            <div class="crb_screen_footer">CaseIRL™</div>
                        </div>
                        <div class="crb_face_side">
                            <div class="crb_top_btns">
                                ${this.render_buttons(top_buttons_data, 'crb_btn_small')}
                            </div>

                            <div class="crb_bottom_btns">
                                <div class="crb_option_btns">
                                    ${this.render_buttons(option_buttons_data, 'crb_btn_pill', true)}
                                </div>

                                <div class="crb_action_btns">
                                    ${action_buttons_data.map(btn => `
                                        <div class="crb_btn_wrapper">
                                            <button class="crb_btn ${btn.extra_class}" data-btn="${btn.id}"></button>
                                            <span class="crb_btn_label ${btn.label_class}">${btn.label}</span>
                                        </div>
                                    `).join('')}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        `;
        $("#ui_container").html(content);

        const iframe = document.getElementById('crb_game_iframe');
        if (iframe) {
            iframe.onload = () => {
                if (iframe.contentWindow) {
                    iframe.contentWindow.postMessage({ type: 'handheld:open' }, '*');
                }
            };
        }
    }

    bind_events() {
        $("#ui_container").off("click", "[data-btn]").on("click", "[data-btn]", (e) => {
            const btn_name = $(e.currentTarget).data("btn");
            console.log(`Button clicked: ${btn_name}`);
            
            if (btn_name === 'time') {
                this.toggle_time_display();
                return;
            }

            const iframe = document.getElementById('crb_game_iframe');

            if (btn_name === 'close') {
                if (iframe && iframe.contentWindow) {
                    iframe.contentWindow.postMessage({ type: 'handheld:close' }, '*');
                }

                if (this.time_interval) clearInterval(this.time_interval);
                $("#ui_container").empty();
                $.post(`https://${GetParentResourceName()}/nui:close`, JSON.stringify({}));
                return;
            }

            window.dispatchEvent(new CustomEvent('handheld:input', { detail: { button: btn_name } }));

            if (iframe && iframe.contentWindow) {
                iframe.contentWindow.postMessage({ type: 'handheld:input', button: btn_name }, '*');
            }
        });
    }
}