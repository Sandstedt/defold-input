--- Refer to mapper.md for documentation

local M = {}

local bindings = {}

local DEFAULT_PLAYER_BINDINGS = hash("DEFAULT_PLAYER_BINDINGS")


local function get_player_bindings(player)
	player = player or DEFAULT_PLAYER_BINDINGS
	bindings[player] = bindings[player] or {}
	return bindings[player]
end


--- Bind an input to an action, optionally associating the binding
-- to a specific player
-- @param input The input to bind (key, game pad, mouse etc)
-- @param action The action that will be generated by the input
-- @param player Optional id for a player to bind input to
-- @return Any previous action bound to the input
function M.bind(input, action, player)
	assert(input)
	assert(action)
	local bindings = get_player_bindings(player)
	local previous = bindings[input]
	bindings[input] = action
	return previous
end


--- Unbind (remove) an existing input binding
-- @param input The input to unbind (key, game pad, mouse etc)
-- @param player Optional id for a player to unbind input from
function M.unbind(input, player)
	assert(input)
	local bindings = get_player_bindings(player)
	bindings[input] = nil
end


--- Handle incoming input from a script by finding an input binding and
-- returning the bound action
-- @param input The input received from on_input funcion (ie action_id)
-- @param player Optional id for a player to get input binding for
-- @return The bound action or nil if no binding exists
function M.on_input(input, player)
	if not input then
		return nil
	end
	local bindings = get_player_bindings(player)
	return bindings[input]
end



return M
