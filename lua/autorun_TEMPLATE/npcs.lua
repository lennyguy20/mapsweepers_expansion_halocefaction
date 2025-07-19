hook.Add("MapSweepersReady", "faction_YOURFACTIONNAME", function()

	jcms.factions.YOURFACTIONNAME = {
		name = "YOURFACTIONNAME",
		color = Color(255, 0, 0) -- Set faction colour here (affects portals and spawn-effects)
	}

	if SERVER then
		-- Copy and paste this to create new NPCs. Remember to change the name!
		-- Replace YOURFACTIONNAME_NPCNAME.
		-- Examples of how default npcs are named: combine_elite, combine_hunter, zombie_fast, antlion_reaper, etc
		-- For example if you're making HECU pack, your npc names should start with hecu_

		-- 'faction' should be LOWERCASE 'internal'/'code' name of your faction
		-- 'danger' can be one of the following:
		-- 		* jcms.NPC_DANGER_FODDER - fodder NPCs, such as fast zombies
		--		* jcms.NPC_DANGER_STRONG - unique NPCs, for example reapers and combine snipers
		-- 		* jcms.NPC_DANGER_BOSS	 - boss NPCs, for example gunships or antlion guards
		--		* jcms.NPC_DANGER_RAREBOSS - super-bosses that only spawn from Flashpoint portals and in Hell mission type

		jcms.npc_types.YOURFACTIONNAME_NPCNAME = {
			faction = "YOURFACTIONNAME",
			
			danger = jcms.NPC_DANGER_FODDER,
			cost = 1, -- the 'cost' of spawning this npc. Small cost means more NPCs. Big cost means this NPC will spawn alone.
			swarmWeight = 1, -- rarity of this NPC. 1 means normal. 2 means twice as common. 0.1 means 10 times rarer than everyone else. 0 means never spawns.
			swarmLimit = 999, -- How many of these can spawn in a single wave.
			
			portalSpawnWeight = 1, -- rarity of this NPC spawning from an NPC Portal (the black-hole type structures around the map). Set to 0 to never spawn from portals.
			aerial = false, -- Set to true to spawn NPC midair on the Airgraph, for example like gunships
			episodes = false, -- Set to true if it requires HL2 Episodes Content
			proficiency = WEAPON_PROFICIENCY_VERY_GOOD, -- If your NPC uses guns, here's where you can alter proficiency, You can remove this line.

			anonymous = false, -- true means this NPC does not contribute to softcap and doesnt get tracked by director.
			isStatic = false, -- true means this NPC is immobile, like zombie spawners and polyps. 

			model = "models/combine_soldier_prisonguard.mdl", -- model override for your NPC. You can remove this line.
			skin = 1, -- Skin override for your NPC. You can remove this line.

			weapons = { -- What weapons this NPC can spawn with? You can remove this table.
				weapon_shotgun = 1, -- Numbers mean rarity.
				weapon_ar2 = 2,
				weapon_smg1 = 4 -- 4 means four times more common than other weapons.
			},

			class = "npc_zombie", -- IN-GAME entity name, for example npc_combine_s or npc_alyx 
			bounty = 20, -- How much J credits you get for killing this NPC

			portalScale = 1, -- Scale of the glowing white circle portal effect before NPC spawns in.

			-- These functions down below can removed if you don't need them.
			check = function(director)
				-- You can put your special conditions before NPC can spawn here.
				-- Return true if NPC can spawn, return false if npc can't spawn.
				return true
			end,

			preSpawn = function(npc)
				-- Lua function that gets executed *before* this NPC spawns in but when it already exists
			end,

			postSpawn = function(npc) -- Lua function that gets executed after this NPC spawns in
				npc.jcms_dmgMult = 1 -- You can change this number
			end,

			takeDamage = function(npc, dmg)
				-- Thi.s function is called whenver NPC takes damage. You can for example scale damage by using dmg:ScaleDamage(1.0)
			end,

			scaleDamage = function(npc, hitGroup, dmgInfo)
				-- Allows you to scale damage for various parts of the NPC's body
			end,

			damageEffect = function(npc, target, dmgInfo)
				-- This function runs whenever this NPC damages its target, which can be a player, a turret, etc
			end,

			think = function(npc)
				-- This function is called on the NPC every second as long as its alive.
			end,

			entityFireBullets = function(npc, bulletData)
				-- Allows you to override what happens when the NPC shoots bullets. Used for Strafer Gunships and Rebel Vanguards with flame bullets.
			end
		}
	end

	if SERVER then
		-- This allows you to set up a "commander" Ai for your faction.
		-- Most factions don't really need a commander though, so feel free to remove this,
		-- especially if you're bad at Lua.
		jcms.npc_commanders["YOURFACTIONNAME"] = {
			think = function(c)
				-- This function runs every second.
			end,
		
			postWaveSpawn = function(c)
				-- This function runs whenever there's a new swarm spawning in.
			end,
		
			flashpointSummon = function(c, flashPoint, boss)
				-- This function is executed whenever a Flashpoint is fully charged.
			end, 
		
			placePrefabs = function(c, data)
				-- Allows you to override prefabs that get spawned on missions with this faction.
				-- For example this is used with Zombies to spawn more respawn chambers.
				-- Check out how it works in the original Map Sweepers github repository.
			end
		}
	end

	if SERVER then
		-- These sounds play when a lot of NPCs are approaching. For example the Combine have Overwatch voice.
		jcms.director_bigSwarmPhrases.YOURFACTIONNAME = {
			["path/to/sound.mp3"] = 1,
			["path/to/another_sound.mp3"] = 0.5 -- 0.5 means this phrase is 2 times more rare than others
		}
	end

	if CLIENT then
		-- Optional bestiary entries for your NPCs.
		jcms.bestiary.YOURFACTIONNAME_NPCNAME = {
			name = "Custom NPC", 
			desc = "This is my awesome Custom NPC",
			-- 2 lines above must be removed if you have localization in your addon!
			-- If these lines are removed, the name & description will be:
			-- * name: #jcms.bestiary_YOURFACTIONNAME_NPCNAME
			-- * desc: #jcms.bestiary_YOURFACTIONNAME_NPCNAME_desc

			faction = "YOURFACTIONNAME", 
			mdl = "models/antlion_guard.mdl", 

			bounty = 20, 
			health = 100, -- Use "healthbar" addons or wikis to find out how much health an NPC has.
			
			-- Lines below are optional and can be removed.
			mats = { "models/jcms/cyberguard" }, -- Submaterial overrides for  the NPC. If you dont have custom materials remove this line.
			camlookvector = Vector(0, 0, 50), -- The position at which the camera will be looking. For big NPCs change the 3rd number to be bigger. For small NPCs change to 0,0,0
			camfov = 30, -- FOV of the camera in bestiary. Higher number for small NPCs, bigger FOV for huge NPCs.
			scale = 1.0 -- Scale of the NPC model, so that you can fit big models better
		}
	end

end)
