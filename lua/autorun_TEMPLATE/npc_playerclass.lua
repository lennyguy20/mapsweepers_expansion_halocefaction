-- This file isn't 100% necessary but it allows you to create the "player NPC" class, which NPC-team players
-- will respawn as. If you remove this file, nothing bad should happen, but you will be respawning as Antlion Reaper on npc team by default.

hook.Add("MapSweepersReady", "faction_YOURFACTIONNAME_playerclass", function()
	local class = {}
	jcms.class_Add("npc_YOURFACTIONNAMEnpc", class)

	class.faction = "YOURFACTIONNAME"
	class.mdl = "models/error.mdl" -- Replace to a model of your choice
	class.footstepSfx = ""

	class.deathSound = ""

	class.health = 50
	class.shield = 0
	class.shieldRegen = 0
	class.shieldDelay = 9999

	class.damage = 0.5 -- Damage multiplier
	class.hurtMul = 1.0 -- Damage TAKEN multiplier
	class.hurtReduce = 1 -- Subtracted from damage you TAKE
	class.speedMul = 1.0 -- Speed multiplier compared to Infantry

	function class.OnSpawn(ply)
		ply.jcms_bounty = 35 -- The bounty for killing you.

		-- If you want to give yourself a gun on spawn, uncomment next line (remove --):
		-- ply:Give("weapon_smg1")
	end

	if SERVER then
		function class.PrimaryAttack(ply, wep)
			-- This function, and class.SecondaryAttack, are not necessary if your NPC has a weapon.
			-- However, if you give yourself a weapon called 'weapon_jcms_playernpc',
			-- these functions will allow you to override exactly what happens on primary/secondary attack.
			-- For example, Zombie NPCs use these functions to attack with their claws or leap.
			-- If your NPC carries a gun then you don't need this.
		end

		function class.SecondaryAttack(ply, wep)
			-- Read the comment block above.
		end
	end

	if CLIENT then
		class.color = Color(255, 0, 0)
		class.colorAlt = Color(0, 255, 255)

		function class.HUDOverride(ply) -- Function for drawing the HUD.
			local col = Color(255, 0, 0)
			local colAlt = Color(, 255, 255)
			local sw, sh = ScrW(), ScrH()

			local weapon = ply:GetActiveWeapon()
			cam.Start2D()
				jcms.hud_npc_DrawTargetIDs(col, colAlt)
				jcms.hud_npc_DrawHealthbars(ply, col, colAlt)
				jcms.hud_npc_DrawCrosshair(ply, weapon, col, colAlt, colAlt) -- If your NPC is melee, replace DrawCrosshair to DrawCrosshairMelee
				jcms.hud_npc_DrawSweeperStatus(col, colAlt)
				jcms.hud_npc_DrawObjectives(col, colAlt)
				jcms.hud_npc_DrawDamage(col, colAlt)
			cam.End2D()
			surface.SetAlphaMultiplier(1)
		end

		function class.TranslateActivity(ply, act)
			-- This function is tricky. Basically here you're supposed to define "animations" for your NPC based on player animations.
			-- If you don't know what this means, or you don't want to bother, then set the model of your NPC to be a playermodel,
			-- then remove this function. This is for advanced Lua addon makers.
		end

		function class.ColorMod(ply, cm) -- Color modification for your NPC (makes combine see the world in blue for example)
			jcms.colormod["$pp_colour_addr"] = 0.11
			jcms.colormod["$pp_colour_addg"] = 0
			jcms.colormod["$pp_colour_addb"] = 0

			jcms.colormod["$pp_colour_mulr"] = 0.2
			jcms.colormod["$pp_colour_mulg"] = 0
			jcms.colormod["$pp_colour_mulb"] = 0

			jcms.colormod["$pp_colour_contrast"] = 1.25
			jcms.colormod["$pp_colour_brightness"] = -0.1

			jcms.colormod[ "$pp_colour_colour" ] = 0.9
		end

	end
end)