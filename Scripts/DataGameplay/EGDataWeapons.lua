--Copyright Elliptic Games LLC.
-------------------------------------------------------------------------------
EGMakeClass( "EGWeaponBlaster", "EGWeaponBullet" )

EGWeaponBlaster.Path				= "Projectile.Pulse.egm"
EGWeaponBlaster.DisplayName			= "Standard Blaster"
EGWeaponBlaster.NumProjectiles		= 1
EGWeaponBlaster.Speed				= 10000
EGWeaponBlaster.Lifetime			= 2
EGWeaponBlaster.Damage				= 2
EGWeaponBlaster.Physics				= { Radius = 20 }
EGWeaponBlaster.SpreadX				= 0.08
EGWeaponBlaster.SpreadY				= 0.08
EGWeaponBlaster.CooldownTime		= 0.025
EGWeaponBlaster.FlareParticlesName	= "GunFlare"
EGWeaponBlaster.SoundName			= "Blaster"
EGWeaponBlaster.ImpactParticles		= "BlasterImpact"
--EGWeaponBlaster.ImpactParticles		= "RingBlasterImpact"


EGMakeClass( "EGScoutBlaster", "EGWeaponBlaster" )
EGScoutBlaster.Damage				= 2


------------------------------------
--start Kevins version

EGMakeClass( "EGWeaponJetpack", "EGWeaponBullet" )
EGWeaponJetpack.CheckInterior		= true
EGWeaponJetpack.Path				= nil--"Box"
EGWeaponJetpack.NumProjectiles		= 1
EGWeaponJetpack.Speed				= 100
EGWeaponJetpack.Lifetime			= 1
EGWeaponJetpack.Range				= 6
EGWeaponJetpack.Damage				= 0
EGWeaponJetpack.Physics			= { Radius = .2 }
EGWeaponJetpack.SpreadX			= 0.0
EGWeaponJetpack.SpreadY			= 0.0
EGWeaponJetpack.CooldownTime		= .2
EGWeaponJetpack.FlareParticlesName	= nil
EGWeaponJetpack.ImpactParticles	= "FireExtinguishImpact"


function EGWeaponJetpack:Update( aDeltaTime )

	local engine = self.Engine
	local physicsTime = System.GetPhysicsTimeDelta()
	--local physicsTime = aDeltaTime
	local distAccum = self.DistanceAccum or 0
	
	
	if( self.Age >= self.Lifetime or distAccum >= self.Range ) then
		self:MarkForDestruction()
		engine:SetMovementVelocity( EGVector() )
		-- Don't extinguish unless we actually hit something. Otherwise its too easy
		--self:Extinguish()
		return
	end
	
	-- Make sure we don't go further than the range	
	local currentSpeed = self.Speed
	local travelDist = currentSpeed * physicsTime	
	if( travelDist > ( self.Range - distAccum ) ) then
		local distanceLeft = ( self.Range - distAccum )
		currentSpeed = self.Speed * distanceLeft / travelDist
	end
	
	
	DebugText( "Jetpack Dist Accum", distAccum )
	DebugText( "Jetpack Distance Desired", travelDist )
	DebugText( "Jetpack Distance Adjusted", currentSpeed * physicsTime )
	DebugText( "Jetpack Speed Adjusted", currentSpeed )
	DebugText( "Jetpack physicsTime", physicsTime )
	DebugText( "Jetpack Target", distAccum + currentSpeed * physicsTime )
	DebugText( "Jetpack Distance Left", self.Range - distAccum )
	
	
	engine:SetMovementVelocity( EGVector( 0, currentSpeed, 0 ) )
	
	self.Age = self.Age + physicsTime
	self.DistanceAccum = distAccum + currentSpeed * physicsTime
end


function EGWeaponJetpack:Extinguish()
	local interior = self.Engine:GetCurrentInterior()
	if( interior and interior.OnExtinguishFires ) then
		local interiorToSelf = interior.Engine:GetTransformTo( self.Engine )
		local impactPos = interiorToSelf:GetTranslate()
		interior:OnExtinguishFires( impactPos )
	end
