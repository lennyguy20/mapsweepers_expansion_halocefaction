-- You don't have to add a mission in your faction mod.
-- If you don't know Lua you should remove this file.
-- If you are good at lua and you want a mission type to come with your faction, use this as a template!

hook.Add("MapSweepersReady", "faction_YOURFACTIONNAME_mission", function()
		
	if SERVER then
		jcms.missions.MISSIONNAME = {
			faction = "YOURFACTIONNAME",

			generate = function(data, missionData)
				local difficulty = jcms.runprogress_GetDifficulty()

				jcms.mapgen_PlaceNaturals( jcms.mapgen_AdjustCountForMapSize(16) )
				jcms.mapgen_PlaceEncounters()

				-- Lua logic for generating your mission here.
			end,

			getObjectives = function(missionData)
				local completed = false -- Set to true if all objectives are ocmplete.
				
				if completed then
					-- If the mission is completed, we place down the evac.
					missionData.evacuating = true 

					if not IsValid(missionData.evacEnt) then
						missionData.evacEnt = jcms.mission_DropEvac(jcms.mission_PickEvacLocation(), 45)
					end
					
					return jcms.mission_GenerateEvacObjective() -- Automatically generates "Charge evac" then "Evacuate" objectives..
				else
					-- List of your objectives.
					-- 'type' is the name of the objective. It is localized as #jcms.obj_<type here>. For example type = "j" gets localized as "#jcms.obj_j" AKA "Kill everyone"
					-- If 'progress' is 0 and 'total' is 0, this objective will have no progress bar.
					-- If 'percent' is false, then objective will be displayed as "progress/total", for example: "5/25".
					-- If 'percent' is true, then objective will be displayed as a percentage ("20%" instead of "5/25")
					-- If 'completed' is true, the objective will be highlighted in blue. This is purely visual.

					return { 
						{ type = "j", progress = 0, total = 0, completed = false, percent = false }
					}
				end
			end
		}
	end

	if CLIENT then
		jcms.missions.MISSIONNAME = {
			faction = "YOURFACTIONNAME",
			tags = { "killsrequired", "hacking", "timer" }
			-- Valid mission tags: 'hacking', 'infighting', 'timer', 'extraorders', 'rarebosses', 'killsrequired', 'naturalhazard'
		}
	end

end)
