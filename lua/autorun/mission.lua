-- DOOM Demons Expansion for Map Sweepers by Octantis Addons (MerekiDor & JonahSoldier)

hook.Add("MapSweepersReady", "faction_doomdemons_mission", function()
		
	if SERVER then
		jcms.missions.doomdemonscorruption = {
			faction = "doomdemons",

			generate = function(data, missionData)
				local difficulty = jcms.runprogress_GetDifficulty()

				jcms.mapgen_PlaceNaturals( jcms.mapgen_AdjustCountForMapSize(16) )
				jcms.mapgen_PlaceEncounters()

				missionData.kills_fodder = 0
				missionData.kills_strong = 0
				missionData.kills_bosses = 0

				local scaledDifficulty = difficulty^(2/3)
				missionData.kills_req_fodder = math.ceil(135 * scaledDifficulty)
				missionData.kills_req_strong = math.ceil(10 * scaledDifficulty)
				missionData.kills_req_bosses = math.ceil(3 * scaledDifficulty)

				hook.Add("OnNPCKilled", "doomdemonscorruption_KillTracker", function(npc, attacker, inflictor)
					if not (jcms.director and jcms.director.missionType == "doomdemonscorruption" and jcms.director.missionData and jcms.director.missionData.kills_fodder) then
						-- We're not in the mission anymore, get rid of the kills tracker.
						hook.Remove("OnNPCKilled", "doomdemonscorruption_KillTracker")
					else
						-- Attribute kills based on npc's strength.
						if IsValid(npc) and npc.jcms_danger and IsValid(attacker) and jcms.team_JCorp(attacker) then
							local md = jcms.director.missionData

							local danger = npc.jcms_danger
							if danger == jcms.NPC_DANGER_FODDER then
								if md.kills_fodder == md.kills_req_fodder-1 then -- Announce on the final kill
									jcms.net_SendTip("all", true, "#jcms.doomdemonscorruption_fodder", 1)
								end

								md.kills_fodder = math.min(md.kills_req_fodder, md.kills_fodder + 1)
							elseif danger == jcms.NPC_DANGER_STRONG then 
								if md.kills_strong == md.kills_req_strong-1 then -- Announce on the final kill
									jcms.net_SendTip("all", true, "#jcms.doomdemonscorruption_strong", 1)
								end

								md.kills_strong = math.min(md.kills_req_strong, md.kills_strong + 1)
							elseif danger == jcms.NPC_DANGER_BOSS then
								if md.kills_bosses == md.kills_req_bosses-1 then -- Announce on the final kill
									jcms.net_SendTip("all", true, "#jcms.doomdemonscorruption_bosses", 1)
								end

								md.kills_bosses = math.min(md.kills_req_bosses, md.kills_bosses + 1)
							end
						end
					end
				end)
			end,

			getObjectives = function(missionData)
				local completed = missionData.kills_fodder >= missionData.kills_req_fodder and missionData.kills_strong >= missionData.kills_req_strong and missionData.kills_bosses >= missionData.kills_req_bosses
				
				if completed then
					-- If the mission is completed, we place down the evac.
					missionData.evacuating = true 

					if not IsValid(missionData.evacEnt) then
						missionData.evacEnt = jcms.mission_DropEvac(jcms.mission_PickEvacLocation(), 45)
					end
					
					return jcms.mission_GenerateEvacObjective()
				else
					return { 
						{ type = "ddckillfodder", progress = missionData.kills_fodder, total = missionData.kills_req_fodder, completed = missionData.kills_fodder >= missionData.kills_req_fodder },
						{ type = "ddckillstrong", progress = missionData.kills_strong, total = missionData.kills_req_strong, completed = missionData.kills_strong >= missionData.kills_req_strong },
						{ type = "ddckillbosses", progress = missionData.kills_bosses, total = missionData.kills_req_bosses, completed = missionData.kills_bosses >= missionData.kills_req_bosses },
					}
				end
			end
		}
	end

	if CLIENT then
		jcms.missions.doomdemonscorruption = {
			faction = "doomdemons",
			tags = { "killsrequired" }
		}
	end

end)