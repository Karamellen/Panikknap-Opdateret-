local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","panikknap")

HT = nil
TriggerEvent('HT_base:getBaseObjects', function(obj)
    HT = obj
end)

RegisterServerEvent('sendChatMessage')
AddEventHandler('sendChatMessage', function(message)
    for k,v in pairs(vRP.getUsers({})) do
        local user_id = vRP.getUserId({v})
        if vRP.hasGroup({user_id, "Politi-Job"}) then 
            local _source = vRP.getUserSource({user_id})
            TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = message, length = 2500})
        end
    end
end)

HT.RegisterServerCallback("GetJob", function(source, cb)
    local user_id = vRP.getUserId({source})

    if vRP.hasGroup({user_id, "Politi-Job"}) then 
        vRP.getUserIdentity({user_id, function(i)
            local name = i.firstname.." "..i.name
            cb(true, name)
        end})
    end
end)