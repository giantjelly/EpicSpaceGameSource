Epic = {}

function Epic.class ()

	local classTable = {}

	classTable.new = function ( ... )

		local instance = Epic.instance(classTable)
		instance:construct( ... )
		return instance
	end

	return classTable
end

function Epic.inherit (parent)

	local classTable = setmetatable({}, { __index = parent })

	classTable.new = function ( ... )

		local instance = Epic.instance(classTable)
		instance:construct( ... )
		return instance
	end

	classTable.super = parent
	return classTable
end

function Epic.instance(classTable)
	
	local instanceTable
	if not classTable.super then 
		instanceTable = setmetatable({}, { __index = classTable })
	else
		instanceTable = setmetatable(classTable.super.new(), { __index = classTable })
	end
	return instanceTable
end



Animal = Epic.class()

function Animal:construct (name)
	
	self.name = name
	self.className = 'Animal'
end

function Animal:printClassName ()
	
	print(self.className, self.name)
end



Dog = Epic.inherit(Animal)

function Dog:construct (name, type)
	
	self.name = name
	self.type = type
end

function Dog:printType ()
	
	print(self.name..' type = '..self.type)
end

Cat = Epic.inherit(Animal)

function Cat:construct (name, sleepiness)
	
	self.name = name
	self.sleepiness = sleepiness
end

function Cat:sleep ()
	
	local str = self.name..' '
	for i = 0, self.sleepiness do
		str = str..'z'
	end

	print(str)
end



Oreo = Epic.inherit(Cat)

function Oreo:construct (derpiness)
	
	self.name = 'Oreo'
	self.sleepiness = 30
	self.derpiness = derpiness
end

function Oreo:info ()
	
	print(self.name..' is '..self.derpiness..' today')
	self:sleep()
end



oreo = Oreo.new('very derpy')
oreo:info()