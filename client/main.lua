rcore = exports.rcore
rcore:getEsxInstance(function(obj)
    ESX = obj
end)

ENTITY_TYPE_OBJECT = 3
ENTITY_TYPE_VEHICLE = 2
ENTITY_TYPE_PED = 1

RAYCAST_FLAG_ALL = -1
RAYCAST_FLAG_MAP = 1
RAYCAST_FLAG_VEHICLES = 2
RAYCAST_FLAG_PEDS = 8
RAYCAST_FLAG_OBJECTS = 16

local menuOpen = false
local menuEntity
local openedMenu
local keys = rcore:getKeys()
local playerData
local foundModel, startPos, endPos, foundEntity, foundMenu, foundDist

AddEventHandler('rcore:changePlayer', function(xPlayer)
    playerData = xPlayer
end)

AddEventHandler('onClientResourceStart', function(name)
    if name == GetCurrentResourceName() then
        if ESX.IsPlayerLoaded() then
            playerData = ESX.GetPlayerData()
        end
    end
end)

function whitelistFunctions(items)
    local output = {}
    for i, v in pairs(items) do
        if v.jobs ~= nil then
            if isInJob(v.jobs) then
                v['cb'] = nil
                table.insert(output, v)
            end
        else
            v['cb'] = nil
            table.insert(output, v)
        end
    end
    return output
end

function isInJob(jobs)
    if playerData ~= nil and playerData.job ~= nil then
        if rcore:tableLength(jobs) > 0 then
            for i, job in pairs(jobs) do
                if job == playerData.job.name then
                    return true
                end
            end
        end
    end
    return false
end

function turnOnMenu(menu)
    local wlMenu = rcore:deepCopy(menu)
    wlMenu.points = nil
    wlMenu.items = whitelistFunctions(wlMenu.items)
    if rcore:tableLength(wlMenu.items) > 0 then
        SetCursorLocation(0.5, 0.5)
        SendNUIMessage({
            menu = wlMenu,
            action = 'turnon'
        })
        SetNuiFocus(true, true)
        menuOpen = true
    end
end

function turnOffMenu()
    SendNUIMessage({
        menu = true,
        action = 'turnoff'
    })
    SetNuiFocus(false, false)
    menuOpen = false
end

RegisterNetEvent(triggerName('closemenu'))
AddEventHandler(triggerName('closemenu'), function()
    turnOffMenu()
end)

RegisterNUICallback('close', function(data, cb)
    turnOffMenu()
    cb('ok')
end)

RegisterNUICallback('click', function(data, cb)
    if menuOpen then
        local found = false
        for i, v in pairs(openedMenu.items) do
            if data.item == v.name then
                found = v
                break
            end
        end
        if found.cb ~= nil then
            found.cb(menuEntity)
        end
    end
    cb('ok')
end)

Citizen.CreateThread(function()
    while true do
        if menuOpen then
            InvalidateIdleCam()
        end
        Citizen.Wait(1000)
    end
end)

local function RotationToDirection(rotation)
    local adjustedRotation = {
        x = (math.pi / 180) * rotation.x,
        y = (math.pi / 180) * rotation.y,
        z = (math.pi / 180) * rotation.z
    }
    local direction = {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        z = math.sin(adjustedRotation.x)
    }
    return direction
end

function foundObjectOptions(obj)
    for i, v in pairs(Config.Menu) do
        if v.object ~= nil and obj == v.object then
            return v
        end
    end
end

function foundOptions(model)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    local modelsMenu = {}
    for i, v in pairs(Config.Menu) do
        if model == v.model then
            table.insert(modelsMenu, v)
        end
    end

    if rcore:tableLength(modelsMenu) > 1 then
        for _, menu in pairs(modelsMenu) do
            if menu.points ~= nil then
                for _, point in pairs(menu.points) do
                    local dist = #(point.pos - coords)
                    if dist <= point.radius then
                        return menu
                    end
                end
            end
        end
    else
        return modelsMenu[1]
    end
end

