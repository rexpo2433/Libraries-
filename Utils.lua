--[[
 0 1 0 1 0 0 1 1    
 0 1 1 0 1 1 1 1        ____          __        __         
 0 1 1 1 0 0 0 0       / __/__  ___  / /  __ __/ /__ ___ __
 0 1 1 0 1 0 0 0      _\ \/ _ \/ _ \/ _ \/ // / / _ `/\ \ /
 0 1 1 1 1 0 0 1     /___/\___/ .__/_//_/\_, /_/\_,_//_\_\ 
 0 1 1 0 1 1 0 0             /_/        /___/             
 0 1 1 0 0 0 0 1    
 0 1 1 1 1 0 0 0

	====================================
	|       Ensage Utility Library     |
	====================================
	
		This library consolidates functions that are often repeated in scripts as well as
		including extra class functions and additional functions.
	
	====================================
	|            How To Use            |
	====================================
		1. Place this script to the Ensage\Scripts\Libs folder
		2. Add 'require("libs.Utils")' to the top of your script, without single quotes.
		
	====================================
	|             Changelog            |
	====================================

		v1.2e:
		 - Adapted library for Ensage rework
		 - Removed LuaEntityNPC:GetAllItems(), LuaEntityNPC:GetAllSpells() and LuaEntityNPC:FindFlag(row)
		 - Added LuaEntityAbility:FindCastPoint(), LuaEntityNPC:IsUnitState(flag) and other unitState checking functions
		 - Added a "not" option to IsKeysDown()
		 - Added latency sensitive sleep and sleepcheck

		v1.2d:
		 - Fixed a bug in SafeCastAbility.

		v1.2c:
		 - Fixed a bug in GetType()
		 - Added 2 more classes to GetType()
		 - Added Ember Spirit: Sleight of Fist modifier to hidden list.
		 - Added Ember Spirit: Flame Guard modifier to damage reduction calculations.
		 - Fixed bunch of errors at damage calculations.
		 - Added LuaEntityNPC:FindModifier(name)
		 - Added LuaEntityAbility:IsBehaviourType(flag)
		 - Added LuaEntityAbility:IsTargetType(flag)
		 - Added LuaEntityAbility:IsTargetTeam(flag)
		 - Added LuaEntityAbility:IsAbilityType(flag)
		 - Added LuaEntityAbility:IsDamageType(flag)
		 - Added LuaEntityAbility:GetSpecialData(name[,level])
		 - Fixed a bug in SafeCastItem and CastItem, now it should toggle Ring of Basilius and Ring of Aquila.
		 - Fixed a bug in IsKeysDown

		v1.2b:
		 - Fixed a typo.

		v1.2a:
		 - Fixed the error in Plague Aura damage calculations.

		v1.2:
		 - CanAttack() now checks the attack type of the unit
		 - IsRanged() now operates on attackType
		 - SafeCastAbility() now doesn't assume ability was a spell when checking casting conditions
		 - Removed GetOwner() and IsHidden()
		 - Fixed a rare bug in GetType()
		 - Updated the inheritance system

		v1.1c:
		 - Tweaked the libraries to make it fit the new LuaEntity class system
		 - Reworked GetOwner
		 - Added IsHidden for CDOTABaseAbility
		 - Removed some forgotten debug elements

		v1.1b:
		 - Fixed bugs related to LuaEntityNPC:DamageTaken()

		v1.1a:
		 - PlayingGame() now returns false if game is paused.
		 - Fixed SafeCastAbility and CastAbility
		 - Removed errors from class detection

		v1.1:
		 - Fixed Linken's Detection

		v1.0:
		 - Released
		
	====================================
	|               API                |
	====================================

 		----- Globals -----


			-----> Damage Types <-----
			
			DAMAGE_PHYS					-- Physical Damage
			DAMAGE_MAGC					-- Magic Damage
			DAMAGE_PURE					-- Pure Damage
			DAMAGE_COMP					-- Composite Damage
			DAMAGE_HPRM					-- HP Removal Damage
			DAMAGE_UNIV					-- Universal Damage


			-----> Power Treads States <-----

			PT_STR						-- Strength
			PT_INT						-- Intelligence
			PT_AGI						-- Agility


			-----> Linken Block Extras <-----

			LINKEN_MINOR_BLOCK			-- Linkens block a minor part of the spell
			LINKEN_MAJOR_BLOCK			-- Linkens block a major part of the spell



		----- Global Functions -----

			GetDistance2D(a[,b]): Returns the 2D (ignoring height) distance between 2 units, locations or one unit and one location.
				a: First Unit/Location.
				b: Second Unit/Location. If not entered it defaults as "me" value.

			IsKeysDown(keyTable,orCheck): Returns "true" if all the keys in the table is pressed. Returns "true" if any of them is pressed if orCheck is "true"

			IsIngame(): Returns whether player is in a game.

			PlayingGame(): Returns whether player is playing game.


			SleepCheck([id]): Returns "true" if given id is finished sleep period
				id: Identification for a sleep instance. If not entered checks the global sleep instance.

			Sleep(time[,id]): Sleeps given sleep instance for given amount of ms. If sleep instance is sleeping for more than given time already it will not overwrite it.
				time: Amount of time in miliseconds.
				id: Identification for a sleep instance. If not entered sleeps the global sleep instance.


			SetDebugState(): Sets debug state of the script.

			IsDebugActive(): Returns "true" if debug is active.

			DebugPrint(text): Prints a text in a format if debug is active.


			SelectUnit(unit): Selects a given unit and returns the previously selected table.
				unit: Unit that will be selected
			SelectBack(table): Selects back a given table of units.
				table: Table of units which will be selected back. Primary source for this table is "SelectUnit" function





		----- Class Functions -----


			-----> LuaEntity (CBaseEntity) Functions <-----

				LuaEntity:GetOwner(): Returns the owner entity of the entity. 	

			-----> LuaEntityNPC (CDOTA_BaseNPC) Functions <-----

				LuaEntityNPC:Move(x[,y,z]): Selects the unit and gives a Move order then selects back the previous selection
					Possible Parameters:
						--(Vector)
						--(Number,Number,Number)

				LuaEntityNPC:AttackMove(x[,y,z]): Selects the unit and gives a AttackMove order then selects back the previous selection
					Possible Parameters:
						--(Vector)
						--(Number,Number,Number)

				LuaEntityNPC:Attack(unit): Selects the unit and gives a Attack order then selects back the previous selection

				LuaEntityNPC:Follow(unit): Selects the unit and gives a Follow order then selects back the previous selection

				LuaEntityNPC:Stop(): Selects the unit and gives a Stop order then selects back the previous selection

				LuaEntityNPC:FindSpell(spellName): If unit owns an ability with the given name, returns the ability.

				LuaEntityNPC:CastSpell(spellName[,x,y,z]): If units own an ability with the given name; selects unit, uses ability then selects back the previous selection
					Possible Parameters:
						--(String)
						--(String,Vector)
						--(String,LuaEntity)
						--(String,Number,Number,Number)

				LuaEntityNPC:SafeCastSpell(spellName[,x,y,z]): Same as CastSpell, but both spell and unit should be able to cast/be casted and it checks for Linkens Interaction if target is a unit.
					Possible Parameters:
						--(String)
						--(String,Vector)
						--(String,LuaEntity)
						--(String,Number,Number,Number)

				LuaEntityNPC:ToggleSpell(spellName): Same as CastSpell, but for toggle abilities

				LuaEntityNPC:SafeToggleSpell(spellName): Same as SafeCastSpell, but for toggle abilities

				LuaEntityNPC:FindItem(itemName): If unit owns an item with the given name, returns the item.

				LuaEntityNPC:SetPowerTreadsState(state): If unit owns a Power Treads; selects unit, sets its state then selects back the previous selection

				LuaEntityNPC:CastItem(itemName[,x,y,z]): If units own an item with the given name; selects unit, uses item then selects back the previous selection. If the item is Armlet of Mordiggian or Radiance then toggles it instad of using.
					Possible Parameters:
						--(String)
						--(String,Vector)
						--(String,LuaEntity)
						--(String,Number,Number,Number)
				
				LuaEntityNPC:SafeCastItem(itemName[,x,y,z]): Same as CastItem, but both item and unit should be able to cast/be casted and it checks for Linkens Interaction if target is a unit.
					Possible Parameters:
						--(String)
						--(String,Vector)
						--(String,LuaEntity)
						--(String,Number,Number,Number)
				
				LuaEntityNPC:CastAbility(ability[,x,y,z]): Selects unit, uses ability then selects back the previous selection
					Possible Parameters:
						--(CDOTABaseAbility)
						--(CDOTABaseAbility,Vector)
						--(CDOTABaseAbility,LuaEntity)
						--(CDOTABaseAbility,Number,Number,Number)
				
				LuaEntityNPC:SafeCastAbility(ability[,x,y,z]): Same as CastAbility, but both item and unit should be able to cast/be casted and it checks for Linkens Interaction if target is a unit.
					Possible Parameters:
						--(CDOTABaseAbility)
						--(CDOTABaseAbility,Vector)
						--(CDOTABaseAbility,LuaEntity)
						--(CDOTABaseAbility,Number,Number,Number)
				
				LuaEntityNPC:GetAllSpells(): Returns a table consisting of all of the spells unit owns.
				
				LuaEntityNPC:GetAllItems(): Returns a table consisting of all of the items unit owns.
				
				LuaEntityNPC:IsChanneling(): Returns "true" if unit is channeling a spell/item.
				
				LuaEntityNPC:GetChanneledAbility(): Returns the spell/item the unit channels if there is any.

				LuaEntityNPC:FindRelativeAngle(a): Returns the relative angle of the given unit or location. 0 means unit is facing -+PI means its behind the unit.
					Possible Parameters:
						--(Vector)
						--(Vector2D)
						--(LuaEntity)

				LuaEntityNPC:GetDistance2D(a): Returns the 2D (ignoring height) distance between the unit and given unit or location.
					Possible Parameters:
						--(Vector)
						--(Vector2D)
						--(LuaEntity)
				
				LuaEntityNPC:IsMagicDmgImmune(): Returns true if unit will not affected by from magical damage.
				
				LuaEntityNPC:IsPhysDmgImmune(): Returns true if unit will not affected by from physical damage.
				
				LuaEntityNPC:DoesHaveModifier(modifier): Returns true if unit has the given modifier.
				
				LuaEntityNPC:FindModifier(modifier): If unit has an modifier with the given name, returns the modifier.
				
				LuaEntityNPC:IsLinkensProtected(): Returns true if unit is being protected by Linken's Sphere

				LuaEntityNPC:AghanimState(): Returns if LuaEntity can use Aghanim's Scepter upgrades
				
				LuaEntityNPC:IsRanged(): Returns true if unit is ranged
				
				LuaEntityNPC:DamageTaken(damage,type,source): Returns the theoretical damage recieved from given parameters.
				
				LuaEntityNPC:ManaBurnDamageTaken(burnAmount,percent,type,source): Returns the theoretical damage recieved by a "ManaBurn" effect hero from given parameters.
				
				LuaEntityNPC:CanDie(): Returns true if unit can die.
				
				LuaEntityNPC:CanReincarnate(): Returns true if unit can reincarnate.
				
				LuaEntityNPC:IsInvul(): Returns true if unit is Invulnerable.
				
				LuaEntityNPC:IsUnitState(flag): Returns true if the unit has the specified flag in it's states
				
				LuaEntityNPC:CanMove(): Returns true if the unit can move.
				
				LuaEntityNPC:CanCast(): Returns true if the unit can cast spells.
				
				LuaEntityNPC:CanAttack(): Returns true if the unit can attack.
				
				LuaEntityNPC:CanUseItems(): Returns true if the unit can use items.
 


			-----> LuaEntityAbility  (CDOTABaseAbility) Functions<-----

				LuaEntityAbility :CanBeCasted(): Returns true if the ability can be casted.

				LuaEntityAbility :CanBeBlockedByLinkens(): Returns true if the ability can be blocked by Linken's Shere.

				LuaEntityAbility :IsBeingChanneled(): Returns true if the ability is currently being channeled.

				LuaEntityAbility:IsBehaviourType(flag): Returns true if the ability has the specified flag in it's Behaviour Type

				LuaEntityAbility:IsTargetType(flag): Returns true if the ability has the specified flag in it's Target Type

				LuaEntityAbility:IsTargetTeam(flag): Returns true if the ability has the specified flag in it's Target Team

				LuaEntityAbility:IsAbilityType(flag): Returns true if the ability has the specified flag in it's Ability Type

				LuaEntityAbility:IsDamageType(flag): Returns true if the ability has the specified flag in it's Damage Type

				LuaEntityAbility:GetSpecialData(name[,level]): Returns the special data with the given name if it exists

]]

