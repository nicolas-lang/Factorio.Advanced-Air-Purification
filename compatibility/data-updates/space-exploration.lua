local data_util = require("data_util")
--Recipe Changes
if mods["space-exploration"] then
	local recipe = nil
	-- Add Vitamelange to filter craft
	recipe = data.raw["recipe"]["advanced-pollution-filter"]
	table.insert(recipe.ingredients, {"se-vitamelange", 10})
	data.raw["recipe"]["advanced-pollution-filter"] = recipe
	
	-- Add scrap to filter recycling
	recipe = data.raw["recipe"]["restore-used-advanced-pollution-filter"]
	table.insert(recipe.results,{ type = "item",  name = "se-scrap", amount_min = 1, amount_max = 10, probability = 0.2})
	data_util.remove_result(recipe,"stone")
	data.raw["recipe"]["restore-used-advanced-pollution-filter"] = recipe
end
-- Tech Changes
if mods["space-exploration"] then
	-- Integrate tech with SE tech tree
	tech = data.raw["technology"]["advanced-air-purification"]
	-- change module tech req's
	data_util.tech_remove_prerequisite(tech, "productivity-module-3")
	data_util.tech_remove_prerequisite(tech, "speed-module-3")
	data_util.tech_remove_prerequisite(tech, "effectivity-module-3")
	table.insert(tech.prerequisites,"productivity-module-6")
	table.insert(tech.prerequisites,"speed-module-6")
	table.insert(tech.prerequisites,"effectivity-module-6")
	-- add tech tree req
	table.insert(tech.prerequisites,"se-energy-science-pack-2")
	table.insert(tech.prerequisites,"se-biological-science-pack-3")
	table.insert(tech.prerequisites,"se-material-science-pack-2")
	tech.unit.ingredients = {
		{ "se-energy-science-pack-2", 1 },
		{ "se-biological-science-pack-3", 1 },
		{ "se-material-science-pack-2", 1 },
	}
	data.raw["technology"]["advanced-air-purification"] = tech
	
	-- Re-Integrate Krastorio2 Tech for Air Filtering at a more meaningfull place in the tech tree	
	if mods["Krastorio2"] then
		tech = data.raw["technology"]["kr-improved-pollution-filter"]
		data_util.tech_remove_prerequisite(tech, "kr-matter-tech-card")
		table.insert(tech.prerequisites,"se-biological-science-pack-1")
		tech.unit.ingredients  = {
			{ "se-biological-science-pack-1", 1}
		}
		log(serpent.block(tech))
		data.raw["technology"]["kr-improved-pollution-filter"] = tech
	end
end