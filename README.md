# qb-target-to-ox-target

----------------------------------------------------------------------------------------------
Features:
----------------------------------------------------------------------------------------------
- Jobs
- Gangs
- Multiple options arrays
- job and gang ranks
- converts width/length to size vec3 ( DEFAULT VALUE OF 3.5 SET TO WIDTH YOU WILL HAVE TO CHANGE THIS YOURSELF )
  
- if event = "qb-shops:247clerk", then its deleted -> it becomes:
onSelect = function()
    exports.ox_inventory:openInventory('shop', { type = 'REPLACEME', id = 1 })
end

(otherwise transfers data)

----------------------------------------------------------------------------------------------
Notes:
----------------------------------------------------------------------------------------------

Currently only supports BoxZones for qb-target but anyone can easily edit it to support much more.

Place any BOXZONE configs into config_target

run the script in-game

all configs will be converted to ox-target format via a client print, you can change it to console.log etc if you wish.

As is, to access it just go to: C:\Users\YOURNAME\AppData\Local\FiveM\FiveM.app\logs and search by latest, should be at the bottom.

----------------------------------------------------------------------------------------------
Example:
----------------------------------------------------------------------------------------------
Input:

["SASTHelicopter"] = {
    name = "SASTHelicopter",
    coords = vector3(-482.58, 5980.66, 31.3),
    length = 1,
    width = 1,
    heading = 12,
    debugPoly = false,
    minZ = 28.79,
    maxZ = 32.04,
    options = {
        {
            type = "client",
            event = "policejob:client:spawnSASTHelicopter",
            icon = "fas fa-helicopter",
            label = "Request Helicopter",
            job = {
                ["police"] = 0,
                ["doc"] = 0,
            }
        },
    },
    distance = 1.5
},

Output:

exports.ox_target:addBoxZone({
    name = "SASTHelicopter",
    coords = vec3(-482.579987, 5980.660156, 31.299999),
    size = vec3(1.000000, 1.000000, 3.500000),
    rotation = 12.000000,
    options = {
        {
            event = "policejob:client:spawnSASTHelicopter",
            icon = "fas fa-helicopter",
            label = "Request Helicopter",
            groups = {
                ["police"] = 0,
                ["doc"] = 0,
            },
        },
    },
})