--== DO NOT TOUCH BELOW ==--

DAMAGE_PHYS = 0 -- Physical
DAMAGE_MAGC = 1 -- Magic
DAMAGE_PURE = 2 -- Pure
DAMAGE_COMP = 3 -- Composite
DAMAGE_HPRM = 4 -- HP Removal
DAMAGE_UNIV = 5 -- Universal

LINKEN_MINOR_BLOCK = 0 -- Linkens block a minor part of the spell
LINKEN_MAJOR_BLOCK = 1 -- Linkens block a major part of the spell

PT_STR = 0 -- Strength
PT_INT = 1 -- Intelligence
PT_AGI = 2 -- Agility

--== GLOBALS ==--

utils = {}

utils.sleepDB = {}

utils.externalDmgReducs = {
	--Spectre: Dispersion
	{
		modifierName = "modifier_spectre_dispersion",
		type = 1,
		sourceTeam = 0,
		sourceSpellName = "spectre_dispersion",
		reduce = {.1,.14,.18,.22},
	},

	--Kunkka: Ghost Ship
	{
		modifierName = "modifier_kunkka_ghost_ship_damage_absorb",
		type = 1,
		reduce = .5,

	},

	--Templar Assasin: Refraction
	{
		modifierName = "modifier_templar_assassin_refraction_absorb",
		type = 1,
		reduce = 1,
	},

	--Abaddon: Borrowed Time
	{
		modifierName = "modifier_abaddon_borrowed_time",
		type = 1,
		reduce = 2,
	},

	--Treant Protector: Living Armor
	{
		modifierName = "modifier_treant_living_armor",
		type = 0,
		sourceTeam = 1,
		sourceSpellName = "treant_living_armor",
		reduce = {20,40,60,80},
	},

	--Abaddon: Aphotic Shield
	{
		modifierName = "modifier_abaddon_aphotic_shield",
		type = 0,
		sourceTeam = 1,
		sourceSpellName = "abaddon_aphotic_shield",
		reduce = {110,140,170,200},
	},

	--Ember Spirit: Flame Guard
	{
		modifierName = "modifier_ember_spirit_flame_guard",
		type = 0,
		sourceTeam = 0,
		sourceSpellName = "ember_spirit_flame_guard",
		reduce = {50,200,350,500},
		magicOnly = true,
	},
}

utils.externalDmgAmps = {
	--Shadow Demon: Soul Catcher
	{
		modifierName = "modifier_shadow_demon_soul_catcher",
		sourceTeam = -1,
		amp = {.2,.3,.4,.5},
		sourceSpellName = "shadow_demon_soul_catcher",
		type = DAMAGE_PURE,
	},

	--Chen: Penitence
	{
		modifierName = "modifier_chen_penitence",
		sourceTeam = -1,
		amp = {.08,.16,.24,.32},
		sourceSpellName = "chen_penitence",
		type = DAMAGE_PHYS,
	},

	--Slardar: Sprint
	{
		modifierName = "modifier_slardar_sprint",
		amp = .15,
		type = -1,
	},

	--Mask of Madness: Berserk
	{
		modifierName = "modifier_item_mask_of_madness_berserk",
		amp = .3,
		type = -1,
	},

	--Orchid Malevolence: Soul Burn
	{
		modifierName = "modifier_orchid_malevolence_debuff",
		amp = .3,
		type = DAMAGE_MAGC,
	},
}

utils.damageBlocks = {
	--Tidehunter: Kraken Shell
	{
		modifierName = "modifier_tidehunter_kraken_shell",
		meleeBlock = {7,14,21,28},
		rangedBlock = {7,14,21,28},
		abilityName = "tidehunter_kraken_shell",
	},

	--Poor Man's Shield: Damage Block
	{
		modifierName = "modifier_item_poor_mans_shield",
		meleeBlock = 20,
		rangedBlock = 10,
	},

	--Vanguard: Damage Block
	{
		modifierName = "modifier_item_vanguard",
		meleeBlock = 40,
		rangedBlock = 20,
	},

	--Stout Shield: Damage Block
	{
		modifierName = "modifier_item_stout_shield",
		meleeBlock = 20,
		rangedBlock = 10,
	},
}

