Mongo = {};

Mongo.AddClientLoader = function(keyFile)
    Citizen.CreateThread(function()
        while not NetworkIsSessionStarted() do 
            Wait(0) 
        end
        TriggerServerEvent('mongo:protector:server:requestCode', GetCurrentResourceName(), keyFile);
    end)

    RegisterNetEvent('mongo:client:protector:loadCode:' .. GetCurrentResourceName() .. ':' .. keyFile, function (code)
        assert(load(code))();
    end)
end