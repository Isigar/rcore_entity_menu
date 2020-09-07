function dprint(msg, ...)
    if Config.Debug then
        print(string.format('[rcore_entity_menu] '..msg,...))
    end
end

function triggerName(name)
    return string.format('rcore_entity_menu:%s',name)
end
