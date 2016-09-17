local e = easyporter

local function try_set_portal(pos)
	local name = e.get_portal_node(pos)
	if not name or not pos then
		return false
	end

	e.set_portal(pos,name)
end

local portal_out = {
	description = "Out portal",
	tiles = {"default_mese_block.png"},
	is_ground_content = false,
	groups = {dig_immediate=3,source=1},
	--[[
	after_place_node = function(pos)
		try_set_portal(pos)
	end,
	on_contruct = function(pos)
		try_set_portal(pos)
	end,
	--]]
	on_rightclick = function(pos,node)
		try_set_portal(pos)
	end,
	--[[
	after_dig_node = function(pos)
		local name = e.get_portal_node(pos)
		if name then
			e.remove_portal(name)
		end
	end,
	after_destruct = function(pos)
		local name = e.get_portal_node(pos)
		if name then
			e.remove_portal(name)
		end
	end,
	--]]
}

minetest.register_node("easyporter:out",portal_out)

minetest.register_craft{
	output = "easyporter:out",
	recipe = {
		{"default:diamond","default:mese_crystal","default:diamond"},
		{"default:diamond","default:mese_crystal","default:diamond"},
		{"default:diamond","default:mese","default:diamond"},
	},
}
