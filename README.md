# Mongo Protect

Mongo protect is a FiveM script that provides a simple and efficient way to protect client scripts from being dumped. By utilizing a Server-to-Client (S->C) procedure, the client code is not directly sent to the client upon joining a server. This prevents individuals using tools like Eulen or other "clients" from dumping the server's code. This technology is already being used by several major servers.


## Questions?

- If you have any questions or issues, feel free to open an issue.

## Features

- Very easy implementation
- Strong performance
- No more server dumps available online
- 100% configurable
- No possibility for modders to load code twice
- No issues when reloading a resource, the client code will be re-sent.

## How does the script work?

Your client code can be read by a "client" or "mod menu" when joining your server, as it is stored locally on your PC. However, by using the protector, the code is no longer saved as a file on your PC. Instead, it is compiled at runtime, making it impossible to download or access.

## Drawback

With every advantage, there's also a small drawback, though this one is avoidable. If your script contains a syntax error or triggers a general issue, it might result in a "code print" in the F8 console. If anyone knows a fix for this, feel free to reach out. Ideally, client code should be 100% error-free, so this drawback can typically be ruled out.


## Dependencies

- No additional scripts are required, and it is compatible with all platforms (ESX, etc.).

## Installation

Important: The client code should no longer be defined in the fxmanifest.lua, except for the file containing the loader.

src/server/server.lua
```lua
// Add the following to your server-side script:

@client.lua: Assign a name to your client code file. This allows you to use multiple client files.
@Code: Pass your code as the second parameter in the method.

local code = [[
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    
            if IsControlJustPressed(1, 38) then 
                TriggerEvent('chatMessage', "^1You pressed the E key.!")
                local playerPed = PlayerPedId()
                local newCoords = vector3(200.0, 200.0, 100.0)
                SetEntityCoords(playerPed, newCoords.x, newCoords.y, newCoords.z, false, false, false, true)
                print("Player has been teleported.!")
            end
        end
    end)
]]

exports['mongo_protect']:addClientCode('client.lua', code)
```

src/fxmanifest.lua
```lua
shared_scripts {
  '@mongo_protect/shared/mongo_api.lua',
}
```

src/client/client.lua
```lua

@client.lua: Specify the filename you have already indicated in the server file.

Mongo.AddClientLoader('client.lua')
```

## Result

When dumping a resource, the "modder" will only see the following file to review.

```lua
Mongo.AddClientLoader('client.lua');
```