end


function EGWeaponJetpack:OnCollision( aClass, aLocalContactPoint, aNonHavok, aEntityContactPoint )

	local allowHit = EGWeaponBullet.OnCollision( self, aClass, aLocalContactPoint )
		
	if( aClass.Name == "Interior" ) then
		allowHit = true
	else
		allowHit = false
		---[[
		-- Fake an impact when we are going to let the projectile pass through, But only once
		self.PlayedParticles = self.PlayedParticles or {}
		if( not self.PlayedParticles[ aClass ] ) then
			self.PlayedParticles[ aClass ] = true
			local impactPosition = aEntityContactPoint.Position
			local impactNormal = aEntityContactPoint.Normal
			local weaponParticles = self.ImpactParticles
			if( weaponParticles ) then
				aClass.Engine:AttachParticles( "EG_NO_PARTICLE_NAME", weaponParticles, 1.0, impactPosition, impactNormal )
			end
		end
		--]]
	end
		
	self:Extinguish()
	
	--EGError( "Extringuish hit: "..aClass.Name.." - "..tostring( allowHit ) )
	return allowHit
end

--end kevins version
----------------------------


EGMakeClass( "EGWeaponExtinguisher", "EGWeaponBullet" )
EGWeaponExtinguisher.CheckInterior		= true
EGWeaponExtinguisher.Path				= nil--"Box"
EGWeaponExtinguisher.NumProjectiles		= 1
EGWeaponExtinguisher.Speed				= 100
EGWeaponExtinguisher.Lifetime			= 1
EGWeaponExtinguisher.Range				= 6
EGWeaponExtinguisher.Damage				= 0
EGWeaponExtinguisher.Physics			= { Radius = .2 }
EGWeaponExtinguisher.SpreadX			= 0.0
EGWeaponExtinguisher.SpreadY			= 0.0
EGWeaponExtinguisher.CooldownTime		= .2
EGWeaponExtinguisher.FlareParticlesName	= nil
EGWeaponExtinguisher.ImpactParticles	= "FireExtinguishImpact"

-------------------------------------------------------------------------------
function EGWeaponExtinguisher:Update( aDeltaTime )

	local engine = self.Engine
	local physicsTime = System.GetPhysicsTimeDelta()
	--local physicsTime = aDeltaTime
	local distAccum = self.DistanceAccum or 0
	
	
	if( self.Age >= self.Lifetime or distAccum >= self.Range ) then
		self:MarkForDestruction()
		engine:SetMovementVelocity( EGVector() )
		-- Don't extinguish unless we actually hit something. Otherwise its too easy
		--self:Extinguish()
		return
	end
	
	-- Make sure we don't go further than the range	
	local currentSpeed = self.Speed
	local travelDist = currentSpeed * physicsTime	
	if( travelDist > ( self.Range - distAccum ) ) then
		local distanceLeft = ( self.Range - distAccum )
		currentSpeed = self.Speed * distanceLeft / travelDist
	end
	
	
	DebugText( "Extinguish Dist Accum", distAccum )
	DebugText( "Extinguish Distance Desired", travelDist )
	DebugText( "Extinguish Distance Adjusted", currentSpeed * physicsTime )
	DebugText( "Extinguish Speed Adjusted", currentSpeed )
	DebugText( "Extinguish physicsTime", physicsTime )
	DebugText( "Extinguish Target", distAccum + currentSpeed * physicsTime )
	DebugText( "Extinguish Distance Left", self.Range - distAccum )
	
	
	engine:SetMovementVelocity( EGVector( 0, currentSpeed, 0 ) )
	
	self.Age = self.Age + physicsTime
	self.DistanceAccum = distAccum + currentSpeed * physicsTime
end

