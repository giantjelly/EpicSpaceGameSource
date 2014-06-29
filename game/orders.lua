Orders = class('Orders')

function Orders.new (commands)

	local instance = instance(Orders)

	instance.commands = commands
	instance.commandIndex = 0
	instance.noOfCommands = 0
	for i, v in ipairs(instance.commands) do
		instance.noOfCommands = instance.noOfCommands + 1
	end

	return instance
end