function floatHelpText(text, entity, menu)
    if menuOpen == true then
        return ;
    end

    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(1, 0, 0, 0)
    local offsetX, offsetY, offsetZ = 0, 0, 0
    if foundMenu.helpOffset ~= nil then
        offsetX = foundMenu.helpOffset.x or 0
        offsetY = foundMenu.helpOffset.y or 0
        offsetZ = foundMenu.helpOffset.z or 0
    end

    local coords = GetOffsetFromEntityInWorldCoords(entity, offsetX, offsetY, offsetZ)
    SetFloatingHelpTextWorldPosition(0, coords.x, coords.y, coords.z + 1.0)
end

function rayCast(sPos, targetPos)
    if Config.Debug then
        DrawLine(sPos, targetPos, 0, 0, 255, 255)
    end

    local raycast = StartShapeTestCapsule(sPos.x, sPos.y, sPos.z, targetPos.x, targetPos.y, targetPos.z, 0.1, RAYCAST_FLAG_PEDS+RAYCAST_FLAG_OBJECTS, PlayerPedId(), 7)
    local _, hit, endCoords, _, entityHit = GetShapeTestResult(raycast)

    if hit and entityHit > 0 then
        local model = GetEntityModel(entityHit)
        local type = GetEntityType(entityHit)
        if Config.Debug then
            rcore:draw3DText(sPos, 'Model: '..model .. '\nEntity: ' .. entityHit, {
                size = 1.2
            })
        end

        local objMenu = foundObjectOptions(entityHit, type)
        local menu = nil
        if objMenu then
            menu = objMenu
        else
            menu = foundOptions(tonumber(foundModel))
        end

        if menu then
            foundMenu = menu
        else
            foundMenu = nil
        end
        foundEntity = entityHit
        startPos = sPos
        endPos = endCoords
        foundModel = model
        foundDist = #(startPos - endPos)
    else
        foundEntity = nil
        foundModel = nil
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if not menuOpen and foundMenu ~= nil and foundEntity ~= nil then
            if foundDist <= foundMenu.menuDistance then
                if foundMenu.help then
                    floatHelpText(foundMenu.help, foundEntity)
                end
                if IsControlJustReleased(0, keys['E']) then
                    turnOnMenu(foundMenu)
                    menuEntity = foundEntity
                    openedMenu = foundMenu
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        local cameraRotation = GetGameplayCamRot()
        local cameraCoord = GetGameplayCamCoord()
        local direction = RotationToDirection(cameraRotation)
        local distance = 8
        local destination = {
            x = cameraCoord.x + direction.x * distance,
            y = cameraCoord.y + direction.y * distance,
            z = cameraCoord.z + direction.z * distance
        }
        rayCast(pedCoords, vector3(destination.x, destination.y, destination.z))
        if menuOpen then
            Citizen.Wait(750)
        else
            if Config.Debug then
                Citizen.Wait(10)
            else
                Citizen.Wait(250)
            end
        end
    end
end)

function createMenu(menu)
    dprint('Creating new menu - inserting into config')
    local found = false
    if menu.name ~= nil then
        for i, v in pairs(Config.Menu) do
            if v.name ~= nil and v.name == menu.name then
                found = i
            end
        end
    end
    if found then
        Config.Menu[found] = menu
    else
        table.insert(Config.Menu, menu)
    end
end

exports('createMenu', createMenu)

function updateMenu(name, menu)
    local found = false
    for i, v in pairs(Config.Menu) do
        if name == v.name then
            found = i
            break
        end
    end
    dprint('Found %s menu index %s', name, found)
    if found ~= false then
        local oldMenu = Config.Menu[found]
        if oldMenu then
            for i, v in pairs(menu) do
                if oldMenu[i] ~= nil then
                    oldMenu[i] = v
                end
            end
            dprint('New object: %s', oldMenu.object)
            Config.Menu[found] = oldMenu
        end
    end
end

exports('updateMenu', updateMenu)

RegisterNetEvent(triggerName('createMenuInsert'))
AddEventHandler(triggerName('createMenuInsert'), function(menu)
    createMenu(menu)
end)

RegisterNetEvent(triggerName('doorSync'))
AddEventHandler(triggerName('doorSync'), function()

end)