-------------------------------------------------------------------------------
function EGWeaponExtinguisher:Extinguish()
	local interior = self.Engine:GetCurrentInterior()
	if( interior and interior.OnExtinguishFires ) then
		local interiorToSelf = interior.Engine:GetTransformTo( self.Engine )
		local impactPos = interiorToSelf:GetTranslate()
		interior:OnExtinguishFires( impactPos )
	end
end

-------------------------------------------------------------------------------
function EGWeaponExtinguisher:OnCollision( aClass, aLocalContactPoint, aNonHavok, aEntityContactPoint )

	local allowHit = EGWeaponBullet.OnCollision( self, aClass, aLocalContactPoint )
		
	if( aClass.Name == "Interior" ) then
		allowHit = true
	else
		allowHit = false
		---[[
		-- Fake an impact when we are going to let the projectile pass through, But only once
		self.PlayedParticles = self.PlayedParticles or {}
		if( not self.PlayedParticles[ aClass ] ) then
			self.PlayedParticles[ aClass ] = true
			local impactPosition = aEntityContactPoint.Position
			local impactNormal = aEntityContactPoint.Normal
			local weaponParticles = self.ImpactParticles
			if( weaponParticles ) then
				aClass.Engine:AttachParticles( "EG_NO_PARTICLE_NAME", weaponParticles, 1.0, impactPosition, impactNormal )
			end
		end
		--]]
	end
		
	self:Extinguish()
	
	--EGError( "Extringuish hit: "..aClass.Name.." - "..tostring( allowHit ) )
	return allowHit
end


-------------------------------------------------------------------------------
EGMakeClass( "EGWeaponRingBlaster", "EGWeaponBullet" )

EGWeaponRingBlaster.Path				= "Projectile.RingPulse.egm"
EGWeaponRingBlaster.DisplayName			= "Ring Blaster"
EGWeaponRingBlaster.NumProjectiles		= 1
EGWeaponRingBlaster.Speed				= 3000
EGWeaponRingBlaster.Damage				= 8
EGWeaponRingBlaster.Lifetime			= 5
EGWeaponRingBlaster.Physics				= { Radius = 76 }
EGWeaponRingBlaster.SpreadX				= 0.04
EGWeaponRingBlaster.SpreadY				= 0.04
EGWeaponRingBlaster.CooldownTime		= 0.15
EGWeaponRingBlaster.FlareParticlesName	= "GunFlare"
EGWeaponRingBlaster.SoundName			= "Blaster"
EGWeaponRingBlaster.ImpactParticles		= "RingBlasterImpact"


-------------------------------------------------------------------------------
EGMakeClass( "EGWeaponBomberRingBlaster", "EGWeaponRingBlaster" )
EGWeaponRingBlaster.Damage				= 5

--[[
numProjectiles = 20
bulletRandomSpreadX = .4
bulletRandomSpreadY = .1
--self.GunCooldown = self.GunCooldown + 0.5
--]]

-------------------------------------------------------------------------------
EGMakeClass( "EGWeaponLaser", "EGWeaponBullet" )

EGWeaponLaser.Path					= nil --"Projectile.RingPulse.egm"
EGWeaponLaser.DisplayName			= "Laser Blaster"
EGWeaponLaser.NumProjectiles		= 1
EGWeaponLaser.Speed					= 3000
EGWeaponLaser.Damage				= 5
EGWeaponLaser.Lifetime				= 5
EGWeaponLaser.Physics				= { Radius = 76 }
EGWeaponLaser.SpreadX				= 0.02
EGWeaponLaser.SpreadY				= 0.02
EGWeaponLaser.CooldownTime			= 0.1
EGWeaponLaser.FlareParticlesName	= "GunFlare"
EGWeaponLaser.SoundName				= "Blaster"
EGWeaponLaser.ImpactParticles		= "RingBlasterImpact"

