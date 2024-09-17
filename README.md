# Mongo Protect

Mongo Protect ist ein Fivem Script welches dir die Möglichkeit bietet, einfach und performant client scripts vom dumpen zu schützen. Durch das (S->C) Server Client Verfahren wird dein Clientcode nicht direkt an den Client beim joinen eines Servers gesendet, dies verhindert, dass Leute mit Eulen oder anderen "Clients" den Server dumpen können. Diese Technologie wird von einigen großen Servern bereits genutzt. 


## Fragen?

- Bei Fragen o.Ä meldet euch gerne in einem Issue

## Features

- Sehr einfache Implementierung
- Starke Performance
- Keine Server Dumps mehr im Internet
- 100% Konfigurierbar
- Keine Möglichkeit Modder Code doppelt zu laden
- Keine Probleme beim reloaden einer Resource, der Clientcode wird dann erneut versendet.

## Wie funktioniert das Script?

Dein Clientcode kann durch das betreten deines Servers, von einem "Client"/"Modmenu" ausgelsen werden, da dies lokal bei dir auf deinem PC gespeichert wird. Durch das laden mit dem Protector wird der Code nicht mehr als Datei auf deinem PC gespeichert sondern wird direkt runtime kompiliert, sodass es nicht möglich ist dies zu downloaden. 
## Nachteil

Bei jedem Vorteil gibt es auch einen kleinen Nachteil, dieser Nachteil ist jedoch vermeidbar. Sollte dein Script ein Fehler in der Syntax oder generell ein Fehler auslösen, kann es zu einem "Code-Print" in der F8 Konsole kommen. Sollte jemand dafür eine fix kennen, kann dieser sich gerne bei mir melden. Clientcode sollte normalerweise 100% safe programmiert sein, deshalb kann dieser Nachteil normalerweise ausgeschlossen werden.


## Dependencies (Abhängigkeiten)

- Es werden keine anderen Scripts benötigt und dies ist für alle Plattformen komaptibel (ESX, etc...)

## Installation

WICHTIG: Der Clientcode darf nicht mehr in der fxmanifest.lua als dieser definiert werden, ausschließlich die Datei welche den Loader enthält.

src/deinscript/server.lua
```lua
// Füge dies zu deinem Serverside script hinzu

@client.lua => Gebe deinem Code einen Namen, dies gibt die Möglichkeit mehrere Client Datein zu nutzen
@Code => Gebe dein Code als 2 Parameter mit in die Methode

local code = [[
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if IsControlJustPressed(1, 38) then 
            TriggerEvent('chatMessage', "^1Du hast die Taste E gedrückt!")
            local playerPed = PlayerPedId()
            local newCoords = vector3(200.0, 200.0, 100.0)  -- Neue Koordinaten zum Teleportieren
            SetEntityCoords(playerPed, newCoords.x, newCoords.y, newCoords.z, false, false, false, true)
            print("Spieler wurde teleportiert!")
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

@client.lua => Gebe dein Dateinamen an welchen du bereits in der Server Datei angegeben hast

Mongo.AddClientLoader('client.lua')
```

## Resultat

Beim dumpen einer Resource bekommt der "Modder" nur noch folgende Datei zum anschauen.

```lua
Mongo.AddClientLoader('client.lua');
```