--Table containing spellnames that are blocked by Linken's Sphere
utils.linkenBlocks = {
	--Alchemist: Unstable Concoction Throw
	alchemist_unstable_concoction_throw = true,
	--Ancient Appariton: Cold Feet
	ancient_apparition_cold_feet = true,
	--Anti-Mage: Mana Void
	antimage_mana_void = true,
	--Axe: Battle Hunger
	axe_battle_hunger = true,
	--Axe: Culling Blade
	axe_culling_blade = 0,
	--Bane: Enfeeble
	bane_enfeeble = true,
	--Bane: Brain Sap
	bane_brain_sap = true,
	--Bane: Nightmare
	bane_nightmare = true,
	--Bane: Fiend's Grip
	bane_fiends_grip = true,
	--Batrider: Flaming Lasso
	batrider_flaming_lasso = true,
	--Beastmaster: Primal Roar
	beastmaster_primal_roar = true,
	--Bloodseeker: Bloodrage
	bloodseeker_bloodrage = true,
	--Bloodseeker: Rupture
	bloodseeker_rupture = true,
	--Bounty Hunter: Shuriken Toss
	bounty_hunter_shuriken_toss = true,
	--Bounty Hunter: Track
	bounty_hunter_track = true,
	--Brewmaster: Drunken Haze
	brewmaster_drunken_haze = true,
	--Brewmaster: Earth: Hurl Boulder
	brewmaster_earth_hurl_boulder = true,
	--Brewmaster: Storm: Cyclone
	brewmaster_storm_cyclone = true,
	--Broodmother: Spawn Spiderlings
	broodmother_spawn_spiderlings = true,
	--Chaos Knight: Chaos Bolt
	chaos_knight_chaos_bolt = true,
	--Chaos Knight: Reality Rift
	chaos_knight_reality_rift = true,
	--Chen: Penitence
	chen_penitence = true,
	--Chen: Test of Faith
	chen_test_of_faith = true,
	--Crystal Maiden: Frostbite
	crystal_maiden_frostbite = true,
	--Dazzle: Poison Touch
	dazzle_poison_touch = true,
	--Distuptor: Thunder Strike
	disruptor_thunder_strike = true,
	--Distuptor: Glimpse
	disruptor_glimpse = true,
	--Doom: LVL? Death
	doom_bringer_lvl_death = true,
	--Doom: Doom
	doom_bringer_doom = true,
	--Dragon Knight: Dragon Tail
	dragon_knight_dragon_tail = true,
	--Earthshaker: Fissure
	earthshaker_fissure = true,
	--Enchantress: Enchant
	enchantress_enchant = true,
	--Enigma: Malefice
	enigma_malefice = true,
	--Gyrocopter: Homing Missile
	gyrocopter_homing_missile = true,
	--Huskar: Life Break
	huskar_life_break = true,
	--Invoker: Cold Snap
	invoker_cold_snap = true,
	--Juggernaut: Omnislash
	juggernaut_omni_slash = 0,
	--Keeper of the Light: Mana Leak
	keeper_of_the_light_mana_leak = true,
	--Keeper of the Light: Blinding Light
	keeper_of_the_light_blinding_light = 1;
	--Kunkka: X Marks the Spot
	kunkka_x_marks_the_spot = true,
	--Leshrac: Lightning Storm
	leshrac_lightning_storm = true,
	--Lich: Frost Nova
	lich_frost_nova = true,
	--Lich: Chain Frost
	lich_chain_frost = 0,
	--Lifestealer: Open Wounds
	life_stealer_open_wounds = true,
	--Lina: Laguna Blade
	lina_laguna_blade = true,
	--Lion: Earth Spike
	lion_impale = true,
	--Lion: Hex
	lion_voodoo = true,
	--Lion: Mana Drain
	lion_mana_drain = true,
	--Lion: Finger of Death
	lion_finger_of_death = true,
	--Luna: Lucent Beam
	luna_lucent_beam = true,
	--Morphling: Adaptive Strike
	morphling_adaptive_strike = true,
	--Morphling: Replicate
	morphling_morph_replicate = true,
	--Naga Siren: Ensnare
	naga_siren_ensnare = true,
	--Nature's Prophet: Sprout
	furion_sprout = true,
	--Nature's Prophet: Wrath of Nature
	furion_wrath_of_nature = true,
	--Necrolyte: Reaper's Scythe
	necrolyte_reapers_scythe = true,
	--Nightstalker: Void
	night_stalker_void = true,
	--Nightstalker: Crippling Fear
	night_stalker_crippling_fear = true,
	--Nyx Assassin: Impale
	nyx_assassin_impale = true,
	--Nyx Assassin: Mana Burn
	nyx_assassin_mana_burn = true,
	--Ogre Magi: Fireblast
	ogre_magi_fireblast = true,
	--Ogre Magi: Ignite
	ogre_magi_ignite = true,
	--Ogre Magi: Unrefined Fireblast
	ogre_magi_unrefined_fireblast = true,
	--Outworld Devourer: Astral Imprisonment
	obsidian_destroyer_astral_imprisonment = true,
	--Phantom Assassin: Stifling Dagger
	phantom_assassin_stifling_dagger = true,
	--Phantom Assassin: Phantom Strike
	phantom_assassin_phantom_strike = true,
	--Phantom Lancer: Spirit Lance
	phantom_lancer_spirit_lance = true,
	--Pugna: Decrepify
	pugna_decrepify = true,
	--Pugna: Nether Ward
	pugna_nether_ward = 0,
	--Pugna: Life Drain
	pugna_life_drain = true,
	--Queen of Pain: Shadow Strike
	queenofpain_shadow_strike = true,
	--Rubick: Telekinesis
	rubick_telekinesis = true,
	--Rubick: Fade Bolt
	rubick_fade_bolt = true,
	--Rubick: Spell Steal
	rubick_spell_steal = true,
	--Sand King: Burrowstrike
	sandking_burrowstrike = true,
	--Shadow Demon: Disruption
	shadow_demon_disruption = true,
	--Shadow Demon: Demonic Purge
	shadow_demon_demonic_purge = true,
	--Shadow Shaman: Hex
	shadow_shaman_voodoo = true,
	--Shadow Shaman: Shackles
	shadow_shaman_shackles = true,
	--Silencer: Last Word
	silencer_last_word = true,
	--Skeleton King: Hellfire Blast
	skeleton_king_hellfire_blast = true,
	--Skeleton King: Mortal Strike
	skeleton_king_mortal_strike = true,
	--Slardar: Amplify Damage
	slardar_amplify_damage = true,
	--Sniper: Assassinate
	sniper_assassinate = true,
	--Spirit Breaker: Charge of Darkness
	spirit_breaker_charge_of_darkness = true,
	--Spirit Breaker: Nether Strike
	spirit_breaker_nether_strike = true,
	--Storm Spirit: Electric Vortex
	storm_spirit_electric_vortex = true,
	--Sven: Storm Hammer
	sven_storm_bolt = true,
	--Tidehunter: Gush
	tidehunter_gush = true,
	--Tinker: Laser
	tinker_laser = true,
	--Treant Protector: Leech Seed
	treant_leech_seed = true,
	--Undying: Soul Rip
	undying_soul_rip = true,
	--Vengeful Spirit: Magic Missile
	vengefulspirit_magic_missile = true,
	--Vengeful Spirit: Nether Swap
	vengefulspirit_nether_swap = true,
	--Viper: Viper Strike
	viper_viper_strike = true,
	--Visage: Grave Chill
	visage_grave_chill = true,
	--Visage: Soul Assumption
	visage_soul_assumption = true,
	--Warlock: Fatal Bonds
	warlock_fatal_bonds = true,
	--Warlock: Shadow Word
	warlock_shadow_word = true,
	--Windrunner: Shackleshot
	windrunner_shackleshot = 1,
	--Windrunner: Focus Fire
	windrunner_focusfire = true,
	--Witch Doctor: Paralyzing Cask
	witch_doctor_paralyzing_cask = true,
	--Zeus: Arc Lightning
	zuus_lightning_bolt = true,
	--Zeus: Lightning Bolt
	zuus_arc_lightning = true,

	--Abyssal Blade
	item_abyssal_blade = true,
	--Dagon
	item_dagon = true,
	item_dagon_2 = true,
	item_dagon_3 = true,
	item_dagon_4 = true,
	item_dagon_5 = true,
	--Diffusal Blade
	item_diffusal_blade = true,
	item_diffusal_blade_2 = true,
	--Ethereal Blade
	item_ethereal_blade = true,
	--Eul's Scepter of Divinity
	item_cyclone = true,
	--Force Staff
	item_force_staff = true,
	--Heaven's Halberd
	item_heavens_halberd = true,
	--Necronomicon: Archer: Mana Burn
	necronomicon_archer_mana_burn = true,
	--Orchid Malevolence
	item_orchid = true,
	--Rod of Atos
	item_rod_of_atos = true,
	--Scythe of Vyse
	item_sheepstick = true,

	--Harpy Storm: Chain Lightning
	harpy_storm_chain_lightning = true,
	--Satyr Soulstealer: Mana Burn
	satyr_soulstealer_mana_burn = true,
	--Satyr Trickster: Purge
	satyr_trickster_purge = true,
}

utils.immunity = {}

--Modifiers that grant Physical Damage Immunity
utils.immunity.phys = {
	--Omniknight: Guardian Angel
	modifier_omninight_guardian_angel
	--Winter Wyvern: Cold Embrace
	-- PLACE HOLDER --
}


--Modifiers that grant Magical Damage Immunity
utils.immunity.magic = {
	--Medusa: Stone Gaze Petrify
	modifier_medusa_stone_gaze_stone = true,
}

--Modifiers that cause hero to be hidden
utils.hiddenModifiers = {
	--Brewmaster: Primal Split
	modifier_brewmaster_primal_split = true,
	modifier_brewmaster_primal_split_delay = true,
	--Juggernaut: Omnislash
	modifier_juggernaut_omnislash = true,
	--Puck: Phase Shift
	modifier_puck_phase_shift = true,
	--Lifestealer: Infest
	modifier_life_stealer_infest = true,
	--Phoenix: Supernova
	modifier_ember_spirit_sleight_of_fist_caster = true,
	--Ember Spirit: Sleight of Fist
	-- PLACE HOLDER --
	--Outworld Devourer: Astral Imprisonment
	modifier_obsidian_destroyer_astral_imprisonment_prison = true,
	--Shadow Demon: Disruption
	modifier_shadow_demon_disruption = true,
}

