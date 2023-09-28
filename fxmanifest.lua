fx_version 'adamant'
game 'gta5'
version '1.0.0-RELE22ASsE22tt2ss2'
author '💗 22 '
description 'Protect your Server from dumpers!'

server_scripts {
    'src/locales/mongo_*.lua',
    'src/_config.lua',
    'src/server/server.lua'
}

client_scripts {
    'src/shared/mongo_api.lua',
}