function EGWeaponLaser:Update( aDeltaTime )
	self.Engine:AttachParticles( "Laserblaster", "Laserblaster", 1.0, EGVector.ZERO, EGVector.FOREWARD )
	EGWeaponBullet.Update( self, aDeltaTime )
end


-------------------------------------------------------------------------------
EGMakeClass( "EGWeaponLaserShotgun", "EGWeaponLaser" )
EGWeaponLaserShotgun.DisplayName			= "Hail Blaster"
EGWeaponLaserShotgun.Speed					= 3000
EGWeaponLaserShotgun.Damage					= 3
EGWeaponLaserShotgun.Lifetime				= 2
EGWeaponLaserShotgun.SpreadX				= 0.2
EGWeaponLaserShotgun.SpreadY				= 0.2
EGWeaponLaserShotgun.CooldownTime			= 0.02


-------------------------------------------------------------------------------
EGMakeClass( "EGWeaponSphereLaserShotgun", "EGWeaponLaserShotgun" )
EGWeaponSphereLaserShotgun.Damage					= 5

--EGMakeClass( "EGWeaponBattleshipMissile", "EGWeaponConcussionMissile" )


-------------------------------------------------------------------------------
EGMakeClass( "EGWeaponMegablaster", "EGWeaponBullet" )

EGWeaponMegablaster.Path				= nil--"Projectile.RingPulse.egm"
EGWeaponMegablaster.DisplayName		= "Mega Blaster"
EGWeaponMegablaster.NumProjectiles		= 1
EGWeaponMegablaster.Speed				= 3000
EGWeaponMegablaster.Damage				= 50
EGWeaponMegablaster.Lifetime			= 5
EGWeaponMegablaster.Physics				= { Radius = 100 }
EGWeaponMegablaster.SpreadX				= 0.0
EGWeaponMegablaster.SpreadY				= 0.0
EGWeaponMegablaster.CooldownTime		= 1
--EGWeaponMegablaster.EnduresCollision	= true
EGWeaponMegablaster.FlareParticlesName	= "GunFlare"
EGWeaponMegablaster.SoundName			= "Blaster"
EGWeaponMegablaster.ImpactParticles		= "MegaBlasterImpact"

function EGWeaponMegablaster:Update( aDeltaTime )
	self.Engine:AttachParticles( "Megablaster", "Megablaster", 1.0, EGVector.ZERO, EGVector.FOREWARD )
	EGWeaponBullet.Update( self, aDeltaTime )
end


-------------------------------------------------------------------------------
EGMakeClass( "EGWeaponConcussionMissile", "EGWeaponMissile" )

EGWeaponConcussionMissile.Path					= "Projectile.Missile.egm"
EGWeaponConcussionMissile.DisplayName			= "Missiles"
EGWeaponConcussionMissile.NumProjectiles		= 1
EGWeaponConcussionMissile.Speed					= 1000
EGWeaponConcussionMissile.Damage				= 20
EGWeaponConcussionMissile.Lifetime				= 1
EGWeaponConcussionMissile.Physics				= { Radius = 1 }
EGWeaponConcussionMissile.SpreadX				= 0.0
EGWeaponConcussionMissile.SpreadY				= 0.0
EGWeaponConcussionMissile.CooldownTime			= .5
EGWeaponConcussionMissile.FlareParticlesName	= "GunFlare"
EGWeaponConcussionMissile.SoundName				= "Blaster"


-------------------------------------------------------------------------------
EGMakeClass( "EGWeaponBattleshipMissile", "EGWeaponConcussionMissile" )
EGWeaponBattleshipMissile.CooldownTime			= 3
EGWeaponBattleshipMissile.Speed					= 600

-------------------------------------------------------------------------------
EGMakeClass( "EGWeaponBomberMissile", "EGWeaponConcussionMissile" )
EGWeaponBomberMissile.CooldownTime			= 2
EGWeaponBomberMissile.Speed					= 600
--EGWeaponBomberMissile.TargetDelayTime		= 0