--Modifiers that cause hero to be invul
utils.invulModifiers = {
	--Generic Invulnerable
	modifier_invulnerable = true,
	--Brewmaster: Storm: Cyclone
	modifier_brewmaster_storm_cyclone = true,
	--Eul: Cyclone
	modifier_cyclone = true,
	--Invoker: Tornado
	modifier_invoker_tornado,
	--Bane: Nightmare
	modifier_bane_nightmare_invulnerable = true,
	--Faceless Void: Time Walk
	modifier_faceless_void_time_walk = true,
	--Storm Spirit: Ball Lightning
	modifier_storm_spirit_ball_lightning = true,
	--Morphling: Waveform
	modifier_morphling_waveform = true,
	--Tusk: Snowball
	modifier_tusk_snowball_movement = true,
	modifier_tusk_snowball_movement_friendly = true,
	--Naga Siren: Mirror Image
	modifier_naga_siren_mirror_image = true,
	--Chaos Knight: Phantasm
	modifier_chaos_knight_phantasm = true,
	--Manta Style: Mirror Image
	modifier_manta_phase = true,
}

--== GLOBAL FUNCTIONS ==--

function smartAssert(bool,string)
	if not bool then
    	print(debug.traceback())
    	assert(bool,string)
    end
end

--Returns the 2D distance (ignoring height) between 2 units.
--	Returns distance between unit and user's hero if only one unit is given.
function GetDistance2D(a,b)
    if type(a) == "table" then
    end
	smartAssert(GetType(a) == "LuaEntity" or GetType(a) == "Vector" or GetType(a) == "Vector2D" or GetType(a) == "Projectile", "GetDistance2D: Invalid First Parameter:"..GetType(a))
	smartAssert(GetType(b) == "LuaEntity" or GetType(b) == "Vector" or GetType(b) == "Vector2D" or GetType(a) == "Projectile" or GetType(b) == "nil", "GetDistance2D: Invalid Second Parameter:"..GetType(b))
	if not b then b = entityList:GetMyHero() end
	if a.x == nil or a.y == nil then
		return GetDistance2D(a.position,b)
	elseif b.x == nil or b.y == nil then
		return GetDistance2D(a,b.position)
	else
		return math.sqrt(math.pow(a.x-b.x,2)+math.pow(a.y-b.y,2))
	end
end

--Returns the base class of an obj
function GetType(obj)
	if obj and type(obj) == "userdata" then
		if type(obj.IsZero) == "function" then
			if type(obj.z) == "number" then
				return "Vector"
			else
				return "Vector2D"
			end
		elseif type(obj.SetPosition) == "function" then
			if type(obj.SetParameter) == "function" then
				return "LuaEffect"
			else
				return "DrawObject"
			end
		elseif type(obj.handle) == "number" or type(obj.selection) == "table" then
			return "LuaEntity"
		elseif type(obj.Unload) == "function" then
			return "script"
		elseif type(obj.IsLoaded) == "function" then
			return "scriptEngine"
		elseif type(obj.DrawText) == "function" then
			return "drawManager"
		elseif type(obj.FindEntities) == "function" then
			return "entityList"
		elseif type(obj.tall) == "number" then
			return "Font"
		elseif type(obj.dieTime) == "number" then
			return "Modifier"
		elseif type(obj.dataCount) == "number" then
			return "AbilitySpecial"
		elseif type(obj.speed) == "number" then
			return "Projectile"
		elseif type(obj.GetType) == "function" then
			return obj:GetType()
		else
			return type(obj)
		end
	else
		return type(obj)
	end
end

--Returns true if all of the keys are down
--	Give the negative of a key code to check if it is not pressed
--	Returns true if one of the key is down if the orCheck value is true
function IsKeysDown(key_table,orCheck)
	smartAssert(GetType(key_table) == "table", debug.getinfo(1, "n").name..": Invalid Key Table")
	if not orCheck then orCheck = false end
    for i,v in ipairs(key_table) do
    	local bool = nil
    	if v >= 0 then
    		bool = IsKeyDown(v)
    	else
			bool = not IsKeyDown(-v)
    	end
        if (not orCheck and not bool) or (orCheck and bool) then
                return bool
    	end
    end
    return not orCheck
end

	--Game State--

--Returns whether client is ingame.
function IsIngame()
	return client.connected and not client.loading
end

--Returns if user is playing the game.
function PlayingGame()
	return IsIngame() and entityList:GetMyHero() ~= nil --and not IsGamePaused()
end

    --Debug Engine--

--Sets debug state for IsDebugActive checks and DebugPrint.
function SetDebugState(state)
	smartAssert(type(state) == "boolean", debug.getinfo(1, "n").name..": Invalid State")
	utils.debugState = state
end

--Returns the debug state.
function IsDebugActive()
	return utils.debugState
end

--Prints a debug message in a format:
--	[SCRIPTNAME] YourMessage
function DebugPrint(text)
	smartAssert(type(tostring(text)) == "string", debug.getinfo(1, "n").name..": Invalid Text")
	if IsDebugActive() then
		print("["..script.name.."] "..tostring(text))
	end
end

   --Sleep Engine--

--Returns the sleeping status of the sleep engine with the given id (not entering id will return the state of the global sleep engine).
function SleepCheck(id)
	if id then
		return not utils.sleepDB[id] or GetTick() > utils.sleepDB[id]
	else
		return not utils.sleepTick or GetTick() > utils.sleepTick
	end
end

--Sleeps the sleeping engine with the given id for given ms (not entering id will sleep the global sleep engine).
--	If engine is already sleeping for more than the given time it will ignore it.
function Sleep(ms,id)
	if id then
		if not utils.sleepDB[id] or utils.sleepDB[id] < GetTick() + ms then
			utils.sleepDB[id] = GetTick() + ms
		end
	else
		if not utils.sleepTick or utils.sleepTick < GetTick() + ms then
			utils.sleepTick = GetTick() + ms
		end
	end
end

function LatSleepCheck(id)
	if id then
		return not utils.sleepDB[id] or GetTick() > utils.sleepDB[id] - client.latency
	else
		return not utils.sleepTick or GetTick() > utils.sleepTick - client.latency
	end
end

function LatSleep(ms,id)
	if id then
		if not utils.sleepDB[id] or utils.sleepDB[id] - client.latency < GetTick() + ms then
			utils.sleepDB[id] = GetTick() + ms + client.latency
		end
	else
		if not utils.sleepTick or utils.sleepTick - client.latency < GetTick() + ms then
			utils.sleepTick = GetTick() + ms + client.latency
		end
	end
end

    --Selection Engine--

--Selects given unit if it is not the only unit selected, returns the previous selected unit as a table for the "SelectBack" function.
function SelectUnit(unit)
	if not unit then
		unit = entityList:GetMyHero()
	end
	smartAssert(GetType(unit) == "LuaEntity", debug.getinfo(1, "n").name..": Invalid Unit")
	local _prevSelect = {}
	local selection = entityList:GetMyPlayer().selection
	if selection and selection[1] and selection[1].handle ~= unit.handle or #selection ~= 1 then
		_prevSelect = selection
		entityList:GetMyPlayer():Select(unit)
	end
	return _prevSelect
end

--Selects given table of units if there is any. Primary source for the table should be the "SelectUnit" function.
function SelectBack(units)
	smartAssert(type(units) == "table", debug.getinfo(1, "n").name..": Invalid Unit Table")
	if #units > 0 then
		for i,v in ipairs(units) do
			if v.alive and v.visible then
				if i == 1 then
					entityList:GetMyPlayer():Select(v)
				else
					entityList:GetMyPlayer():SelectAdd(v)
				end
			end
		end
	end
end

--== LuaEntityNPC (CDOTA_BaseNPC) FUNCTIONS ==--

--Selects LuaEntity, Gives a Move command and Selects back the previous selection.
function LuaEntityNPC:Move(x,y,z)
	smartAssert(x, debug.getinfo(1, "n").name..": Invalid Parameters")
	if x ~= nil and y ~= nil and z ~= nil then
		smartAssert(type(x) == "number" and type(y) == "number" and type(z) == "number", debug.getinfo(1, "n").name..": Invalid Coordinates")
		local prev = SelectUnit(self)
		entityList:GetMyPlayer():Move(Vector(x,y,z))
		SelectBack(prev)
	elseif x ~= nil then
		smartAssert(GetType(x) == "Vector", debug.getinfo(1, "n").name..": Invalid Vector")
		local prev = SelectUnit(self)
		entityList:GetMyPlayer():Move(x)
		SelectBack(prev)
	end
end

--Selects LuaEntity, Gives an AttackMove command it and Selects back the previous selection.
function LuaEntityNPC:AttackMove(x,y,z)
	if x and y and z then
		smartAssert(type(x) == "number" and type(y) == "number" and type(z) == "number", debug.getinfo(1, "n").name..": Invalid Coordinates")
		local prev = SelectUnit(self)
		entityList:GetMyPlayer():AttackMove(Vector(x,y,z))
		SelectBack(prev)
	elseif x then
		smartAssert(GetType(x) == "Vector", debug.getinfo(1, "n").name..": Invalid Vector")
		local prev = SelectUnit(self)
		entityList:GetMyPlayer():AttackMove(x)
		SelectBack(prev)
	end
