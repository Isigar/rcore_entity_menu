rcore = exports.rcore

rcore:addCmd('closemenu',function(source)
    TriggerClientEvent(triggerName('closemenu'),source)
end)

RegisterNetEvent(triggerName('createMenu'))
AddEventHandler(triggerName('createMenu'),function(menu)
    dprint('Inserting new menu - sending to client side')
    TriggerClientEvent(triggerName('createMenuInsert'),source,menu)
end)
