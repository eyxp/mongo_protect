Protector = {};
Protector.Scripts = {};
Protector.Sendet = {};

RegisterNetEvent('mongo:protector:server:requestCode', function(invoking, key)
    if (Protector.Scripts[invoking]) then
        if (Protector.Scripts[invoking][key]) then
            if (not Protector.Sendet[source]) then
                Protector.Sendet[source] = {};
            end
            if (not Protector.IsCodeLoaded(source, invoking, key)) then
                Protector.SendDebug(Protector.GetMsg('sended_code'):format(invoking, key, GetPlayerName(source)))
                Protector.AddLoadedCode(source, invoking, key);
                TriggerClientEvent("mongo:client:protector:loadCode:" .. invoking .. ':' .. key, source, Protector.Scripts[invoking][key]);
            else
                Protector.SendDebug(Protector.GetMsg('file_overload'):format(invoking, key));
            end
        else
            Protector.SendDebug(Protector.GetMsg('file_not_found'):format(invoking, key));
        end
    else
        Protector.SendDebug(Protector.GetMsg('script_not_found'):format(invoking));
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (resourceName == GetCurrentResourceName()) then
        Protector.SendDebug(Protector.GetMsg('stopped_own_resource'));
        return;
    end
    if (Protector.Scripts[resourceName]) then
        Protector.Scripts[resourceName] = nil;
        for index, value in pairs(Protector.Sendet) do
            if (Protector.Sendet[index][resourceName]) then
                Protector.Sendet[index][resourceName] = nil;
            end
        end
        Protector.SendDebug(Protector.GetMsg('resource_cache_clear'):format(resourceName));
    end
end)

exports('addClientCode', function(keyFile, code)
    if (not Protector.Scripts[GetInvokingResource()]) then
        Protector.Scripts[GetInvokingResource()] = {};
    end
    Protector.Scripts[GetInvokingResource()][keyFile] = code;
    Protector.SendDebug(Protector.GetMsg('script_added'):format(GetInvokingResource(), keyFile));
end)


Protector.SendDebug = function(message)
    if (not Config.debug) then return end;
    print('Mongo | ' .. message)
end

Protector.IsCodeLoaded = function(source, invoking, key)
    if (not Protector.Sendet[source]) then
        return false;
    end
    if (not Protector.Sendet[source][invoking]) then
        return false;
    end

    if (not Protector.Sendet[source][invoking][key]) then
        return false;
    end
    return true;
end

Protector.AddLoadedCode = function(source, invoking, key)
    if (not Protector.Sendet[source]) then
        Protector.Sendet[source] = {};
    end
    if (not Protector.Sendet[source][invoking]) then
        Protector.Sendet[source][invoking] = {};
    end
    Protector.Sendet[source][invoking][key] = true;
end


Protector.GetMsg = function (key)
    local msg = Locales[Config.Local][key];
    if(msg == nil) then 
        return 'Error: Try to get nil key (' .. key .. ')';
    end
    return msg;
end