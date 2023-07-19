Protector = {};
Protector.Scripts = {};
Protector.Sendet = {};

RegisterNetEvent('mongo:protector:server:requestCode', function(invoking, key)
    if(Protector.Scripts[invoking]) then
        if(Protector.Scripts[invoking][key]) then
            if(not Protector.Sendet[source]) then
                Protector.Sendet[source] = {};
            end
            if(not Protector.IsCodeLoaded(source, invoking, key)) then
                Protector.SendDebug(invoking .. ' | ' .. key .. ' | ' .. GetPlayerName(source) .. ' wurde Clientside code gesendet!')
                Protector.AddLoadedCode(source, invoking, key);
                TriggerClientEvent("mongo:client:protector:loadCode:" .. invoking, source, key, Protector.Scripts[invoking][key]);
            else
                Protector.SendDebug(invoking .. ' | ' .. key .. ' | Es wurde versucht vermehrt den Code zu laden!')
            end
        else
            Protector.SendDebug(invoking .. ' | ' .. key .. ' wurde nicht gefunden!')
        end
    else
        Protector.SendDebug(invoking .. ' | Das Script wurde nicht richtig hinzugefügt!')
    end
end)


exports('addClientCode', function (keyFile, code)
    if(not Protector.Scripts[GetInvokingResource()]) then
        Protector.Scripts[GetInvokingResource()] = {};
    end
    Protector.Scripts[GetInvokingResource()][keyFile] = code;
    Protector.SendDebug(GetInvokingResource() .. ' | ' .. keyFile .. ' wurde erfolgreich hinzugefügt!')
end)


Protector.SendDebug = function(message)
    if(not Config.debug) then return end;
    print('Mongo | ' .. message)
end

AddEventHandler('onResourceStop', function(resourceName)
    if(resourceName == GetCurrentResourceName()) then
        Protector.SendDebug('Der Protector wurde erfolgreich gestoppt!');
        return;
    end
    if(Protector.Scripts[resourceName]) then
        Protector.Scripts[resourceName] = nil;
        for index, value in pairs(Protector.Sendet) do
            if(Protector.Sendet[index][resourceName]) then
                Protector.Sendet[index][resourceName] = nil;
            end
        end
        Protector.SendDebug('Die Resource ' .. resourceName .. ' wurde aus dem Cache gelöscht!');
    end
end)
  
Protector.IsCodeLoaded = function(source, invoking, key)
    if(not Protector.Sendet[source]) then
        return false;
    end
    if(not Protector.Sendet[source][invoking]) then
        return false;
    end

    if(not Protector.Sendet[source][invoking][key]) then
        return false;
    end
    return true;
end

Protector.AddLoadedCode = function(source, invoking, key)
    if(not Protector.Sendet[source]) then
        Protector.Sendet[source] = {};
    end
    if(not Protector.Sendet[source][invoking]) then
        Protector.Sendet[source][invoking] = {};
    end
    Protector.Sendet[source][invoking][key] = true;
end