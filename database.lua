local e = easyporter
local database_path = minetest.get_worldpath() .. "/easyporter_db.json"

local portals

local file = io.open(database_path,"r")
if file then
	local portal_string = file:read("*all")
	portals = minetest.parse_json(portal_string)
	file:close()
end

if not portals then
	portals = {}
end

local function save_database()
	local file = assert(io.open(database_path,"w"))
	local database_string = minetest.write_json(portals,true)
	if database_string then
		file:write(database_string)
	end
	file:close()
end

e.set_portal = function(pos,name)
	if not name or not pos then
		return false
	end
	if portals[name] then
		-- Report if needed
	end
	portals[name] = pos
	save_database()
	minetest.chat_send_all("Set portal: " .. name)
	return true
end

e.remove_portal = function(name)
	if not name or not portals[name] then
		return false
	end
	portals[name] = nil
	save_database()
	minetest.chat_send_all("Removed portal: " .. name)
	return true
end

e.get_portal = function(name)
	return portals[name]
end
