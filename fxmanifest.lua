fx_version 'adamant'
game 'gta5'
version '1.0.0-RELEASE'
author '💗 Jonass'
description 'Protect your Server from dumpers!'

server_scripts {
    'src/_config.lua',
    'src/server/server.lua'
}

client_scripts {
    'src/locales/mongo_*.lua',
    'src/shared/mongo_api.lua',
}