# Mongo Protect

Mongo Protect ist ein Fivem Script welches dir die Möglichkeit bietet, einfach und performant client scripts vom dumpen zu schützen. Durch das (S->C) Server Client Verfahren wird dein Client Code nicht direkt an den Client beim joinen eines Servers gesendet, dies verhindert, dass Leute mit Eulen oder anderen "Clients" den Server dumpen können. Diese Technologie wird von einigen großen Servern bereits genutzt. 


## Fragen?

- Bei Fragen o.Ä meldet euch gerne in einem Issue

## Features

- Sehr einfache Implementierung
- Starke Performance
- Keine Server Dumps mehr im Internet
- 100% Konfigurierbar
- Keine Möglichkeit Modder Code doppelt zu laden

## Wie funktioniert das Script?

Dein Clientcode kann durch das betreten deines Servers durch ein "Client"/"Modmenu" ausgelsen werden, da dies lokal bei dir auf deinem PC gespeichert wird. Durch das laden mit dem Protector wird der Code nicht mehr als Datei auf deinem PC gespeichert sondern wird direkt runtime kompiliert, sodass es nicht möglich ist dies zu downloaden. 
## Nachteil

Bei jedem Vorteil gibt es auch einen kleine Nachteil, dieser Nachteil ist jedoch vermeidbar. Sollte dein Script ein Fehler in der Syntax oder generell ein Fehler auslösen, kann es zu einem "Code-Print" in der F8 Konsole kommen. Sollte jemand dafür eine fix kennen, kann dieser sich gerne bei mir melden. Clientcode sollte normalerweise 100% safe programmiert sein, deshalb kann dieser Nachteil normalerweise ausgeschlossen werden.


## Dependencies (Abhängigkeiten)

- Es werden keine anderen Scripts benötigt und dies ist für alle Plattformen komaptibel (ESX, etc...)

## Installation

src/deinscript/server.lua
```lua
// Füge dies zu deinem Serverside script hinzu

@client.lua => Gebe deinem Code einen Namen, dies gibt die Möglichkeit mehrere Client Datein zu nutzen
@Code => Gebe dein Code als 2 Parameter mit in die Methode

exports['mongo_protect']:addClientCode('client.lua', 

'Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)  -- Auf jede Frame aktualisieren

        -- Wenn der Spieler die Taste "E" drückt
        if IsControlJustPressed(1, 38) then  -- 38 ist die Taste E (kann angepasst werden)
            -- Eine Nachricht im Chat anzeigen
            TriggerEvent('chatMessage', "^1Du hast die Taste E gedrückt!")

            -- Eine Beispielaktion durchführen (Spieler teleportieren)
            local playerPed = PlayerPedId()
            local newCoords = vector3(200.0, 200.0, 100.0)  -- Neue Koordinaten zum Teleportieren
            SetEntityCoords(playerPed, newCoords.x, newCoords.y, newCoords.z, false, false, false, true)

            -- Info im Clientlog anzeigen
            print("Spieler wurde teleportiert!")
        end
    end
end)
')
```

src/fxmanifest.lua
```lua
shared_scripts {
  '@mongo_protect/shared/mongo_api.lua',
}
```

src/client/client.lua
```lua

@client.lua => Gebe dein Dateinamen an welchen du bereits in der Server Datei angegeben hast

Mongo.AddClientLoader('client.lua')
```

## Resultat

Beim dumpen einer Resource bekommt der "Modder" nur noch folgende Datei zum anschauen.

```lua
    Citizen.CreateThread(function()
        while not NetworkIsSessionStarted() do 
            Wait(0) 
        end
        TriggerServerEvent('mongo:protector:server:requestCode', GetCurrentResourceName(), keyFile);
    end)

    RegisterNetEvent('mongo:client:protector:loadCode:' .. GetCurrentResourceName() .. ':' .. keyFile, function (code)
        assert(load(code))();
    end)
```