end

--Selects LuaEntity, Gives an Attack command it and Selects back the previous selection.
function LuaEntityNPC:Attack(unit)
	smartAssert(GetType(unit) == "LuaEntity", debug.getinfo(1, "n").name..": Invalid Unit")
	local prev = SelectUnit(self)
	entityList:GetMyPlayer():Attack(unit)
	SelectBack(prev)
end

--Selects LuaEntity, Gives an Follow command it and Selects back the previous selection.
function LuaEntityNPC:Follow(unit)
	smartAssert(GetType(unit) == "LuaEntity", debug.getinfo(1, "n").name..": Invalid Unit")
	local prev = SelectUnit(self)
	entityList:GetMyPlayer():Follow(unit)
	SelectBack(prev)
end

--Selects LuaEntity, Gives an Stop command it and Selects back the previous selection.
function LuaEntityNPC:Stop()
	local prev = SelectUnit(self)
	entityList:GetMyPlayer():Stop()
	SelectBack(prev)
end


--Searchs the LuaEntity's spells for a spell with given name and returns it if there is any.
function LuaEntityNPC:FindSpell(spellName)
	smartAssert(type(spellName) == "string", debug and debug.getinfo(1, "n") and debug.getinfo(1, "n").name and debug.getinfo(1, "n").name..": Invalid Spell Name")
	local i = 1
	for i,spell in ipairs(self.abilities) do
		if spell and spell.name == spellName then
			return spell
		end
	end
end


--Finds the spell with given name; If there is one selects LuaEntity, casts it and selects back the previous selection.
--	Returns true if cast order is given.
function LuaEntityNPC:CastSpell(spellName,x,y,z)
	smartAssert(type(spellName) == "string", debug.getinfo(1, "n").name..": Invalid Spell Name")
	local spell = self:FindSpell(spellName)
	if spell then
		local prev = SelectUnit(self)
		if not x and not y and not z then
			entityList:GetMyPlayer():UseAbility(spell)
		elseif not y and not z then
			smartAssert(GetType(x) == "Vector" or GetType(x) == "LuaEntity", debug.getinfo(1, "n").name..": Invalid parameters")
			entityList:GetMyPlayer():UseAbility(spell,x)
		else
			smartAssert(type(x) == "number" and type(y) == "number" and type(z) == "number", debug.getinfo(1, "n").name..": Invalid Coordinates")
			entityList:GetMyPlayer():UseAbility(spell,x,y,z)
		end
		SelectBack(prev)
		return true
	end
end

--Finds the spell with given name; If there is one selects LuaEntity, toggles it and selects back the previous selection.
--	Returns true if toggle order is given.
function LuaEntityNPC:ToggleSpell(spellName)
	smartAssert(type(spellName) == "string", debug.getinfo(1, "n").name..": Invalid Spell Name")
	local spell = self:FindSpell(spellName)
	if spell then
		local prev = SelectUnit(self)
		entityList:GetMyPlayer():ToggleAbility(spell)
		SelectBack(prev)
		return true
	end
end

--Finds the spell with given name; If there is one selects LuaEntity, casts it and selects back the previous selection.
--	Checks both hero's state and spells state to cast successfully
--	Returns true if cast order is "successfully" given.
function LuaEntityNPC:SafeCastSpell(spellName,x,y,z)
	smartAssert(type(spellName) == "string", debug.getinfo(1, "n").name..": Invalid Spell Name")
	local spell = self:FindSpell(spellName)
	if spell and spell:CanBeCasted() and self:CanCast() and not (x and x.IsLinkensProtected and x:IsLinkensProtected() and spell:CanBeBlockedByLinkens() == true) then
		local prev = SelectUnit(self)
		if not x and not y and not z then
			entityList:GetMyPlayer():UseAbility(spell)
		elseif not y and not z then
			smartAssert(GetType(x) == "Vector" or GetType(x) == "LuaEntity", debug.getinfo(1, "n").name..": Invalid parameters")
			entityList:GetMyPlayer():UseAbility(spell,x)
		else
			smartAssert(type(x) == "number" and type(y) == "number" and type(z) == "number", debug.getinfo(1, "n").name..": Invalid Coordinates")
			entityList:GetMyPlayer():UseAbility(spell,x,y,z)
		end
		SelectBack(prev)
		return true
	end
end

--Finds the spell with given name; If there is one selects LuaEntity, toggles it and selects back the previous selection.
--	Checks both hero's state and spells state to cast successfully
--	Returns true if toggle order is "successfully" given.
function LuaEntityNPC:SafeToggleSpell(spellName)
	smartAssert(type(spellName) == "string", debug.getinfo(1, "n").name..": Invalid Spell Name")
	local spell = self:FindSpell(spellName)
	if spell and spell:CanBeCasted() and self:CanCast() then
		local prev = SelectUnit(self)
		entityList:GetMyPlayer():ToggleAbility(spell)
		SelectBack(prev)
		return true
	end
end

--Searchs the LuaEntity's inventory for an item with given name and returns it if there is any.
function LuaEntityNPC:FindItem(itemName)
	smartAssert(type(itemName) == "string", debug and debug.getinfo(1, "n") and debug.getinfo(1, "n").name and debug.getinfo(1, "n").name..": Invalid Item Name")
	local i = 1
	for i,item in ipairs(self.items) do
		if item and item.name == itemName then
			return item
		end
	end
end

--Sets the LuaEntity's power treads (if there is) to given state
--	Look to the globals for possible states
function LuaEntityNPC:SetPowerTreadsState(state,queue)
	smartAssert(state == PT_AGI or state == PT_STR or state == PT_INT, debug.getinfo(1, "n").name..": Invalid State")
	local pt = self:FindItem("item_power_treads")
	if pt then
		local prev = SelectUnit(self)
		for i = 1, (state - pt.bootsState) % 3 do
			if queue then
				QueueNextAction()
			end
			entityList:GetMyPlayer():UseAbility(pt)
		end
		SelectBack(prev)
	end
end

--Finds the spell with given name; If there is one selects LuaEntity, casts it and selects back the previous selection.
--	If the item is a toggle item then toggles it.
--	Returns true if cast order is given.
function LuaEntityNPC:CastItem(itemName,x,y,z)
	smartAssert(type(itemName) == "string", debug.getinfo(1, "n").name..": Invalid Item Name")
	local item = self:FindItem(itemName)
	if item then
		local prev = SelectUnit(self)
		if item:IsBehaviourType(LuaEntityAbility.BEHAVIOR_TOGGLE) then
			entityList:GetMyPlayer():ToggleAbility(item)
		elseif not x and not y and not z then
			entityList:GetMyPlayer():UseAbility(item)
		elseif not y and not z then
			smartAssert(GetType(x) == "Vector" or GetType(x) == "LuaEntity", debug.getinfo(1, "n").name..": Invalid parameters")
			entityList:GetMyPlayer():UseAbility(item,x)
		else
			smartAssert(type(x) == "number" and type(y) == "number" and type(z) == "number", debug.getinfo(1, "n").name..": Invalid Coordinates")
			entityList:GetMyPlayer():UseAbility(item,x,y,z)
		end
		SelectBack(prev)
		return true
	end
end

--Finds the spell with given name; If there is one selects LuaEntity, casts it and selects back the previous selection.
--	If the item is a toggle item then toggles it.
--	Checks both hero's state and item state to cast successfully
--	Returns true if cast order is "successfully" given.
function LuaEntityNPC:SafeCastItem(itemName,x,y,z)
	smartAssert(type(itemName) == "string", debug.getinfo(1, "n").name..": Invalid Item Name")
	local item = self:FindItem(itemName)
	if item and item:CanBeCasted() and self:CanUseItems() and not (x and x.IsLinkensProtected and x:IsLinkensProtected() and spell:CanBeBlockedByLinkens() == true) then
		local prev = SelectUnit(self)
		if  item:IsBehaviourType(LuaEntityAbility.BEHAVIOR_TOGGLE) then
			entityList:GetMyPlayer():ToggleAbility(item)
		elseif not x and not y and not z then
			entityList:GetMyPlayer():UseAbility(item)
		elseif not y and not z then
			smartAssert(GetType(x) == "Vector" or GetType(x) == "LuaEntity", debug.getinfo(1, "n").name..": Invalid parameters")
			entityList:GetMyPlayer():UseAbility(item,x)
		else
			smartAssert(type(x) == "number" and type(y) == "number" and type(z) == "number", debug.getinfo(1, "n").name..": Invalid Coordinates")
			entityList:GetMyPlayer():UseAbility(item,x,y,z)
		end
		SelectBack(prev)
		return true
	end
end

function LuaEntityNPC:FindAbility(abilityName)
	smartAssert(type(abilityName) == "string")
	for i,v in ipairs(self.items) do
		if v.name == abilityName then
			return v
		end
	end
	for i,v in ipairs(self.abilities) do
		if v.name == abilityName then
			return v
		end
	end
	return nil
end

