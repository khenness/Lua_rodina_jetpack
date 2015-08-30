--Copyright Elliptic Games LLC.
-------------------------------------------------------------------------------
EGMakeClass( "EGActor", "EGWorldObject" )
EGMakeClass( "EGPlayer", "EGActor" )

EGActor.PHYSICS_DISABLED	= EGEnum( "EG_PHYSICS_DISABLED" )
EGActor.PHYSICS_PASSIVE		= EGEnum( "EG_PHYSICS_PASSIVE" )
EGActor.PHYSICS_DRIVEN		= EGEnum( "EG_PHYSICS_DRIVEN" )
EGActor.EntityType			= "Actor"

EGActor.HEALTH_REFRESH_RATE			= 1
EGActor.HEALTH_REFRESH_RATE_DANGER	= .5
EGActor.FIRE_DAMAGE					= 50
EGActor.FIRE_DAMAGE_STRENGTH_MAX	= 1
EGActor.JETPACK_FUEL_RESTORE_RATE	= 0.01 --2
EGActor.JETPACK_FUEL_USE_RATE		= 2
EGActor.JETPACK_FUEL_MAX			= 200
EGActor.EXO_SUIT_EQUIPPED           = false




EGPlayer.EntityType			= "CharacterActor"
EGPlayer.CameraOffset = EGVector(0,.1,1.65)

EGPlayer.CharacterPhysics = 
{
	
	Height = 1.8,
	Radius = 0.3,
	
	Mass = 70,
	MaxForce = 1000,
	MaxSlope = 90,
	Friction = 0.4,	
	Restitution = 0.0,
	MaxLinearVelocity = 10000,
	
	JumpHeight = 3,
	GroundHugging = true,
	DisableHorizontalProjection = true,
	
	WalkSpeed = 7.5,
	GroundSpeed = 20,
	GoundAccelertation = 200,
	TempGravity = -250,
	GroundGain = 0.95,
	
	AirSpeed = 35,
	AirAcceleration = 10,
	TempAirGravity = -25,
	AirGain = .01,
	
	JetpackSpeed = 40*16,
	JetpackGainLow = 0.5,
	JetpackGainHigh = 1.0,
	--I'd like to have something like this, but later:
	--JetpackGainForward
	--JetpackGainBackward
	
	--[[
	GroundSpeed = 200,
	GoundAccelertation = 3000,
	AirSpeed = 1000,
	AirAcceleration = 3000,
	TempAirGravity = -7500,
	AirGain = .01,
	MaxLinearVelocity = 100000,
	--]]		
	InsidePhysics = 
	{
		MaxForce = 1000,
		MaxSlope = 70,
		
		JumpHeight = 3,
		GroundHugging = false,
		
		WalkSpeed = 2.5,
		GroundSpeed = 5,
		GroundGain = 0.95,
		TempGravity = -25,
		
		AirSpeed = 5,
		TempAirGravity = -25,
	},
}
--[[
EGPlayer.CharacterPhysics = 
{
	Height = 1.8,
	Radius = 0.3,
	Mass = 90,
	MaxForce = 1000,
	MaxSlope = 70,
	Friction = .25,
	
	GroundSpeed = 6,
	GroundHugging = false,
	DisableHorizontalProjection = true,
	AirSpeed = 5,
	JumpHeight = 3,
	MaxLinearVelocity = 1000,
	
	TempGravity = -25,
	TempAirGravity = -25,
	GroundGain = 0.95,
	AirGain = .01,
}
--]]

--Super fast legs
--[[
EGPlayer.CharacterPhysics = 
{
	Height = 1.8,
	Radius = 0.3,
	Mass = 70,
	MaxForce = 1000,
	MaxSlope = 90,
	Friction = 0.0,
	
	GroundSpeed = 35,
	GroundHugging = false,
	GoundAccelertation = 200,
	DisableHorizontalProjection = false,
	AirSpeed = 1500,
	AirAcceleration = 200,
	JumpHeight = 100,
	MaxLinearVelocity = 10000,
	
	TempGravity = -250,
	TempAirGravity = -150,
	GroundGain = 0.95,
	AirGain = 0.95,
	
	Restitution = 0.0,
}
--]]

