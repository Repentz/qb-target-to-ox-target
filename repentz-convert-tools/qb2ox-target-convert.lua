CreateThread(function()

    local config_target = load(LoadResourceFile(GetCurrentResourceName(), "config_target.lua"))()
    local originalData = config_target.originalData

    -- Convert and print
    for key, value in pairs(originalData) do
        local newData = {
            name = value.name,
            coords = vec3(value.coords.x, value.coords.y, value.coords.z), -- Using vec3 here
            size = vec3(value.width, value.length, 3.5),
            rotation = value.heading,
            options = {},
        }

        -- Check if options table exists and add to newData
        if value.options then
            for _, opt in ipairs(value.options) do
                local newOption = {
                    event = opt.event,
                    icon = opt.icon,
                    label = opt.label,
                }

                -- Populate groups table if gang or job data exists
                newOption.groups = {}

                if opt.gang then
                    if type(opt.gang) == "table" then
                        for groupName, rank in pairs(opt.gang) do
                            newOption.groups[groupName] = rank
                        end
                    else
                        newOption.groups[opt.gang] = 0
                    end
                end

                if opt.job then
                    if type(opt.job) == "table" then
                        for jobName, rank in pairs(opt.job) do
                            newOption.groups[jobName] = rank
                        end
                    else
                        newOption.groups[opt.job] = 0
                    end
                end

                if opt.event == "qb-shops:247clerk" then
                    newOption.onSelect = "function()\n                exports.ox_inventory:openInventory('shop', { type = 'REPLACEME', id = 1 })\n            end"
                end

                table.insert(newData.options, newOption)
            end
        end

        print("PRINTING OX DATA NOW")
        print("PRINTING OX DATA NOW")
        print("PRINTING OX DATA NOW")
        print("PRINTING OX DATA NOW")

        print("exports.ox_target:addBoxZone({")
        print("    name = " .. '"' .. newData.name .. '",')
        print(string.format("    coords = vec3(%f, %f, %f),", newData.coords.x, newData.coords.y, newData.coords.z))
        print(string.format("    size = vec3(%f, %f, %f),", newData.size.x, newData.size.y, newData.size.z))
        print(string.format("    rotation = %f,", newData.rotation))
        if #newData.options > 0 then
            print("    options = {")
            for _, opt in ipairs(newData.options) do
                print("        {")
                if opt.event ~= "qb-shops:247clerk" then
                    print(string.format("            event = %s,", '"' .. opt.event .. '"'))
                end
                print(string.format("            icon = %s,", '"' .. opt.icon .. '"'))
                print(string.format("            label = %s,", '"' .. opt.label .. '"'))
                if next(opt.groups) ~= nil then
                    print("            groups = {")
                    for groupName, rank in pairs(opt.groups) do
                        print(string.format("                [%s] = %d,", '"' .. groupName .. '"', rank))
                    end
                    print("            },")
                end
                if opt.onSelect and opt.event == "qb-shops:247clerk" then
                    print(string.format("            onSelect = %s", opt.onSelect))
                end
                print("        },")
            end
            print("    },")
        end
        print("})\n")
    end
end)

