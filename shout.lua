local function toggleShout(sModerator, sPlayer)
	if not sPlayer or "" == sPlayer then
		return false, "ERROR: Invalid number of arguments. Please supply the player name."
	end
	local tPrivs = minetest.get_player_privs(sPlayer)
	local sAction
print(dump(tPrivs))
	-- this does not work
	--tPrivs.shout = not tPrivs.shout
	if tPrivs.shout then
		tPrivs.shout = nil
		sAction = "revoked"
	else
		tPrivs.shout = true
		sAction = "granted"
	end
print(dump(tPrivs))
	minetest.set_player_privs(sPlayer, tPrivs)
	local sOut = "Shout priv of %s has been %s."
	local sLog = "Moderator %s has %s shout priv of/to %s."
	minetest.chat_send_player(sModerator, sOut:format(sPlayer, sAction))
	minetest.log("action", sLog:format(sModerator, sAction, sPlayer))
end

local tToggleShout = {
	params = "<Player Name>",
	description = "Grant/revoke shout priv of a user\n"
		.. "You must have ban priv to use this. Please use with care, user will only "
		.. "be able to use /mail for communication.",
	privs = { ban = true },
	func = toggleShout
}

minetest.register_chatcommand("toggle_shout", tToggleShout)