--[[
EGPlayer.CharacterPhysics = 
{
	Height = 1.8,
	Radius = 0.3,
	Mass = 70,
	MaxForce = 1000,
	MaxSlope = 90,
	Friction = 0.4,
	
	GroundSpeed = 15,
	GroundHugging = true,
	GoundAccelertation = 200,
	DisableHorizontalProjection = true,
	AirSpeed = 35,
	AirAcceleration = 10,
	JumpHeight = 100,
	MaxLinearVelocity = 10000,
	
	TempGravity = -50,
	TempAirGravity = -5,
	GroundGain = 0.95,
	AirGain = .01,
	
	Restitution = 0.0,
}
--]]

-------------------------------------------------------------------------------
function EGPlayer:Init( aCInfo )
	self.MaxHealth = 100
	self.Health = self.MaxHealth
	self.DamageTimer = 0
	self.HeldType = nil
	self.EquippedType = nil
	self.Running = true
	
	self.CurrentBehavior = nil
	self.AITimer = 0
end

-------------------------------------------------------------------------------
function EGPlayer:OnAddedToScene()
	
	EGWorldObject.OnAddedToScene( self )
end

-------------------------------------------------------------------------------
function EGPlayer:UpdateAI( aDeltaTime )
	
	if( not self:IsDead() ) then
		---[[
		self:ChooseBehavior()
		self:UpdateClosestVehicle()
		
		if( not self.CurrentBehavior ) then
			self:ChooseBehavior()
		end
		
		---[=[
		--EGError("Test: ".. (self.CurrentBehavior and self.CurrentBehavior.Name or "none" ) )
		if( self.CurrentBehavior )	then
			self.CurrentBehavior:Update( aDeltaTime )
			if( self.CurrentBehavior:IsFinished() ) then
				self.CurrentBehavior:Exit()
				self.CurrentBehavior = nil
			end			
		end
		--]=]
	end
end

-------------------------------------------------------------------------------
function EGPlayer:ChooseBehavior()
	
	local behavior = nil
	local nextInfo = nil
	
	if( self.GetBehaviorFunc ) then	
		nextInfo = self.GetBehaviorFunc( self )
	end
	
	if( nextInfo ) then
		if( not nextInfo.Name ) then
			error( self.Name.."'s GetBehaviorFunc() returned info with no name" )
		end
		
		behavior = self.Behaviors[nextInfo.Name]
	
		if( not behavior ) then
			error( "No behavior named "..nextInfo.Name.." can be found in actor "..self.Name )
		end
	end
	
	if( behavior ~= self.CurrentBehavior ) then
		self:EnterBehavior( behavior, nextInfo )			
	end
end

-------------------------------------------------------------------------------
function EGPlayer:EnterBehavior( aBehavior, aNextInfo )
	if( self.CurrentBehavior ) then
		self.CurrentBehavior:Exit()
	end
	
	self.CurrentBehavior = aBehavior
	
	if( self.CurrentBehavior ) then
		self.CurrentBehavior:Enter( aNextInfo )
	end
end

-------------------------------------------------------------------------------
function EGPlayer:Update( aDeltaTime )
 	DebugText("EXO-SUIT Enabled", tostring(EGActor.EXO_SUIT_EQUIPPED))
	self.Engine:SetPhysicsType( EGActor.PHYSICS_DRIVEN )
	
	if( self.Health <= 0 ) then
		self.Engine:SetMovementVelocity( EGVector() )
		return
	end
	
	self.AITimer = self.AITimer + aDeltaTime
	if( highProcess or aFullUpdate ) then
		self:UpdateAI( self.AITimer )
		self.AITimer = 0
	end
	
	if( System.GetPlayerCameraActor() == self ) then
		self:SetLookAtInfo()
	end	
		
	self:UpdateControls( aDeltaTime )	
	self:RestoreHealth( aDeltaTime )
	self:RestoreJetpack( aDeltaTime )
	self:UpdateFireDamage( aDeltaTime )
	self:UpdateEffectModules( aDeltaTime )
	self:UpdateDecompression( aDeltaTime )
	
	--[[
	if( self ~= gGame:GetPlayer() ) then
		self.Engine:SetMovementVelocity( EGVector( 0, .2, 0 ) )		

		local toShipForward = self:GetLocalVectorTo( gGame:GetPlayer() )
		local rotate = EGGetYawPitchForDirection( toShipForward )
		
		local arrivalDist = 0.1
		local arrivalX = EGAnalogue( math.abs(rotate.x), arrivalDist, 0, 1, 0 )
		local arrivalY = EGAnalogue( math.abs(rotate.y), arrivalDist, 0, 1, 0 )
		local arrivalZ = EGAnalogue( math.abs(rotate.z), arrivalDist, 0, 1, 0 )
		rotate:Multiply( arrivalX, arrivalY, arrivalZ )
		rotate:Multiply( 1.5 )
		self.Engine:SetRotationVelocity( rotate )
	end
	--]]
	
	--[[
	local currentPlanet = self:GetCurrentPlanet()
	local localPos = currentPlanet:GetLocalVectorTo( self )
	local geoCoord = currentPlanet:GetLocalToGeo( localPos )
	local local2 = currentPlanet:GetGeoToLocal( geoCoord )
	local surfaceDistance = self.Engine:GetPlanetDistance()
	
	DebugText( "Player-X", tostring(localPos.x) )
	DebugText( "Player-Y", tostring(localPos.y) )
	DebugText( "Player-Z", tostring(localPos.z) )
	DebugText( "Player-Latitude", tostring(geoCoord.Latitude) )
	DebugText( "Player-Longitude", tostring(geoCoord.Longitude) )
	DebugText( "Player-Altitude", tostring(geoCoord.Altitude) )	
	DebugText( "surfaceDistance: ", tostring(surfaceDistance) )
	--]]
	
	--Wind Test
	--local inertia = self.Engine:GetLocalVelocity()
	--System.GetCameraEntity():AttachParticles( "VelesWind", "VelesWind", 1.0, EGVector(), inertia )
end

-------------------------------------------------------------------------------
function EGPlayer:UpdateFacingShipForward( aVehicle, aDeltaTime )

	-- This function only works in 1st person, because it uses the camera direction to move the player
	if( System.GetPlayerCameraActor() == self ) then
		local cameraEntity = System.GetCameraEntity()
		local toShipForward = cameraEntity:GetLocalVectorTo( aVehicle, EGVector( 0, 10000, 1000 ) )
		local rotate = EGGetYawPitchForDirection( toShipForward )
		
		local arrivalDist = 0.1
		local arrivalX = EGAnalogue( math.abs(rotate.x), arrivalDist, 0, 1, 0 )
		local arrivalY = EGAnalogue( math.abs(rotate.y), arrivalDist, 0, 1, 0 )
		local arrivalZ = EGAnalogue( math.abs(rotate.z), arrivalDist, 0, 1, 0 )
		rotate:Multiply( arrivalX, arrivalY, arrivalZ )
		rotate:Multiply( 4 )
		self.Engine:SetRotationVelocity( rotate )
	else
		self.Engine:SetRotationVelocity( EGVector() )		
	end
end

-------------------------------------------------------------------------------
function EGPlayer:UpdateDecompression( aDeltaTime )
	--DebugText( "Current Room", room and room.Engine:GetID() or 0 )
	--DebugText( "Current Room Pressure", room and room:GetAirPressure() or 0 )
	--local pos = interior and interior:GetLocalVectorTo( self ) or EGVector()
	--DebugText( "Interior Pos", pos.x.." - "..pos.y.." - "..pos.z )
	
	local room = self.Engine:GetCurrentRoom()
	local interior = self.Engine:GetCurrentInterior()
	
	if( room  ) then
		local pushForce = room:GetAirDecompressionForce( self )
		
		local pushMagnitude = pushForce:Length()
		local windSound = EGAnalogue( pushMagnitude, 0, 200, 0, 1 )
		System.Audio.PlaySound( "RoomAirDepressurize", windSound, self.Engine )
		System.Audio.SetSoundPitch( "RoomAirDepressurize", 1.5 )
		
		--DebugText( "Room Push Force", pushForce:Length() )
		
		if( self.Engine:GetCharacterPhysicsContext() == "IN AIR" and movementMode ~= "JETPACK" ) then
			pushForce:Multiply( .01 )
		end
		if( interior and interior:GetAllDoorsOpen() ) then
			self.Engine:AddLocalAcceleration( pushForce )
		end
	end
end

-------------------------------------------------------------------------------
function EGPlayer:UpdateControls( aDeltaTime )
	
	local controls = System.GetCurrentScene().Control	
	local vehicle = self.Engine:GetCurrentInteriorVehicle()
	local pilotingVehicle = System.GetPlayerCameraActor() == self and System.GetPlayerControlActor() == vehicle
		
	local controlLook = System.GetPlayerControlActor() == self
	local controlMove = System.GetPlayerControlActor() == self
	
	if( pilotingVehicle ) then
		if( controls:GetAction( "FREE_LOOK" ) > 0  ) then
			controlLook = true
		end
	end
		
	if( controlLook ) then
		local lookAngleVelocity = controls:GetCompoundAction( "LOOK_CHARACTER" )
		local lookSpeed = EGGetOption( "CharacterLookSpeed" )
		if( self.Engine:GetMovementMode() == "JETPACK" ) then
			lookSpeed = lookSpeed * 1.5
			lookAngleVelocity.z = lookAngleVelocity.z * .5
		else
			lookSpeed = lookSpeed * 3.0
		end	
		lookAngleVelocity:Multiply( lookSpeed )
		self.Engine:SetRotationVelocity( lookAngleVelocity )
		
	else
		self:UpdateFacingShipForward( vehicle, aDeltaTime )
	end
	
	if( controlMove ) then
		local movementVelocity = controls:GetCompoundAction( "MOVE" )

		if( self.Engine:IsPhysicsDisabled() ) then
			local currentPlanet = self:GetCurrentPlanet()
			local speed = 5
			--[[
			if controls:GetAction( "RUN" ) > 0 then
				speed = 10000000
			end
			--]]
			---[[	
			if( currentPlanet ) then
				if controls:GetAction( "RUN" ) > 0 then
					local planetDistance = self:GetLocalVectorTo( currentPlanet ):Length()
						
					local cruiseRadius = currentPlanet.Radius
					if( planetDistance - cruiseRadius > 0 ) then
						speed = 1000000 * math.min( 1000, ( planetDistance / cruiseRadius ) ^ 2.3 )
					end
				end
			end
			--]]
			movementVelocity:Multiply( speed )
		end

		local movementMode = self.Engine:GetMovementMode()
		if( movementMode == "JETPACK" ) then
			local jetpackFuelName = "JetpackFuel"
			local jetFuel = gGame:GetPlayerInfo():GetInventoryCount( jetpackFuelName )
		
			local movement = EGClamp( movementVelocity:Length(), 0, 1 )				
			if( movement > 0 and jetFuel > 0 ) then
				System.Audio.PlaySound( "FireExtinguisher", movement, self.Engine )			
				if( not EGGodMode ) then
					local fuelUsage = self.JETPACK_FUEL_USE_RATE * movement * aDeltaTime
					gGame:GetPlayerInfo():AddInventoryItem( jetpackFuelName, -fuelUsage )
				end
			else
				movementVelocity = EGVector()
			end
		end
		
		--movementVelocity:Multiply( .3 )
		
		self.Engine:SetMovementVelocity( movementVelocity )
		
		if controls:GetAction( "JUMP" ) > 0 then
			self.Engine:SetWantsJump( true )
		end
		
		if controls:GetAction( "MOVE_DOWN" ) > 0 then
			self.Engine:SetWantsCrouch( true )
		end
		
		if( controls:GetAction( "TOGGLE_RUN" ) > 0 ) then
			self.Running = not self.Running
			self.Engine:SetRunning( self.Running )
		end
		
		if( controls:GetAction( "RUN" ) > 0 )then
			self.Engine:SetRunning( not self.Running )
		else
			self.Engine:SetRunning( self.Running )			
		end
		
		DebugText( "Running", self.Running )
		
		self:UpdateLight()
		self:UpdateHeldItem()
		
		local lookingAt = self.Engine:GetLookAtScriptEntity()
		if( lookingAt and controls:GetAction( "ACTIVATE" ) > 0 and lookingAt.OnGrab ) then
			lookingAt:OnGrab( self )
		end
	else
		self.Engine:SetMovementVelocity( EGVector() )	
	end
end

-------------------------------------------------------------------------------
function EGPlayer:SetLookAtInfo()
	local lookingAt = self.Engine:GetLookAtScriptEntity()
	local info1 = nil
	local info2 = nil
	if( lookingAt ) then
		if( lookingAt.ShowInfo ) then
			info1 = lookingAt.DisplayName or lookingAt.Name
			info2 = lookingAt.Info
		end
	end

	if( HUD ) then
		HUD:SetPlayerHealth( self:GetHealthPercent() )
		HUD:SetLookInfo( info1 )
		HUD:SetLookInfo2( info2 )
	end
end

-------------------------------------------------------------------------------
function EGPlayer:RestoreHealth( aDeltaTime )
	self.DamageTimer = self.DamageTimer - aDeltaTime
	
	if( self.DamageTimer <= 0 ) then
		if( System.GetCurrentScene().InCombatTimer <= 0 and self.Health > 0 ) then
			self.Health = math.min( self.Health + aDeltaTime * self.HEALTH_REFRESH_RATE, self.MaxHealth )
		else
			self.Health = math.min( self.Health + aDeltaTime * self.HEALTH_REFRESH_RATE_DANGER, self.MaxHealth )
		end
	end
end
-------------------------------------------------------------------------------
function EGPlayer:RestoreJetpack( aDeltaTime )

	local movementMode = self.Engine:GetMovementMode()
	local planet = self:GetCurrentPlanet()
	local planetPressure = planet:GetAirPressure( self )	
	local room = self.Engine:GetCurrentRoom()
	local currentPressure = room and room:GetAirPressure() or planetPressure

	local jetFuel = gGame:GetPlayerInfo():GetInventoryCount( "JetpackFuel" )
	
	if( movementMode ~= "JETPACK" and jetFuel < self.JETPACK_FUEL_MAX ) then
		local fuelRate = currentPressure * self.JETPACK_FUEL_RESTORE_RATE * aDeltaTime
		jetFuel = EGClamp( jetFuel + fuelRate, 0, self.JETPACK_FUEL_MAX )
		gGame:GetPlayerInfo():SetInventoryCount( "JetpackFuel", jetFuel )
	end	
end


-------------------------------------------------------------------------------
function EGPlayer:UpdateFireDamage( aDeltaTime )
	local interior = self.Engine:GetCurrentInterior()
	if( interior ) then
		local fireStrength = interior:GetFireSurrounding( self )
		if( fireStrength > 0.5 ) then
			fireStrength = math.min( fireStrength, self.FIRE_DAMAGE_STRENGTH_MAX )
			self:DamageHealth( fireStrength * aDeltaTime * self.FIRE_DAMAGE )
			
			local shake = fireStrength * .025
			self:SetCameraVibrate( "FIRE PAIN SHAKE", EGVector( shake, shake, 0 ), EGVector( 45, 32, 0 ), 0, 1 )
		end
		--DebugText( "Fire Damage", fireStrength )
	end
end

-------------------------------------------------------------------------------
function EGPlayer:GetHealthPercent()
	local health = math.max( 0, math.min( self.Health, self.MaxHealth ) )
	return health / self.MaxHealth
end

-------------------------------------------------------------------------------
function EGPlayer:HealHealth( aAmount )
	local health = self.Health + aAmount
	self.Health = math.min( self.MaxHealth, health )
end

-------------------------------------------------------------------------------
function EGPlayer:DamageHealth( aAmount, aIgnoreDifficulty )

	local isPlayer = self == gGame:GetPlayer()

	if( EGGodMode and isPlayer ) then
		aAmount = 0
	end
	
	if( isPlayer and not aIgnoreDifficulty ) then
		local difficulty = EGGetOption( "CombatDifficulty" ) or 1
		local damageMult = EGAnalogue( difficulty, 0, 1, .25, 1 )
		aAmount = aAmount * damageMult
	end
	
	self.DamageTimer = 1
	
	self.Health = math.min( self.MaxHealth, self.Health )
	self.Health = self.Health - aAmount
	
	-- HACK: Need to immediately tell hud about health so that the red pain tile goes up
	-- before the death message. This is because tile depth doesn't work, and when you
	-- crash the ship while in character mode the pain tile can overlap the death message.
	-- take this out once tile depth is fixed.
	if( HUD ) then
		HUD:SetPlayerHealth( self:GetHealthPercent() )
	end
end

-------------------------------------------------------------------------------
function EGPlayer:Kill()
	self:DamageHealth( self.Health, true )
end

-------------------------------------------------------------------------------
function EGPlayer:UpdateLight( aTurnOff )
	if( gGame:GetControls():GetAction( "TOGGLE_LIGHT" ) > 0 ) then
		
		System.Audio.PlaySound( "ActivateLight", 1 )
		
		local light = self:GetChildEntity( "PlayerLight" )
		if( light ) then
			--if( HUD ) then HUD:AddNotification( "Flashlight Off" ) end
			light:MarkForDestruction()
		elseif( not aTurnOff ) then
			--if( HUD ) then HUD:AddNotification( "Flashlight On" ) end
			local lightObject = Items.PlayerLight:New()
			lightObject.Position		= EGVector(0,0,0)
			lightObject.ParentEntity	= self.Engine
			lightObject.ParentSubpart	= "Player Camera"
			System.GetCurrentScene():Add( lightObject )
		end
	end
end


-------------------------------------------------------------------------------
function EGPlayer:GetUsingLight()
	local light = self:GetChildEntity( "PlayerLight" )
	return light ~= nil
end

local ITEM_HAND_LOCATION = EGVector(.2,.5,-.15)
-------------------------------------------------------------------------------
function EGPlayer:UpdateHeldItem( aSwitch )

	-- Always try to create the held item, because it will fail if we don't have a camera
	-- and we will need to try again as soon as we do have a camera!
	self:CreateHeldItemEntity()
	
	if( gGame:GetControls():GetAction( "SWITCH WEAPON" ) > 0 ) then
		if( self.HeldType ) then
			self:CancelHeldItem()
		else
			self:SetHeldItem( self.EquippedType )
		end
	end	
	
	if( self.EquippedType and gGame:GetControls():GetAction( "CANCEL" ) > 0 ) then
		self:Unequip( self.EquippedType )
	end
	
	local ammo = self:GetHeldAmmoCount()
	if( ammo and ammo <= 0 ) then
		self:Unequip( self.EquippedType )
	end
	
	if HUD then HUD:SetWeaponType( self.HeldType ) end
end

-------------------------------------------------------------------------------
function EGPlayer:SetHeldItem( aType )
	if( type( aType ) == "string" ) then
		aType = EGGetClass( aType )
	end	

	if( self.EquippedType ~= aType or self.HeldType ~= aType ) then
		self:Unequip( self.EquippedType )
	
		--DebugText( "SetHeldItem", aType )	
		self.HeldType		= aType
		self.EquippedType	= aType
		
		self:CreateHeldItemEntity()
	end
end

-------------------------------------------------------------------------------
function EGPlayer:CreateHeldItemEntity()

	if( self.HeldType ) then
		local cameraEntity = self:GetChildEntity( "Player Camera" )
		if( cameraEntity ) then
			local itemEntity = self:GetHeldItem()
			if( not itemEntity ) then
				local item 				= self.HeldType:New()
				item.Position			= ITEM_HAND_LOCATION
				item.ParentEntity		= self.Engine
				item.ParentSubpart		= "Player Camera"
				System.GetCurrentScene():Add( item )
			end
		end
	end
end

-------------------------------------------------------------------------------
function EGPlayer:GetHeldItem()
	local item = self.HeldType and self:GetChildEntity( self.HeldType.Name )
	return item
end

-------------------------------------------------------------------------------
function EGPlayer:GetHeldAmmoCount()
	local ammo = self.HeldType and gGame:GetPlayerInfo():GetInventoryCount( self.HeldType.FullName )
	return ammo
end

-------------------------------------------------------------------------------
function EGPlayer:CancelHeldItem()
	local item = self:GetHeldItem()
	if( item ) then
		item:MarkForDestruction()
	end
	self.HeldType = nil
end

-------------------------------------------------------------------------------
function EGPlayer:Unequip( aType )
	self:CancelHeldItem()
	self.EquippedType = nil
end

-------------------------------------------------------------------------------
function EGPlayer:CreateCamera()
	return EGCamera:New()
end

-------------------------------------------------------------------------------
function EGPlayer:Save( aStream )

	-- Version 5
	local heldName		= self.HeldType and self.HeldType.FullName or ""
	local equippedName	= self.EquippedType and self.EquippedType.FullName or ""	
	aStream:WriteString( heldName )
	aStream:WriteString( equippedName )
	
	-- Version 7
	aStream:WriteNumber( self.Health )
	
	-- Version 17
	aStream:Write( self.Running )
end

-------------------------------------------------------------------------------
function EGPlayer:Load( aStream )
	if( aStream:GetVersion() >= 5 ) then
		self.SaveHeldName		= aStream:ReadString()
		self.SaveEquippedName	= aStream:ReadString()
	end
	
	self.Health = self.MaxHealth
	if( aStream:GetVersion() >= 7 ) then
		self.Health		= aStream:ReadNumber()
	end
	
	self.Running = true
	if( aStream:GetVersion() >= 17 ) then
		self.Running	= aStream:Read()
	end
end

-------------------------------------------------------------------------------
function EGPlayer:LoadFinalize()
	if( self.SaveHeldName and self.SaveEquippedName ) then
		if( self.SaveHeldName ~= "" ) then
			self:SetHeldItem( self.SaveHeldName )
		else
			self.EquippedType = EGGetClass( self.SaveEquippedName )
		end
	end
	
	self.Engine:SetRunning( self.Running )
end