--Selects LuaEntity, casts ability and selects back the previous selection.
--	Returns true if cast order is given.
function LuaEntityNPC:CastAbility(ability,x,y,z)
	smartAssert(GetType(ability) == "LuaEntity", debug.getinfo(1, "n").name..": Invalid Ability")
	if ability then
		local prev = SelectUnit(self)
		if not x and not y and not z then
			entityList:GetMyPlayer():UseAbility(ability)
		elseif not y and not z then
			smartAssert(GetType(x) == "Vector" or GetType(x) == "LuaEntity", debug.getinfo(1, "n").name..": Invalid parameters")
			entityList:GetMyPlayer():UseAbility(ability,x)
		else
			smartAssert(type(x) == "number" and type(y) == "number" and type(z) == "number", debug.getinfo(1, "n").name..": Invalid Coordinates")
			entityList:GetMyPlayer():UseAbility(ability,x,y,z)
		end
		SelectBack(prev)
		return true
	end
end


--Selects LuaEntity, casts ability and selects back the previous selection.
--	Returns true if cast order is given.
--	Checks both hero's state and item state to cast successfully
function LuaEntityNPC:SafeCastAbility(ability,x,y,z)
	smartAssert(GetType(ability) == "LuaEntity", debug.getinfo(1, "n").name..": Invalid Ability")
	if ability and ability:CanBeCasted() and ((ability.item and self:CanUseItems()) or (not ability.item and self:CanCast())) and not (x and x.IsLinkensProtected and x:IsLinkensProtected() and ability:CanBeBlockedByLinkens() == true) then
		local prev = SelectUnit(self)
		if not x and not y and not z then
			entityList:GetMyPlayer():UseAbility(ability)
		elseif not y and not z then
			smartAssert(GetType(x) == "Vector" or GetType(x) == "LuaEntity", debug.getinfo(1, "n").name..": Invalid parameters")
			entityList:GetMyPlayer():UseAbility(ability,x)
		else
			smartAssert(type(x) == "number" and type(y) == "number" and type(z) == "number", debug.getinfo(1, "n").name..": Invalid Coordinates")
			entityList:GetMyPlayer():UseAbility(ability,x,y,z)
		end
		SelectBack(prev)
		return true
	end
end

--Returns if LuaEntity is currently channeling an ability.
function LuaEntityNPC:IsChanneling()
	for i,v in ipairs(self.items) do
		if v:IsBeingChanneled() then
			return true
		end
	end
	for i,v in ipairs(self.abilities) do
		if v:IsBeingChanneled() then
			return true
		end
	end
	return false
end

--Returns the LuaEntity of the spell if LuaEntity is currently channeling an ability.
function LuaEntityNPC:GetChanneledAbility()
	local items = self:GetAllItems()
	local spells = self:GetAllSpells()
	for i,v in ipairs(self.items) do
		if v:IsBeingChanneled() then
			return v
		end
	end
	for i,v in ipairs(self.abilities) do
		if v:IsBeingChanneled() then
			return v
		end
	end
end

--Returns the distance between LuaEntity and the given unit/position.
function LuaEntityNPC:GetDistance2D(a)
	smartAssert(GetType(a) == "Vector" or GetType(a) == "LuaEntity" or GetType(a) == "Vector2D" or GetType(a) == "Projectile", "GetDistance2D: Invalid Parameter (Got "..GetType(a)..")")
	if a.x == nil or a.y == nil then
		return self:GetDistance2D(a.position)
	else
		return math.sqrt(math.pow(a.x-self.position.x,2)+math.pow(a.y-self.position.y,2))
	end
end

--Returns if LuaEntity is immune to Magic damage.
function LuaEntityNPC:IsMagicDmgImmune()
	if self:IsMagicImmune() then
		return true
	else
		for i,v in ipairs(utils.immunity.magic) do
			if self:DoesHaveModifier(v) then
				return true
			end
		end
	end
	return false
end

--Returns if LuaEntity is immune to Physical damage.
function LuaEntityNPC:IsPhysDmgImmune()
	if self.ghost then
		return true
	else
		for i,v in ipairs(utils.immunity.phys) do
			if self:DoesHaveModifier(v) then
				return true
			end
		end
	end
	return false
end

--Returns whether LuaEntity has the particular modifier.
function LuaEntityNPC:DoesHaveModifier(name)
	return self:FindModifier(name) ~= nil
end

--Returns the modifier if LuaEntity has the particular modifier.
function LuaEntityNPC:FindModifier(name)
	smartAssert(type(name) == "string", debug.getinfo(1, "n").name..": Invalid Modifier Name")
	if self.modifiers then
		for i,v in ipairs(self.modifiers) do
			if v.name == name then
				return v
			end
		end
	end
	return nil
end

--Returns if LuaEntity is protected by Linken's Sphere
function LuaEntityNPC:IsLinkensProtected()
	local linken = self:FindItem("item_sphere")
	return linken and linken.cd == 0
end

--Returns if LuaEntity can use Aghanim's Scepter upgrades
function LuaEntityNPC:AghanimState()
	return self:FindItem("item_ultimate_scepter") or self.stolenScepter
end

--Returns if LuaEntity is ranged
function LuaEntityNPC:IsRanged()
	return self.attackType == LuaEntityNPC.ATTACK_RANGED and self.name ~= "Tiny"
end

--Returns if LuaEntity can die from the next instance of Damage
function LuaEntityNPC:CanDie()
	if self:CanReincarnate() then
		return false
	end
	if self:DoesHaveModifier("modifier_dazzle_shallow_grave") then
		return false
	end
	return true
end

--Returns if LuaEntity can reincarnate after dying.
function LuaEntityNPC:CanReincarnate()
	local aegis = self:FindItem("item_aegis")
	if aegis then
		return true
	end
	local reincarnation = self:FindSpell("skeleton_king_reincarnation")
	if reincarnation then
		return true
	end
	return false
end

--Returns damage LuaEntity takes from a manaburn attack
function LuaEntityNPC:ManaBurnDamageTaken(burnAmount,percent,dmgType,source)
	smartAssert(type(burnAmount) == "number", debug.getinfo(1, "n").name..": Invalid Burned Mana")
	smartAssert(GetType(source) == "LuaEntity", debug.getinfo(1, "n").name..": Invalid Source")
	smartAssert(dmgType == 0 or dmgType == 1 or dmgType == 2 or dmgType == 3 or dmgType == 4 or dmgType == 5, debug.getinfo(1, "n").name..": Invalid Damage Type")
	smartAssert(type(percent) == "number", debug.getinfo(1, "n").name..": Invalid Damage Percent")
	local tempBurn =  burnAmount
	if self.mana < tempBurn then tempBurn = self.mana end
	return self:DamageTaken(tempBurn*percent,dmgType,source)
end

