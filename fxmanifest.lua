fx_version 'bodacious'
game 'gta5'
Author 'Stefan Vuksanović'

client_scripts {
    'client.lua'
}

server_script 'server.lua'

ui_page "html/index.html"

files {
    'html/*.html',
    'html/*.js',
    'html/*.css',
}

lua54 'yes'

-- escrow_ignore {
--     'config.lua',
-- }
server_scripts { '@mysql-async/lib/MySQL.lua' }