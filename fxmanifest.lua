fx_version 'adamant'
games { 'gta5' }

ui_page "client/ui/index.html"
files {
    "client/ui/index.html",
    "client/ui/fonts/Circular-Bold.ttf",
    "client/ui/fonts/Circular-Book.ttf",
    "client/ui/assets/cursor.png",
    "client/ui/assets/close.png",
    "client/ui/front.js",
    "client/ui/script.js",
    "client/ui/style.css",
    "client/ui/vue.js",
    'client/ui/debounce.min.js'
}

server_scripts {
    'server/*.lua',
}

client_scripts {
    'client/*.lua',
}

shared_scripts {
    'shared/config.lua',
    'shared/common.lua'
}

dependencies {
    "rcore"
}