--Returns the damage LuaEntity takes
function LuaEntityNPC:DamageTaken(dmg,dmgType,source)
	smartAssert(type(dmg) == "number", ": Invalid Damage")
	smartAssert(dmgType == 0 or dmgType == 1 or dmgType == 2 or dmgType == 3 or dmgType == 4 or dmgType == 5, ": Invalid Damage Type")
	smartAssert(GetType(source) == "LuaEntity", debug.getinfo(1, "n").name..": Invalid Source")
	local tempDmg = dmg

	--Physical Damage Calculation
	if dmgType == DAMAGE_PHYS then
		--Check if target gets physical damage
		if self:IsPhysDmgImmune() or self:IsInvul() then
			tempDmg = 0
		else
			--Check damage blocks before armor
			for i,v in ipairs(utils.damageBlocks) do
				if self:DoesHaveModifier(v.modifierName) then
					local block
					--Find block amount
					if self:IsRanged() then
						block = v.rangedBlock
					else
						block = v.meleeBlock
					end
					--If block amount is constant
					if type(block) == "number" then
						tempDmg = tempDmg - block
					--Else locate block amount from level
					else
						temmpDmg = tempDmg - block[self:FindSpell(v.abilityName).level]
					end
					break
				end
			end

			--Armor Calculation
			tempDmg = tempDmg*(1 - self.dmgResist)
		end

	--Magical Damage Calculation
	elseif dmgType == DAMAGE_MAGC then
		--Check if target gets magical damage
		if self:IsMagicDmgImmune() or self:IsInvul() then
			tempDmg = 0
		else
			--Magic resistance calculation
			tempDmg = tempDmg*(1 - self.magicDmgResist)
		end

	--Pure Damage Calculation
	elseif dmgType == DAMAGE_PURE then
		--Check if target gets pure damage
		if self:IsMagicImmune() or self:IsInvul() then
			tempDmg = 0
		end

	--Composite Damage Calculation
	elseif dmgType == DAMAGE_COMP then
		--Check if target gets composite damage
		if self:IsPhysDmgImmune() or self:IsInvul() then
			tempDmg = 0
		else
			--Check damage blocks before armor and magic resistance
			for i,v in ipairs(utils.damageBlocks) do
				if self:DoesHaveModifier(v.modifierName) then
					local block
					--Find block amount
					if self:IsRanged() then
						block = v.rangedBlock
					else
						block = v.meleeBlock
					end
					--If block amount is constant
					if type(block) == "number" then
						tempDmg = tempDmg - block
					--Else locate block amount from level
					else
						temmpDmg = tempDmg - block[self:FindSpell(v.abilityName).level]
					end
					break
				end
			end
			--Armor and magic resistance calculation
			tempDmg = tempDmg*(1 - self.dmgResist)*(1 - self.magicDmgResist)
		end

	--Universal Damage Calculation
	elseif dmgType == DAMAGE_UNIV then
		--Check if target gets universal damage
		if (self:IsMagicDmgImmune() and not self:IsMagicImmune()) or self:IsInvul() then
			tempDmg = 0
		else
			--Magic resistance calculation
			tempDmg = tempDmg*(1 - self.magicDmgResist)
		end
	end

	--External Amplification and Reduction Calculation
	--	HP removal cannot be reduced or amplified
	if dmgType ~= DAMAGE_HPRM then

		--External Amplify
		for i,v in ipairs(utils.externalDmgAmps) do
			--Does have modifer to calculate amplification
			if self:DoesHaveModifier(v.modifierName) then
				local amp = v.amp
				--If amplification is level dependent
				if type(amp) == "table" then
					--Only sources are enemies but failsafe
					if v.sourceTeam == -1 then
						--Find enemy that has the spell
						for k,l in pairs(entityList:FindEntities({type = TYPE_HERO})) do
							if not l.illusion and l.team ~= self.team then
								local spell = l:FindSpell(v.sourceSpellName)
								if spell then
									--Calculate amplification
									amp = amp[spell.level]
									--Break the loop, no further code is processed for enemy finding
									break
								end
							end
						end
					end
				end
				--If amplification damage is same as source damage
				if v.type == -1 then
					--Since original damage is reduced amplfied damage is auto reduced
					tempDmg = tempDmg * (1 + amp)
				--If amplification damage is pure
				elseif v.type == DAMAGE_PURE then
					--Check if target takes pure damage
					if not self.magicImmune and not self:IsInvul() then
						tempDmg = tempDmg * (1 + amp)
					end
				--If aplification damage is phyiscal
				elseif v.type == DAMAGE_PHYS then
					local tempAmp = tempDmg * amp
					--Check if target takes physical damage
					if not self:IsPhysDmgImmune() and not self:IsInvul() then
						--Check for damage blocks
						for i,v in ipairs(utils.damageBlocks) do
							if self:DoesHaveModifier(v.modifierName) then
								local block
								--Find if target is ranged
								if self:IsRanged() then
									block = v.rangedBlock
								else
									block = v.meleeBlock
								end
								--If block is constant
								if type(block) == "number" then
									tempAmp = tempAmp - block
								--Else locate block from level
								else
									tempAmp = tempAmp - block[self:FindSpell(v.abilityName).level]
								end
								break
							end
						end
						--Add damage with armor reduced to tempDmg
						tempDmg = tempDmg + tempAmp* (1 - self.dmgResist)
					end
				--If amplification damage is magic
				elseif v.type == DAMAGE_MAGC then
					--Check if target takes magical damage
					if not self:IsMagicDmgImmune() and not self:IsInvul() then
						tempDmg = tempDmg + tempDmg * amp * (1 - self.magicDmgResist)
					end
				end
			end
		end

		--Exception External Amplify: Undying: Flesh Golem: Plauge
		--	Amplification is dynamic, related to distance to the flesh golem
		if self:DoesHaveModifier("modifier_undying_flesh_golem_plague_aura") then
			--Find flesh golem
			for k,l in pairs(entityList:FindEntities({type = TYPE_HERO})) do
				if not l.illusion and l.team ~= self.team then
					local spell = l:FindSpell("undying_flesh_golem")
					--If flesh golem is found do the calculation related to distance
					if spell then
						local baseAmp = .05 * spell.level
						if l:FindItem("item_ultimate_scepter") then
							baseAmp = baseAmp + .05
						end
						local distance = self:GetDistance2D(l)
						if distance <= 200 then
							amp = baseAmp + 0.15
						elseif distance > 750 then
							amp = baseAmp
						else
							amp = baseAmp + (750 - distance)*0.03/110
						end
						tempDmg = tempDmg * (1 + amp)
						--Break the loop save time, two enemy flesh golems are unlikely
						break
					end
				end
			end
		end

		--External Reduction
		for i,v in ipairs(utils.externalDmgReducs) do
			--Does have modifier to calculate reduction
			if self:DoesHaveModifier(v.modifierName) then
				local reduce = v.reduce
				--If reduce type is percent
				if v.type == 1 then
					--If reduce is not a number find the reduction from the spell level
					--	If reduce is a number all is good
					if type(reduce) == "table" then
						--If source is allied hero
						if v.sourceTeam == 1 then
							--Find spell and locate reduce from spell level
							for k,l in pairs(entityList:FindEntities({type = TYPE_HERO, team = self.team})) do
								if not l.illusion then
									local spell = l:FindSpell(v.sourceSpellName)
									if spell then
										reduce = reduce[spell.level]
										break
									end
								end
							end
							--If reduce is still a table (meaning no spell matching the modifier found) set reduction as 0
							if type(reduce) == "table" then
								reduce = 0
							end
						--If source is self
						elseif v.sourceTeam == 0 then
							local spell = self:FindSpell(v.sourceSpellName)
							--If self does have spell find the reduction
							if spell then
								reduce = reduce[spell.level]
							--Else set reduce as 0
							else
								reduce = 0
							end
						end
					end
					tempDmg = tempDmg * (1 - reduce)
				--If reduce type is static (fixed amount) then check if tempDmg is positive
				--	so dont waste time by calculating reducing negative damage
				elseif tempDmg > 0 then
					--Check if damage type is magical OR block accepts non-magical damage reduction
					if not v.magicOnly or dmgType == DAMAGE_MAGC then
						--If reduce is not a number find the reduction from the spell level
						--	If reduce is a number all is good
						if type(reduce) == "table" then
							--If source is allied hero
							if v.sourceTeam == 1 then
								--Find spell and locate reduce from spell level
								for k,l in pairs(entityList:FindEntities({type = TYPE_HERO, team = self.team})) do
									if not l.illusion then
										local spell = l:FindSpell(v.sourceSpellName)
										if spell then
											reduce = reduce[spell.level]
											break
										end
									end
								end
								--If reduce is still a table (meaning no spell matching the modifier found) set reduction as 0
								if type(reduce) == "table" then
									reduce = 0
								end
							--If source is self
							elseif v.sourceTeam == 0 then
								local spell = self:FindSpell(v.sourceSpellName)
								--If self does have spell find the reduction
								if spell then
									reduce = reduce[spell.level]
								--Else set reduce as 0
								else
									reduce = 0
								end
							end
						end
						tempDmg = tempDmg - reduce
					end
				end
			end
		end

		--Exception External Reduction: Bristleback: Bristleback
		--	Reduction is dynamic, depends on whether bristleback is turning his back to source or not
		if self:DoesHaveModifier("modifier_bristleback_bristleback") then
			local spell = self:FindSpell("bristleback_bristleback")
			--If has spell
			if spell then
				--Calculate angle stuff
				local reduce = 0
				local angle = ((self:FindRelativeAngle(source.position)) % (2 * math.pi)) * 180 / math.pi
				if angle >= 110 and angle <= 250 then
					reduce = (1 + spell.level) * 0.08
					elseif angle >= 70 and angle <= 290 then
					reduce = (1 + spell.level) * 0.04
				end
				tempDmg = tempDmg * (1 - reduce)
			end
		end
	end
	return tempDmg
end

--Returns if LuaEntity is Invulnerable
--[[function LuaEntityNPC:IsInvul()
	if self.modifierCount then
		for i=1,self.modifierCount do
			if utils.invulModifiers[self:GetModifierName(i)] or utils.hiddenModifiers[self:GetModifierName(i)] then
				return true
			end
		end
	end
	return false
end]]

function LuaEntityNPC:FindRelativeAngle(pos)
	smartAssert(GetType(pos) == "Vector" or GetType(pos) == "LuaEntity" or GetType(pos) == "Vector2D" or GetType(pos) == "Projectile", debug.getinfo(1, "n").name..": Invalid Parameter")
	if not pos.x then pos = pos.position end
	return ((math.atan2(pos.y-self.position.y,pos.x-self.position.x) - self.rotR + math.pi) % (2 * math.pi)) - math.pi
end

--Returns the particular flag at the LuaEntity's unitState.
function LuaEntityNPC:IsUnitState(flag)
	smartAssert(type(flag) == "number", "IsTargetTeam: Invalid Flag")
	return HasFlag(self.unitState,flag)
end

function LuaEntityNPC:IsRooted()
	return self:IsUnitState(LuaEntityNPC.STATE_ROOTED)
end

function LuaEntityNPC:IsDisarmed()
	return self:IsUnitState(LuaEntityNPC.STATE_SOFT_DISARMED) or self:IsUnitState(LuaEntityNPC.STATE_DISARMED)
end

function LuaEntityNPC:IsAttackImmune()
	return self:IsUnitState(LuaEntityNPC.STATE_ATTACK_IMMUNE)
end

