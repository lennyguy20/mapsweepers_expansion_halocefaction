-- DOOM Demons Expansion for Map Sweepers by Octantis Addons (MerekiDor & JonahSoldier)

-- Table of Contents
-- 1: Faction
-- 2: NPCs
-- 3. Big Swarm Alert Sounds

hook.Add("MapSweepersReady", "faction_doomdemons", function()

	-- 1. Faction
	jcms.factions.doomdemons = {
		name = "doomdemons",
		color = Color(255, 72, 0)
	}

	-- 2. NPCs
	if SERVER then

		local function nextBotErrorBypass(npc) -- This function right here, you don't really need in your custom faction, unless you're using NextBots.
			-- These 3 lines down below are necessary if you're using NextBots.
			function npc:GetKnownEnemyCount() return 1 end
			function npc:UpdateEnemyMemory() end
			function npc:SetSchedule() end

			-- This block of code down here (between {{{ and }}}) is useless for NPCs that are not Doom Demons.
			-- {{{
				local ogFunc = npc.GenericGibs
				function npc:GenericGibs(...)
					if type(ogFunc) == "function" then
						local s = pcall(ogFunc, self, ...)

						if not s then
							local ed = EffectData()
							ed:SetRadius(self:GetModelRadius()/2)
							ed:SetOrigin(self:WorldSpaceCenter())
							ed:SetMagnitude(0.5)
							ed:SetFlags(0)
							util.Effect("jcms_bigblast", ed)
						end
					end
				end
			-- }}}
		end

		-- Fodder {{{
			jcms.npc_types.doomdemons_zombie = {
				faction = "doomdemons",
				
				danger = jcms.NPC_DANGER_FODDER,
				cost = 0.6,
				swarmWeight = 1,
				portalSpawnWeight = 1,
			
				class = "npc_de_zombie_hell",
				bounty = 20,

				postSpawn = function(npc)
					npc.jcms_dmgMult = 0.5
					nextBotErrorBypass(npc)
				end
			}

			jcms.npc_types.doomdemons_zombie_t3 = {
				faction = "doomdemons",
				
				danger = jcms.NPC_DANGER_FODDER,
				cost = 0.7,
				swarmWeight = 0.9,
				portalSpawnWeight = 0.8,
			
				class = "npc_de_zombie_tier3",
				bounty = 40,

				postSpawn = function(npc)
					npc.jcms_dmgMult = 0.35
					nextBotErrorBypass(npc)
				end
			}

			jcms.npc_types.doomdemons_imp = {
				faction = "doomdemons",
				
				danger = jcms.NPC_DANGER_FODDER,
				cost = 1.1,
				swarmWeight = 1,
				portalSpawnWeight = 0.75,
			
				class = "npc_de_imp",
				bounty = 35,

				postSpawn = function(npc)
					npc.jcms_dmgMult = 0.25
					nextBotErrorBypass(npc)
				end
			}

			jcms.npc_types.doomdemons_gargoyle = {
				faction = "doomdemons",
				
				danger = jcms.NPC_DANGER_FODDER,
				cost = 1.2,
				swarmWeight = 1,
				portalSpawnWeight = 0.75,
			
				class = "npc_de_gargoyle",
				bounty = 35,

				postSpawn = function(npc)
					npc.jcms_dmgMult = 0.25
					nextBotErrorBypass(npc)
				end
			}

			jcms.npc_types.doomdemons_soldier = {
				faction = "doomdemons",
				
				danger = jcms.NPC_DANGER_FODDER,
				cost = 1.5,
				swarmWeight = 1,
				portalSpawnWeight = 0.75,
			
				class = "npc_de_soldier",
				bounty = 40,

				portalScale = 1.2,

				postSpawn = function(npc)
					npc.jcms_dmgMult = 0.25
					nextBotErrorBypass(npc)
				end
			}

			jcms.npc_types.doomdemons_soldier_shield = {
				faction = "doomdemons",
				
				danger = jcms.NPC_DANGER_FODDER,
				cost = 1.5,
				swarmWeight = 0.3,
				portalSpawnWeight = 0.15,
			
				class = "npc_de_soldier_shield",
				bounty = 80,

				portalScale = 1.2,

				postSpawn = function(npc)
					npc.jcms_dmgMult = 0.25
					nextBotErrorBypass(npc)
				end
			}
		-- }}}

		-- Strong {{{
			jcms.npc_types.doomdemons_arachnotron = {
				faction = "doomdemons",
				
				danger = jcms.NPC_DANGER_STRONG,
				cost = 3,
				swarmWeight = 0.5,
				swarmLimit = 1,
			
				class = "npc_de_arachnotron",
				bounty = 200,

				portalScale = 3,

				postSpawn = function(npc)
					npc.jcms_dmgMult = 0.5
					nextBotErrorBypass(npc)
				end
			}

			jcms.npc_types.doomdemons_cacodemon = {
				faction = "doomdemons",
				
				danger = jcms.NPC_DANGER_STRONG,
				cost = 3,
				swarmWeight = 0.3,
				aerial = true,
				swarmLimit = 2,
			
				class = "npc_de_cacodemon",
				bounty = 150,

				portalScale = 2.5,

				postSpawn = function(npc)
					npc.jcms_dmgMult = 0.9
					nextBotErrorBypass(npc)
				end
			}

			jcms.npc_types.doomdemons_painelemental = {
				faction = "doomdemons",
				
				danger = jcms.NPC_DANGER_STRONG,
				cost = 3,
				swarmWeight = 0.3,
				aerial = true,
				swarmLimit = 2,
			
				class = "npc_de_painelemental",
				bounty = 250,

				portalScale = 3,

				postSpawn = function(npc)
					npc.jcms_dmgMult = 0.85
					nextBotErrorBypass(npc)
				end
			}

			jcms.npc_types.doomdemons_carcass = {
				faction = "doomdemons",
				
				danger = jcms.NPC_DANGER_STRONG,
				cost = 2,
				swarmWeight = 0.3,
				swarmLimit = 1,
			
				class = "npc_de_carcass",
				bounty = 100,

				portalScale = 1.5,

				postSpawn = function(npc)
					npc.jcms_dmgMult = 0.5
					nextBotErrorBypass(npc)
				end
			}

			jcms.npc_types.doomdemons_hellknight = {
				faction = "doomdemons",
				
				danger = jcms.NPC_DANGER_STRONG,
				cost = 1.7,
				swarmWeight = 0.4,
				swarmLimit = 3,
			
				class = "npc_de_hellknight",
				bounty = 125,

				portalScale = 1.5,

				postSpawn = function(npc)
					npc.jcms_dmgMult = 0.35
					nextBotErrorBypass(npc)
				end
			}

			jcms.npc_types.doomdemons_revenant = {
				faction = "doomdemons",
				
				danger = jcms.NPC_DANGER_STRONG,
				cost = 1.8,
				swarmWeight = 0.4,
				swarmLimit = 3,
			
				class = "npc_de_revenant",
				bounty = 140,

				portalScale = 1.5,

				postSpawn = function(npc)
					npc.jcms_dmgMult = 0.25
					nextBotErrorBypass(npc)
				end
			}

			jcms.npc_types.doomdemons_dreadknight = {
				faction = "doomdemons",
				
				danger = jcms.NPC_DANGER_STRONG,
				cost = 2,
				swarmWeight = 0.1,
				swarmLimit = 1,
			
				class = "npc_de_dreadknight",
				bounty = 180,

				portalScale = 1.75,

				postSpawn = function(npc)
					npc.jcms_dmgMult = 0.35
					nextBotErrorBypass(npc)
				end
			}

			jcms.npc_types.doomdemons_whiplash = {
				faction = "doomdemons",
				
				danger = jcms.NPC_DANGER_STRONG,
				cost = 1.8,
				swarmWeight = 0.12,
				swarmLimit = 2,
			
				class = "npc_de_whiplash",
				bounty = 165,

				portalScale = 1.5,

				postSpawn = function(npc)
					npc.jcms_dmgMult = 0.25
					nextBotErrorBypass(npc)
				end
			}

			jcms.npc_types.doomdemons_mancubus = {
				faction = "doomdemons",
				
				danger = jcms.NPC_DANGER_STRONG,
				cost = 1.5,
				swarmWeight = 0.3,
				swarmLimit = 2,
			
				class = "npc_de_mancubus",
				bounty = 175,

				portalScale = 3.2,

				postSpawn = function(npc)
					npc.jcms_dmgMult = 0.25
					nextBotErrorBypass(npc)
				end
			}

			jcms.npc_types.doomdemons_pinky = {
				faction = "doomdemons",
				
				danger = jcms.NPC_DANGER_STRONG,
				cost = 1.5,
				swarmWeight = 0.2,
				swarmLimit = 1,
			
				class = "npc_de_pinky",
				bounty = 120,

				portalScale = 2,

				postSpawn = function(npc)
					npc.jcms_dmgMult = 0.75
					nextBotErrorBypass(npc)
				end
			}

			jcms.npc_types.doomdemons_prowler = {
				faction = "doomdemons",
				
				danger = jcms.NPC_DANGER_STRONG,
				cost = 1.2,
				swarmWeight = 0.4,
				swarmLimit = 2,
			
				class = "npc_de_prowler",
				bounty = 120,

				portalScale = 1.5,

				postSpawn = function(npc)
					npc.jcms_dmgMult = 0.75
					nextBotErrorBypass(npc)
				end
			}
		-- }}}

		-- Bosses {{{
			jcms.npc_types.doomdemons_baron = {
				faction = "doomdemons",
				
				danger = jcms.NPC_DANGER_BOSS,
				cost = 2,
				swarmWeight = 1.2,
				swarmLimit = 1,
			
				class = "npc_de_baron",
				bounty = 300,

				portalScale = 4,

				postSpawn = function(npc)
					npc.jcms_dmgMult = 0.15
					nextBotErrorBypass(npc)
				end
			}

			jcms.npc_types.doomdemons_doomhunter = {
				faction = "doomdemons",
				
				danger = jcms.NPC_DANGER_BOSS,
				cost = 3,
				swarmWeight = 1,
				swarmLimit = 1,
			
				class = "npc_de_doomhunter",
				bounty = 450,

				portalScale = 3.75,

				postSpawn = function(npc)
					npc.jcms_dmgMult = 0.2
					nextBotErrorBypass(npc)
				end
			}

			jcms.npc_types.doomdemons_marauder = {
				faction = "doomdemons",
				
				danger = jcms.NPC_DANGER_BOSS,
				cost = 3,
				swarmWeight = 1.2,
				swarmLimit = 1,
			
				class = "npc_de_marauder",
				bounty = 666,

				portalScale = 1.5,

				postSpawn = function(npc)
					npc.jcms_dmgMult = 0.25
					nextBotErrorBypass(npc)
				end
			}
		-- }}}

		-- Rare Bosses {{{
			jcms.npc_types.doomdemons_marauder_immora = {
				faction = "doomdemons",
				
				danger = jcms.NPC_DANGER_RAREBOSS,
				cost = 4,
				swarmWeight = 1,
				swarmLimit = 1,
			
				class = "npc_de_marauder_immora",
				bounty = 888,

				portalScale = 1.6,

				postSpawn = function(npc)
					npc.jcms_dmgMult = 0.3
					nextBotErrorBypass(npc)
				end
			}

			jcms.npc_types.doomdemons_cyberbaron = {
				faction = "doomdemons",
				
				danger = jcms.NPC_DANGER_RAREBOSS,
				cost = 3,
				swarmWeight = 1,
				swarmLimit = 1,
			
				class = "npc_de_baron_cyber",
				bounty = 400,

				portalScale = 4.1,

				postSpawn = function(npc)
					npc.jcms_dmgMult = 0.5
					nextBotErrorBypass(npc)
				end
			}
		-- }}}
	end

	-- 3. Big Swarm Alert Sounds
	if SERVER then
		jcms.director_bigSwarmPhrases.doomdemons = {
			["doom_eternal/monsters/lostsoul/lost_soul_spawn_01.ogg"] = 1,
			["doom_eternal/monsters/lostsoul/lost_soul_spawn_02.ogg"] = 1,
			["doom_eternal/monsters/lostsoul/lost_soul_spawn_03.ogg"] = 1,
			["doom_eternal/monsters/lostsoul/lost_soul_spawn_04.ogg"] = 1
		}
	end

	-- 4. Bestiary entries
	if CLIENT then
		jcms.bestiary.doomdemons_zombie = {
			faction = "doomdemons", 
			mdl = "models/doom_eternal/monsters/zombie/zombie_hell.mdl", 

			bounty = 20, 
			health = 40,

			camfov = 27,
		}

		jcms.bestiary.doomdemons_mancubus = {
			faction = "doomdemons", 
			mdl = "models/doom_eternal/monsters/mancubus/mancubus.mdl", 

			bounty = 175, 
			health = 700
		}

		jcms.bestiary.doomdemons_marauder = {
			faction = "doomdemons", 
			mdl = "models/doom_eternal/monsters/marauder/marauder.mdl", 

			bounty = 666, 
			health = 900,

			camfov = 35,
			camlookvector = Vector(0, 0, 50)
		}
	end

end)
