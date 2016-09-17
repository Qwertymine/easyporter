local e = easyporter

local portal_in = {
	description = "In portal",
	tiles = {"default_mese_block.png"},
	is_ground_content = false,
	groups = {dig_immediate=3,source=1},
	after_place_node = function(pos)
		minetest.get_node_timer(pos):start(0.1)
	end,
	on_contruct = function(pos)
		minetest.get_node_timer(pos):start(0.1)
	end,
	on_timer = function(pos,_)
		local portal_pos = vector.add(pos,{x=0,y=1,z=0})
		local entity = minetest.get_objects_inside_radius(portal_pos,0.8)

		if entity and #entity >= 1 then
			local portal_name = e.get_portal_node(pos)
			if portal_name then
				for i,v in ipairs(entity) do
					e.tp_to_portal(portal_name,v)
				end
				e.try_collapse(portal_name)
			end
		end
		return true
	end,
}

minetest.register_node("easyporter:in",portal_in)

minetest.register_craft{
	output = "easyporter:in",
	recipe = {
		{"default:diamond","default:mese","default:diamond"},
		{"default:diamond","default:mese_crystal","default:diamond"},
		{"default:diamond","default:mese_crystal","default:diamond"},
	},
}