function LuaEntityNPC:IsSilenced()
	return self:IsUnitState(LuaEntityNPC.STATE_SILENCED)
end

function LuaEntityNPC:IsMuted()
	return self:IsUnitState(LuaEntityNPC.STATE_MUTED)
end

function LuaEntityNPC:IsStunned()
	return self:IsUnitState(LuaEntityNPC.STATE_STUNNED)
end

function LuaEntityNPC:IsHexed()
	return self:IsUnitState(LuaEntityNPC.STATE_HEXED)
end

function LuaEntityNPC:IsInvisible()
	return self:IsUnitState(LuaEntityNPC.STATE_INVISIBLE)
end

function LuaEntityNPC:IsInvul()
	return self:IsUnitState(LuaEntityNPC.STATE_INVULNERABLE)
end

function LuaEntityNPC:IsMagicImmune()
	return self:IsUnitState(LuaEntityNPC.STATE_MAGIC_IMMUNE)
end

function LuaEntityNPC:IsFlying()
	return self:IsUnitState(LuaEntityNPC.STATE_FLYING)
end

function LuaEntityNPC:IsUnitWalking()
	return self:IsUnitState(LuaEntityNPC.STATE_NO_COLLISION)
end

--Returns if LuaEntity can move.
function LuaEntityNPC:CanMove()
	return not self:IsRooted() and not self:IsStunned() and self.alive
end

--Returns if LuaEntity can cast spells.
function LuaEntityNPC:CanCast()
	return not self:IsSilenced() and not self:IsStunned() and self.alive and not self.illusion
end

--Returns if LuaEntity can attack.
function LuaEntityNPC:CanAttack()
	return not self.attackType == LuaEntityNPC.ATTACK_NONE and not self:IsDisarmed() and not self:IsStunned() and self.alive
end

--Returns if LuaEntity can use items.
function LuaEntityNPC:CanUseItems()
	return not self:IsSilenced() and not self:IsStunned() and self.alive and not self.illusion
end
--== LuaEntityAbility (CDOTABaseAbility) FUNCTIONS ==--

--Returns if LuaEntity can be casted.
function LuaEntityAbility:CanBeCasted()
	return self.state == LuaEntityAbility.STATE_READY
end

--Returns if LuaEntity can be blocked by Linken's Sphere.
--	Possible outcomes are: true, false, LINKEN_MAJOR_BLOCK, and LINKEN_MINOR_BLOCK
function LuaEntityAbility:CanBeBlockedByLinkens()
	return utils.linkenBlocks[self.name]
end

--Returns if LuaEntity is being channeled.
function LuaEntityAbility:IsBeingChanneled()
	return self.channelTime ~= 0
end

--Returns true if the ability has the specified flag in it's Behaviour Type
function LuaEntityAbility:IsBehaviourType(flag)
	smartAssert(type(flag) == "number", "IsBehaviourType: Invalid Flag")
	return HasFlag(self.castType,flag)
end

--Returns true if the ability has the specified flag in it's Target Type
function LuaEntityAbility:IsTargetType(flag)
	smartAssert(type(flag) == "number", "IsTargetType: Invalid Flag")
	return HasFlag(self.targetType,flag)
end

--Returns true if the ability has the specified flag in it's Target Team
function LuaEntityAbility:IsTargetTeam(flag)
	smartAssert(type(flag) == "number", "IsTargetTeam: Invalid Flag")
	return HasFlag(self.targetTeamType,flag)
end

--Returns true if the ability has the specified flag in it's Ability Type
function LuaEntityAbility:IsAbilityType(flag)
	smartAssert(type(flag) == "number", "IsAbilityType: Invalid Flag")
	return HasFlag(self.abilityType ,flag)
end

--Returns true if the ability has the specified flag in it's Damage Type
function LuaEntityAbility:IsDamageType(flag)
	smartAssert(type(flag) == "number", "IsDamageType: Invalid Flag")
	return HasFlag(self.damageType,flag)
end

--Returns the special data with the given name if it exists
--	If data has multiple possibilites then it gets the one with the revelant level
function LuaEntityAbility:GetSpecialData(name,level)
	smartAssert(type(name) == "string", "GetSpecialData: Invalid Name")
	if not level then level = self.level end
	if self.specialCount then
		for i=1,self.specialCount do
			if self:GetSpecial(i).name == name then
				if self:GetSpecial(i).dataCount == 1 then
					return self:GetSpecial(i):GetData(1)
				else
					return self:GetSpecial(i):GetData(level)
				end
			end
		end
	end
	return nil
end

--Returns true if the ability has the specified flag in it's Damage Type
function LuaEntityAbility:FindCastPoint()
	if self.overrideCastPoint == -1 then
		return self:GetCastPoint(self.level)
	else
		return 0.1
	end
end

	--Code to apply all functions to the old LuaEntities.--

utils.entityFuncs = {
	{"Move",					"LuaEntityNPC"},
	{"AttackMove",				"LuaEntityNPC"},
	{"Attack",					"LuaEntityNPC"},
	{"Follow",					"LuaEntityNPC"},
	{"Stop",					"LuaEntityNPC"},
	{"FindSpell",				"LuaEntityNPC"},
	{"CastSpell",				"LuaEntityNPC"},
	{"SafeCastSpell",			"LuaEntityNPC"},
	{"ToggleSpell",				"LuaEntityNPC"},
	{"SafeToggleSpell",			"LuaEntityNPC"},
	{"FindAbility",				"LuaEntityNPC"},
	{"CastAbility",				"LuaEntityNPC"},
	{"SafeCastAbility",			"LuaEntityNPC"},
	{"FindItem",				"LuaEntityNPC"},
	{"SetPowerTreadsState",		"LuaEntityNPC"},
	{"CastItem",				"LuaEntityNPC"},
	{"SafeCastItem",			"LuaEntityNPC"},
	{"IsChanneling",			"LuaEntityNPC"},
	{"GetChanneledAbility",		"LuaEntityNPC"},
	{"GetDistance2D",			"LuaEntityNPC"},
	{"IsMagicDmgImmune",		"LuaEntityNPC"},
	{"IsPhysDmgImmune",			"LuaEntityNPC"},
	{"DoesHaveModifier",		"LuaEntityNPC"},
	{"FindModifier",			"LuaEntityNPC"},
	{"IsLinkensProtected",		"LuaEntityNPC"},
	{"IsRanged",				"LuaEntityNPC"},
	{"CanDie",					"LuaEntityNPC"},
	{"CanReincarnate",			"LuaEntityNPC"},
	{"DamageTaken",				"LuaEntityNPC"},
	{"ManaBurnDamageTaken",		"LuaEntityNPC"},
	{"IsRooted",				"LuaEntityNPC"},
	{"IsDisarmed",				"LuaEntityNPC"},
	{"IsAttackImmune",			"LuaEntityNPC"},
	{"IsSilenced",				"LuaEntityNPC"},
	{"IsMuted",					"LuaEntityNPC"},
	{"IsStunned",				"LuaEntityNPC"},
	{"IsHexed",					"LuaEntityNPC"},
	{"IsInvisible",				"LuaEntityNPC"},
	{"IsInvul",					"LuaEntityNPC"},
	{"IsMagicImmune",			"LuaEntityNPC"},
	{"IsFlying",				"LuaEntityNPC"},
	{"IsUnitWalking",			"LuaEntityNPC"},
	{"FindRelativeAngle",		"LuaEntityNPC"},
	{"IsUnitState",				"LuaEntityNPC"},
	{"CanMove",					"LuaEntityNPC"},
	{"CanCast",					"LuaEntityNPC"},
	{"CanAttack",				"LuaEntityNPC"},
	{"CanUseItems",				"LuaEntityNPC"},
	{"CanBeCasted",				"LuaEntityAbility"},
	{"CanBeBlockedByLinkens",	"LuaEntityAbility"},
	{"IsBeingChanneled",		"LuaEntityAbility"},
	{"IsBehaviourType",			"LuaEntityAbility"},
	{"IsTargetType",			"LuaEntityAbility"},
	{"IsTargetTeam",			"LuaEntityAbility"},
	{"IsAbilityType",			"LuaEntityAbility"},
	{"IsDamageType",			"LuaEntityAbility"},
	{"GetSpecialData",			"LuaEntityAbility"},
	{"FindCastPoint",			"LuaEntityAbility"},
}

utils.entityClassInheritance = {
	LuaEntity  = {"LuaEntityNPC", "LuaEntityAbility"},
	LuaEntityNPC  = {"LuaEntityHero", "LuaEntityCreep", "LuaEntityCourier"},
	LuaEntityAbility  = {"LuaEntityItem"},
	LuaEntityItem  = {"LuaEntityBottle", "LuaEntityPowerTreads"},
	LuaEntityHero  = {"LuaEntityHeroMeepo"},
}

function InheritFunction(className,functionName)
	local inheritanceTable = utils.entityClassInheritance[className]
	if inheritanceTable then
		for _,v in ipairs(inheritanceTable) do
			_G[v][functionName] = _G[className][functionName]
			InheritFunction(v,functionName)
		end
	end
end

for _,funcTable in ipairs(utils.entityFuncs) do
	InheritFunction(funcTable[2],funcTable[1])
end
