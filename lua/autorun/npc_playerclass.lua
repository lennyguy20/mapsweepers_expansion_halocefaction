-- DOOM Demons Expansion for Map Sweepers by Octantis Addons (MerekiDor & JonahSoldier)

hook.Add("MapSweepersReady", "faction_doomdemons_playerclass", function()
	local class = {}
	jcms.class_Add("npc_doomdemonsimp", class)

	class.faction = "doomdemons"
	class.mdl = "models/doom_eternal/monsters/imp/imp.mdl"
	class.footstepSfx = "doom_eternal/monsters/imp/imp_footstep_02.ogg"

	class.deathSound = "doom_eternal/monsters/imp/imp_death_3.ogg"

	class.health = 50
	class.shield = 0
	class.shieldRegen = 0
	class.shieldDelay = 9999

	class.damage = 0.8
	class.hurtMul = 1
	class.hurtReduce = 1
	class.speedMul = 1.5

	function class.OnSpawn(ply)
		ply:Give("weapon_jcms_playernpc", false)
		ply.jcms_bounty = 35
	end

	if SERVER then
		function class.PrimaryAttack(ply, wep)
			wep.Primary.Automatic = true
			wep:SetNextPrimaryFire(CurTime() + 1/3)

			local tr = util.TraceHull {
				start = ply:EyePos(), endpos = ply:EyePos() + ply:EyeAngles():Forward() * 48,
				mask = MASK_PLAYERSOLID, filter = { ply, wep }, mins = Vector(-8, -8, -12), maxs = Vector(8, 8, 12)
			}

			if (CurTime() - (wep.lastFrenzySound or 0) > 1.2) then
				ply:EmitSound("doom_eternal/monsters/imp/imp_attack_melee_"..math.random(1,4)..".ogg")
				wep.lastFrenzySound = CurTime()
			end

			if tr.Hit then
				ply:ViewPunch( AngleRand(-2, 2) )
				ply:EmitSound("NPC_FastZombie.AttackHit")

				if IsValid(tr.Entity) and tr.Entity:Health() > 0 then
					local dmg = DamageInfo()
					dmg:SetAttacker(ply)
					dmg:SetInflictor(ply)
					dmg:SetDamageType(DMG_SLASH)
					dmg:SetReportedPosition(ply:GetPos())
					dmg:SetDamagePosition(tr.HitPos)
					dmg:SetDamageForce(tr.Normal * 10000)
					dmg:SetAmmoType(-1)
					dmg:SetDamage(10)

					if tr.Entity.DispatchTraceAttack then 
						tr.Entity:DispatchTraceAttack(dmg, tr, tr.Normal)
					elseif tr.Entity.TakeDamageInfo then
						tr.Entity:TakeDamageInfo(dmg)
					end

					if tr.Entity.TakePhysicsDamage then
						tr.Entity:TakePhysicsDamage(dmg)
					end

					if jcms.team_JCorp(tr.Entity) then
						if ply:Health() < ply:GetMaxHealth() then
							ply:SetHealth( ply:Health() + 1 )
						end
					end
				end

				local start = ply:EyePos()
				start.x = start.x + math.Rand(-8, 8)
				start.y = start.y + math.Rand(-8, 8)
				start.z = start.z + math.Rand(-2, 8)
				util.Decal("Blood", start, tr.HitPos + tr.Normal * 5, ply)
			else
				ply:ViewPunch( AngleRand(-5, 5) )
				ply:EmitSound("NPC_FastZombie.AttackMiss")
			end
		end

		function class.SecondaryAttack(ply, wep)
			wep:SetNextSecondaryFire(CurTime() + 1)

			local fb = ents.Create("doom_proj_imp_fireball")
			fb:SetPos(ply:EyePos())
			fb:Spawn()
			fb:SetOwner(ply)
			fb.jcms_owner = ply

			local phys = fb:GetPhysicsObject()
			if IsValid(phys) then
				phys:Wake()
				phys:SetVelocity( ply:EyeAngles():Forward()*1300 )
			end

			if math.random() < 0.5 then
				ply:EmitSound("doom_eternal/monsters/imp/imp_attack_fireball_"..math.random(1, 4)..".ogg")
			end

			ply:EmitSound("doom_eternal/monsters/imp/imp_throw_"..math.random(1, 3)..".ogg")
		end
	end

	if CLIENT then
		class.color = Color(255, 64, 64)
		class.colorAlt = Color(255, 121, 32)

		function class.HUDOverride(ply)
			local col = Color(255, 64, 64)
			local colAlt = Color(255, 121, 32)
			local sw, sh = ScrW(), ScrH()

			local weapon = ply:GetActiveWeapon()
			cam.Start2D()
				jcms.hud_npc_DrawTargetIDs(col, colAlt)
				jcms.hud_npc_DrawHealthbars(ply, col, colAlt)
				jcms.hud_npc_DrawCrosshairMelee(ply, weapon, col, colAlt, colAlt)
				jcms.hud_npc_DrawSweeperStatus(col, colAlt)
				jcms.hud_npc_DrawObjectives(col, colAlt)
				jcms.hud_npc_DrawDamage(col, colAlt)
			cam.End2D()
			surface.SetAlphaMultiplier(1)
		end

		function class.TranslateActivity(ply, act)
			if act == 1001 then
				ply:SetSequence("glide")
				return
			end

			if ply:IsOnGround() then
				local myvector = ply:GetVelocity()
				local speed = myvector:Length()

				myvector.z = 0
				myvector:Normalize()
				local myangle = ply:GetAngles()
				ply:SetPoseParameter("move_yaw", math.AngleDifference( myvector:Angle().yaw, myangle.yaw))

				if speed > 10 then

					if not ply:IsWalking() then
						if ply:GetCycle() >= 1 then ply:SetCycle(0) end
						ply:SetSequence("run_forward")
						return
					else
						if ply:GetCycle() >= 1 then ply:SetCycle(0) end
						ply:SetSequence("walk_forward")
						return
					end
				else
					if ply:GetCycle() >= 1 then ply:SetCycle(0) end
					ply:SetSequence("idle")
					return
				end
			else
				ply:SetSequence("glide")
				return
			end
		end

		function class.ColorMod(ply, cm)
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