local CLASSES = {}
local METATABLES = {}

function printClass (table)

    print(table , ' {')

    for i, value in pairs(table) do
        if type(value) == 'function' then
            print('' , i ,'', '()')
        else
            print('' , i ,'', value)
        end
    end

    if getmetatable(table) then
	    print('' , 'metatable {')

	    for i, value in pairs(getmetatable(table).__index) do
	        if type(value) == 'function' then
	            print('' , '' , i .. ' ()')
	        else
	            print('' , '' , i ,'', value)
	        end
	    end

	    print('' , '}')
	end

    print('}')
end

function class (className)

	if CLASSES[className] then
		print('cannot create class, ' .. className .. ' already exists')
		return CLASSES[className]
	else
		local classTable = {}
		CLASSES[className] = classTable
		CLASSES[classTable] = className
		METATABLES[classTable] = { __index = classTable }

		--printTable(CLASSES[className])

		print('class ' .. className .. ' created')
		return classTable
	end
end

function instance (classTable, ...)

	if CLASSES[classTable] then
		local instanceTable
		if not classTable.super then
			instanceTable = setmetatable({}, METATABLES[classTable])
		else 
			instanceTable = setmetatable(classTable.super.new(...), METATABLES[classTable])
		end
		return instanceTable
	else
		print('class ' .. CLASSES[classTable] .. 'doesnt exists')
	end
end

function inherit (className, parentTable)

	if CLASSES[className] then
		print('cannot create class, ' .. className .. ' already exists')
		return CLASSES[className]
	else
		if not CLASSES[parentTable] then
			print('cannot create class, parent class ' .. CLASSES[parentTable] .. ' doesnt exists')
		else
			local classTable = setmetatable({}, { __index = parentTable })
			CLASSES[className] = classTable
			CLASSES[classTable] = className
			METATABLES[classTable] = { __index = classTable }
			classTable.super = parentTable

			print('class ' .. className .. ' created with parent class ' .. CLASSES[parentTable])
			return classTable
		end
	end
end