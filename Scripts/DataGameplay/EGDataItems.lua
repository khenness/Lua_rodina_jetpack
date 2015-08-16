--Copyright Elliptic Games LLC.
-------------------------------------------------------------------------------

--System.PreloadModel( "Test.egm", { Glow = true, SubObject = "Screen" } )
System.PreloadModel( "Projectile.Pulse.egm", nil )
System.PreloadModel( "Projectile.RingPulse.egm", { Glow = true } )
System.PreloadModel( "Projectile.Missile.egm", nil )
System.PreloadModel( "Items.Upgrade.egm", { GlowAdd = true } )
System.PreloadModel( "Items.Diaconium.egm", { BacksideColor = EGVector( 0.75, 0.75, 0.75 ) } )


-------------------------------------------------------------------------------
EGMakeClass( "Items.Barrel", "EGWorldObject" )
Items.Barrel.Name				= "Barrel"
Items.Barrel.Path				= "Furniture.Barrel.egm"
Items.Barrel.ShowInfo			= true
System.Interior.RegisterEntityType( Items.Barrel )

-------------------------------------------------------------------------------
EGMakeClass( "Items.Bed", "EGWorldObject" )
Items.Bed.Name				= "Bed"
Items.Bed.Path				= "Furniture.Bed.egm"
Items.Bed.ShowInfo			= false
System.Interior.RegisterEntityType( Items.Bed )

-------------------------------------------------------------------------------
EGMakeClass( "Items.Crate", "EGWorldObject" )
Items.Crate.Name				= "Crate"
Items.Crate.Path				= "Furniture.Crate.egm"
Items.Crate.ShowInfo			= true
System.Interior.RegisterEntityType( Items.Crate )

-------------------------------------------------------------------------------
EGMakeClass( "Items.Desk", "EGWorldObject" )
Items.Desk.Name					= "Desk"
Items.Desk.Path					= "Furniture.Desk.egm"
Items.Desk.ShowInfo				= false
System.Interior.RegisterEntityType( Items.Desk )

-------------------------------------------------------------------------------
EGMakeClass( "Items.DeskChair", "EGWorldObject" )
Items.DeskChair.Name				= "Desk Chair"
Items.DeskChair.Path				= "Furniture.DeskChair.egm"
Items.DeskChair.ShowInfo			= false
Items.DeskChair.IsChair				= true
System.Interior.RegisterEntityType( Items.DeskChair )

-------------------------------------------------------------------------------
EGMakeClass( "Items.Dresser", "EGWorldObject" )
Items.Dresser.Name					= "Dresser"
Items.Dresser.Path					= "Furniture.Dresser.egm"
Items.Dresser.ShowInfo				= false
System.Interior.RegisterEntityType( Items.Dresser )

-------------------------------------------------------------------------------
EGMakeClass( "Items.EndTable", "EGWorldObject" )
Items.EndTable.Name					= "EndTable"
Items.EndTable.Path					= "Furniture.EndTable.egm"
Items.EndTable.ShowInfo				= false
System.Interior.RegisterEntityType( Items.EndTable )

-------------------------------------------------------------------------------
EGMakeClass( "Items.HousePlant", "EGWorldObject" )
Items.HousePlant.Name				= "House Plant"
Items.HousePlant.Path				= "Furniture.HousePlantBig.egm"
Items.HousePlant.ShowInfo			= false
System.Interior.RegisterEntityType( Items.HousePlant )

-------------------------------------------------------------------------------
EGMakeClass( "Items.PilotChair", "EGWorldObject" )
Items.PilotChair.Name				= "Pilot Chair"
Items.PilotChair.Path				= "Furniture.PilotChair.egm"
Items.PilotChair.ShowInfo			= false
Items.PilotChair.IsChair			= true
System.Interior.RegisterEntityType( Items.PilotChair )

-------------------------------------------------------------------------------
EGMakeClass( "Items.Rug", "EGWorldObject" )
Items.Rug.Name						= "Rug"
Items.Rug.Path						= "Furniture.Rug.egm"
Items.Rug.ShowInfo					= false
System.Interior.RegisterEntityType( Items.Rug )

-------------------------------------------------------------------------------
EGMakeClass( "Items.Shelves", "EGWorldObject" )
Items.Shelves.Name					= "Shelves"
Items.Shelves.Path					= "Furniture.ShelvingUnit.egm"
Items.Shelves.ShowInfo				= true
System.Interior.RegisterEntityType( Items.Shelves )

-------------------------------------------------------------------------------
EGMakeClass( "Items.ShowerHead", "EGWorldObject" )
Items.ShowerHead.Name				= "ShowerHead"
Items.ShowerHead.Path				= "Furniture.ShowerHead.egm"
Items.ShowerHead.ShowInfo			= true
System.Interior.RegisterEntityType( Items.ShowerHead )

-------------------------------------------------------------------------------
EGMakeClass( "Items.ShowerWall", "EGWorldObject" )
Items.ShowerWall.Name				= "ShowerWall"
Items.ShowerWall.DisplayName		= "Shower"
Items.ShowerWall.Path				= "Furniture.ShowerWall.egm"
Items.ShowerWall.ShowInfo			= true
System.Interior.RegisterEntityType( Items.ShowerWall )

-------------------------------------------------------------------------------
EGMakeClass( "Items.Sink", "EGWorldObject" )
Items.Sink.Name						= "Sink"
Items.Sink.Path						= "Furniture.Sink.egm"
Items.Sink.ShowInfo					= true
System.Interior.RegisterEntityType( Items.Sink )

-------------------------------------------------------------------------------
EGMakeClass( "Items.StorageTable", "EGWorldObject" )
Items.StorageTable.Name					= "Storage Table"
Items.StorageTable.Path					= "Furniture.StorageTable.egm"
Items.StorageTable.ShowInfo				= true
System.Interior.RegisterEntityType( Items.StorageTable )

-------------------------------------------------------------------------------
EGMakeClass( "Items.StorageCloset", "EGWorldObject" )
Items.StorageCloset.Name			= "Storage Closet"
Items.StorageCloset.Path			= "Furniture.StorageCloset.egm"
Items.StorageCloset.ShowInfo		= true
System.Interior.RegisterEntityType( Items.StorageCloset )

-------------------------------------------------------------------------------
EGMakeClass( "Items.Toilet", "EGWorldObject" )
Items.Toilet.Name					= "Toilet"
Items.Toilet.Path					= "Furniture.Toilet.egm"
Items.Toilet.ShowInfo				= true
Items.Toilet.IsChair				= true
System.Interior.RegisterEntityType( Items.Toilet )


-------------------------------------------------------------------------------
EGMakeClass( "Items.Airlock", "EGWorldObject" )
Items.Airlock.Name					= "Airlock Computer"
Items.Airlock.DisplayName			= "Airlock Computer"
Items.Airlock.Path					= "Machines.Airlock.egm"
Items.Airlock.ShowInfo				= true
Items.Airlock.LockEditorPlacement	= true
System.Interior.RegisterEntityType( Items.Airlock )

function Items.Airlock:OnGrab( aActor )
	local vehicleOwner = self.Engine:GetVehicleOwner()
	System.GetCurrentScene().MenuSystem:Open( EGMenuAirlock, { Vehicle = vehicleOwner, Computer = self } )
end

Items.Airlock.CloseAirlock			= false
Items.Airlock.OpenAirlockIn			= false
Items.Airlock.OpenAirlockOut		= true
Items.Airlock.AirPressure			= 0
Items.Airlock.AirPressureTime		= 3

-------------------------------------------------------------------------------
function Items.Airlock:Update( aDeltaTime )
---[[
	local vehicleOwner = self.Engine:GetVehicleOwner()
	if( vehicleOwner ) then
		local inDoor = vehicleOwner:GetChildEntity( "DoorAirlockIn" )
		local outDoor = vehicleOwner:GetChildEntity( "DoorAirlockOut" )
				
		local inDoorClosed = ( inDoor:GetOpenFactor() == 0 )
		local outDoorClosed = ( outDoor:GetOpenFactor() == 0 )
		
		System.SetAllowInteriorRenderMode( outDoorClosed )
		
		local room = self.Engine:GetCurrentRoom()
		self.AirPressure = room:GetAirPressure()
		
		if( outDoorClosed ) then			
			room:SetRepressurize( true )
			local airlockAir =  EGAnalogue( self.AirPressure, .66, 1, 1, 0 )
			self.Engine:AttachParticles( "AirlockAir", "AirlockAir", airlockAir, EGVector( -.15, .1, 1.55 ), EGVector( 0, -1, -.5 ) )
			System.Audio.PlaySound( "Airlock", airlockAir, self.Engine )
		end
		
		if( vehicleOwner:IsPiloted() ) then
			self.OpenAirlockOut = false
			outDoor:Close()
		end		
		
		if( self.CloseAirlock ) then
			inDoor:Close()
			outDoor:Close()
			
		elseif( self.OpenAirlockIn ) then
			outDoor:Close()
			if( outDoor:GetOpenFactor() == 0 and self.AirPressure > .99 ) then
				inDoor:Open()
			end
			
		elseif( self.OpenAirlockOut ) then
			
			if( inDoorClosed ) then
				room:SetRepressurize( false )
				local planet = self:GetCurrentPlanet()
				local planetPressure = planet:GetAirPressure( self )
				room:DeltaAirPressure( planetPressure - self.AirPressure )
			end
			
			inDoor:Close()
			if( inDoor:GetOpenFactor() == 0 ) then
				outDoor:Open()
			end
		end
		--]]
	end
end

-------------------------------------------------------------------------------
EGMakeClass( "Items.AmmoniaTank", "EGWorldObject" )
Items.AmmoniaTank.Name				= "Ammonia Tank"
Items.AmmoniaTank.DisplayName		= "Pressurized Tank"
Items.AmmoniaTank.Path				= "Machines.PressurizedTank.egm"
Items.AmmoniaTank.ShowInfo			= true
--Items.AmmoniaTank.Info				= "Tank of Ammonia\ns% % full."
System.Interior.RegisterEntityType( Items.AmmoniaTank )

-------------------------------------------------------------------------------
EGMakeClass( "Items.Archives", "EGWorldObject" )
Items.Archives.Name			= "Archives"
Items.Archives.Path			= "Machines.Archives.egm"
Items.Archives.ShowInfo		= true
System.Interior.RegisterEntityType( Items.Archives )

function Items.Archives:OnGrab( aActor )
	System.GetCurrentScene().MenuSystem:Open( EGMenuArchives )
end

-------------------------------------------------------------------------------
EGMakeClass( "Items.BatteryArray", "EGWorldObject" )
Items.BatteryArray.Name			= "Battery Array"
Items.BatteryArray.Path			= "Machines.BatteryArray.egm"
Items.BatteryArray.ShowInfo		= true
System.Interior.RegisterEntityType( Items.BatteryArray )

-------------------------------------------------------------------------------
EGMakeClass( "Items.FTL_Radio", "EGWorldObject" )
Items.FTL_Radio.Name				= "Pilot Wave Radio"
Items.FTL_Radio.Path				= "Machines.FTLRadio.egm"
Items.FTL_Radio.ShowInfo			= true
Items.FTL_Radio.StoryCount			= 0
Items.FTL_Radio.MessageCount		= 0
System.Interior.RegisterEntityType( Items.FTL_Radio )

function Items.FTL_Radio:OnGrab( aActor )
	System.GetCurrentScene().MenuSystem:Open( EGMenuRadio )
end

function Items.FTL_Radio:Update( aDeltaTime )	
	local playerInfo = gGame:GetPlayerInfo()
	local hasNew = false
	hasNew = hasNew or playerInfo:GetHasNewDocument( "RodinaMessages" )
	hasNew = hasNew or playerInfo:GetHasNewDocument( "MainStoryline" )
	if( hasNew ) then
		System.Audio.PlaySound( "FTLRadioIncoming", 1, self.Engine )
		self.Engine:AttachParticles( "FTL Signal", "FTL Radio Signal", 1.0, EGVector(-.5,.4,1.2), EGVector() )
	end
end

-------------------------------------------------------------------------------
EGMakeClass( "Items.Generator", "EGWorldObject" )
Items.Generator.Name			= "Generator"
Items.Generator.Path			= "Machines.Generator.egm"
Items.Generator.ShowInfo	= true
System.Interior.RegisterEntityType( Items.Generator )

-------------------------------------------------------------------------------
EGMakeClass( "Items.Holoscreen", "EGWorldObject" )
Items.Holoscreen.Name			= "Holoscreen"
Items.Holoscreen.Path			= "Machines.Holoscreen.egm"
Items.Holoscreen.ShowInfo		= true
System.Interior.RegisterEntityType( Items.Holoscreen )

-------------------------------------------------------------------------------
EGMakeClass( "Items.LimnalDrive", "EGWorldObject" )
Items.LimnalDrive.Name			= "Limnal Drive"
Items.LimnalDrive.Path			= "Machines.LimnalDrive.egm"
Items.LimnalDrive.ShowInfo	= true
System.Interior.RegisterEntityType( Items.LimnalDrive )

-------------------------------------------------------------------------------
EGMakeClass( "Items.PilotStation", "EGWorldObject" )
Items.PilotStation.Name		= "Pilot Station"
Items.PilotStation.Path		= "Machines.PilotStation.egm"
--Items.PilotStation.Info		= "Press (A) to fly the ship"
Items.PilotStation.ShowInfo	= true
System.Interior.RegisterEntityType( Items.PilotStation )

function Items.PilotStation:OnGrab( aActor )
	local vehicleOwner = self.Engine:GetVehicleOwner()
	
	if( vehicleOwner.Health and vehicleOwner.Health <= 0 ) then
		HUD:AddNotification( "Your ship has been destroyed" )
		return
	end
		
	local interior = self.Engine:GetCurrentInterior()
	if( interior and interior:GetAllDoorsOpen() ) then
		HUD:AddNotification( "Close all doors before piloting ship" )
		return
	end	
	
	gGame:SetAllowFirstPersonPilot( true )
	gGame:StartPilotingVehicle( vehicleOwner )	
	gGame:Autosave( "Pilots Ship" )
end

-------------------------------------------------------------------------------
EGMakeClass( "Items.Scanners", "EGWorldObject" )
Items.Scanners.Name		= "Scanners"
Items.Scanners.Path		= "Machines.Scanners.egm"
Items.Scanners.ShowInfo	= true
System.Interior.RegisterEntityType( Items.Scanners )

function Items.Scanners:OnGrab( aActor )
	System.GetCurrentScene().MenuSystem:Open( EGMenuScanners )
end

-------------------------------------------------------------------------------
EGMakeClass( "Items.ShipStatus", "EGWorldObject" )
Items.ShipStatus.Name		= "Operations Computer"
Items.ShipStatus.Path		= "Machines.ShipStatus.egm"
Items.ShipStatus.ShowInfo	= true
System.Interior.RegisterEntityType( Items.ShipStatus )

function Items.ShipStatus:OnGrab( aActor )
	local vehicleOwner = self.Engine:GetVehicleOwner()
	System.GetCurrentScene().MenuSystem:Open( EGMenuOperations, { Vehicle = vehicleOwner, Computer = self } )
end

-------------------------------------------------------------------------------
EGMakeClass( "Items.Door", "EGWorldObject" )
Items.Door.Name						= "Door"
Items.Door.EntityType				= "Door"
Items.Door.Path						= "Furniture.DoorRegular.egm"
Items.Door.ShowInfo					= true
Items.Door.EngineIsDoor				= true
Items.Door.OpenFactor				= 0
Items.Door.OpenMult					= .95
Items.Door.OpenSpeed				= 3
Items.Door.LockEditorPlacement		= true
Items.Door.Autoclose				= true
Items.Door.IsForceOpen				= false
Items.Door.OpenSound				= "DoorOpen"
Items.Door.CloseSound				= "DoorClose"
Items.Door.DepressurizeParticles	= "RoomAirDepressurize"

Items.Door.Physics					=
{
	ShapeType = "Box",
	ExtentLow = EGVector( -.65, -.1, 0 ),
	ExtentHigh = EGVector( 0.65, 0.1, 2.5 )
}

System.Interior.RegisterEntityType( Items.Door )

function Items.Door:OnGrab( )
	self:Open()
end

function Items.Door:GetOpenFactor()
	return self.Engine:GetOpenFactor()
end

function Items.Door:SetForceOpen( aValue )
	if( aValue ~= self.IsForceOpen ) then
		self.IsForceOpen = aValue
		if( self.IsForceOpen ) then
			self:Open()
		end
	end
end

function Items.Door:Open()
	if( not self.Engine:GetOpening() ) then
		self.Engine:SetOpening( true )
		System.Audio.PlaySound( self.OpenSound, 1, self.Engine )
	end
end

function Items.Door:Close()
	if( self.Engine:GetOpening() and not self.IsForceOpen ) then
		self.Engine:SetOpening( false )
		System.Audio.PlaySound( self.CloseSound, 1, self.Engine )
	end
end

function Items.Door:SetAnimation( aValue )
	local moveAmount = aValue * self.OpenMult
	self.Engine:SetPartTranslate( "Left",		EGVector( moveAmount * -.35, 0, 0 ) )
	self.Engine:SetPartTranslate( "MidLeft",	EGVector( moveAmount * -.65, 0, 0 ) )
	self.Engine:SetPartTranslate( "MidRight",	EGVector( moveAmount * .65, 0, 0 ) )
	self.Engine:SetPartTranslate( "Right",		EGVector( moveAmount * .35, 0, 0 ) )
end
 
function Items.Door:Update( aDeltaTime )
	
	-- Actual logic of animating the door and physics is handled on engine side now.
		
	if( self.Engine:GetOpening() and self.Autoclose and not self.IsForceOpen ) then
		local player = gGame:GetPlayer()
		local distance = self:GetDistance( player )
		if( distance > 6 ) then
			self:Close()
		end
	end
end


-------------------------------------------------------------------------------
EGMakeClass( "Items.DoorAngled", "Items.Door" )
Items.DoorAngled.DisplayName		= "Door"
Items.DoorAngled.OpenMult			= .95 * math.sqrt( 2*2 + 2*2 ) / 2
Items.DoorAngled.Scale				= EGVector( math.sqrt( 2*2 + 2*2 ) / 2, 1, 1 )
System.Interior.RegisterEntityType( Items.DoorAngled )

-------------------------------------------------------------------------------
EGMakeClass( "Items.DoorAirlock", "Items.Door" )
Items.DoorAirlock.Name					= "Bulkhead Door"
Items.DoorAirlock.DisplayName			= "Bulkhead Door"
Items.DoorAirlock.Path					= "Furniture.DoorAirlock.egm"
Items.DoorAirlock.ShowInfo				= true
Items.DoorAirlock.OpenSpeed				= 1.5
Items.DoorAirlock.OpenMult				= 2.8
Items.DoorAirlock.OpenSound				= "AirlockDoorOpen"
Items.DoorAirlock.CloseSound			= "AirlockDoorClose"
Items.DoorAirlock.LockEditorPlacement	= false
Items.DoorAirlock.DepressurizeParticles	= "RoomAirDepressurizeBig"

Items.DoorAirlock.Physics				=
{
	ShapeType = "Box",
	ExtentLow = EGVector( -2, -.1, 0 ),
	ExtentHigh = EGVector( 2, 0.1, 3 )
}

System.Interior.RegisterEntityType( Items.DoorAirlock )

function Items.DoorAirlock:SetAnimation( aValue )
	local moveAmount = aValue * self.OpenMult
	self.Engine:SetPartTranslate( "Data\\Models\\"..self.Path, EGVector( 0, 0, moveAmount) )
end

-------------------------------------------------------------------------------
EGMakeClass( "Items.DoorAirlockIn", "Items.DoorAirlock" )
--Items.DoorAirlockIn.Name					= "DoorAirlockIn"
Items.DoorAirlockIn.DisplayName				= "Open Airlock In"
Items.DoorAirlockIn.Autoclose				= false
Items.DoorAirlockIn.LockEditorPlacement		= true
System.Interior.RegisterEntityType( Items.DoorAirlockIn )

function Items.DoorAirlockIn:OnGrab( )
	local vehicleOwner = self.Engine:GetVehicleOwner()	
	local computer = vehicleOwner:GetChildEntity( "Airlock Computer" )	
	computer.CloseAirlock = false
	computer.OpenAirlockIn = true
	computer.OpenAirlockOut = false
end

-------------------------------------------------------------------------------
EGMakeClass( "Items.DoorAirlockOut", "Items.DoorAirlock" )
Items.DoorAirlockOut.Name						= "DoorAirlockOut"
Items.DoorAirlockOut.DisplayName				= "Open Airlock Out"
Items.DoorAirlockOut.Autoclose					= false
Items.DoorAirlockOut.LockEditorPlacement		= true
System.Interior.RegisterEntityType( Items.DoorAirlockOut )

function Items.DoorAirlockOut:OnGrab( )
	local vehicleOwner = self.Engine:GetVehicleOwner()	
	local computer = vehicleOwner:GetChildEntity( "Airlock Computer" )
	computer.CloseAirlock = false
	computer.OpenAirlockIn = false
	computer.OpenAirlockOut = true
end

function Items.DoorAirlockOut:Open()
	if( self:GetOpenFactor() == 0 ) then
		local vehicleOwner = self.Engine:GetVehicleOwner()
		if( vehicleOwner ) then
			vehicleOwner:OnOpenAirlock()
		end
	end
	Items.Door.Open( self )
end

-------------------------------------------------------------------------------
EGMakeClass( "Items.Blaster", 			"EGWorldObject" )
Items.Blaster.ShowInfo					= true
Items.Blaster.Name						= "Basic Blasters"
Items.Blaster.Path						= "Items.Upgrade.egm"

-------------------------------------------------------------------------------
EGMakeClass( "Items.CruiseEngine", 		"EGWorldObject" )
Items.CruiseEngine.ShowInfo				= true
Items.CruiseEngine.Name					= "Cruise Engine Upgrade"
Items.CruiseEngine.Path					= "Items.Upgrade.egm"
Items.CruiseEngine.DebrisNoRotate		= true

function Items.CruiseEngine:OnCollectDebris( aActor )
	gGame:GetPlayerInfo():AddInventoryItem( self.FullName, 1 )
	local promptInfo = 
	{
		Message = "Now you can travel to other asteroids! Look up to find the radar signals of heavenly bodies...",
	}
	System.GetCurrentScene().MenuSystem:Open( EGMenuPrompt, promptInfo )
end

-------------------------------------------------------------------------------
EGMakeClass( "Items.PlanetScanners",	"Items.Scanners" )
Items.PlanetScanners.ShowInfo			= true
Items.PlanetScanners.Name				= "Long-Range Scanners"

-------------------------------------------------------------------------------
EGMakeClass( "Items.Heater",			"EGWorldObject" )
Items.Heater.ShowInfo					= true
Items.Heater.Name						= "Heating Unit Upgrade"
Items.Heater.Path						= "Items.Upgrade.egm"
Items.Heater.DebrisNoRotate				= true

function Items.Heater:OnCollectDebris( aActor )
	gGame:GetPlayerInfo():AddInventoryItem( self.FullName, 1 )
	local promptInfo = 
	{
		Message = "The Heater Upgrade will allow you to travel safely in the atmosphere of the Planet Morena...",
	}
	System.GetCurrentScene().MenuSystem:Open( EGMenuPrompt, promptInfo )
end

-------------------------------------------------------------------------------
EGMakeClass( "Items.AcidShield", 		"EGWorldObject" )
Items.AcidShield.ShowInfo				= true
Items.AcidShield.Name					= "Acidic Shielding Upgrade"
Items.AcidShield.Path					= "Items.Upgrade.egm"
Items.AcidShield.DebrisNoRotate			= true

function Items.AcidShield:OnCollectDebris( aActor )
	gGame:GetPlayerInfo():AddInventoryItem( self.FullName, 1 )
	local promptInfo = 
	{
		Message = "The Acidic Shield Upgrade will allow you to travel safely in the atmosphere of the Planet Veles...",
	}
	System.GetCurrentScene().MenuSystem:Open( EGMenuPrompt, promptInfo )
end

-------------------------------------------------------------------------------
EGMakeClass( "Items.Document",			"EGWorldObject" )
Items.Document.ShowInfo					= true
Items.Document.Name						= "Datastick"
Items.Document.Path						= "Items.Upgrade.egm"
Items.Document.DebrisNoRotate			= true

function Items.Document:GetIsValid()
	local player = gGame:GetPlayer()
	local planet = player and player:GetCurrentPlanet()
	local potentialDocument = gGame:GetProgress():ChooseDocument( planet )
	if( not potentialDocument ) then
		return false
	end
	return true
end

function Items.Document:OnCollectDebris( aActor )
	local planet = aActor:GetCurrentPlanet()
	local document = gGame:GetProgress():ChooseDocument( planet )
	
	if( document ) then
		gGame:GetPlayerInfo():AddInventoryItem( document.ID, 1 )
		System.GetCurrentScene().MenuSystem:Open( DocumentMenu, { Document = document, DocPage = math.huge, Collection = true } )
	else
		local promptInfo = 
		{
			Message = "This disk is thoroughly corrupted and useless.",
			Button2Text = "Ok",
		}
		System.GetCurrentScene().MenuSystem:Open( EGMenuPrompt, promptInfo )
	end	
end

-------------------------------------------------------------------------------
EGMakeClass( "Items.Communication",	"EGWorldObject" )
Items.Communication.ShowInfo					= true
Items.Communication.Name						= "Communication Decryption Key"
Items.Communication.Path						= "Items.Upgrade.egm"
Items.Communication.DebrisNoRotate				= true

function Items.Communication:OnCollectDebris( aActor )

	local commCount = gGame:GetPlayerInfo():GetInventoryCount( "MainStoryline" )
	if( commCount >= 11 ) then
		local promptInfo = 
		{
			Message = "This encryption key is corrupted and useless.",
			Button2Text = "Ok",
		}
		System.GetCurrentScene().MenuSystem:Open( EGMenuPrompt, promptInfo )
	else
		gGame:GetPlayerInfo():AddInventoryItem( "MainStoryline", 1 )
		local promptInfo = 
		{
			Message = "This key will allow you to read more of the encrypted communications on the FTL Radio.",
			Button2Text = "Ok",
		}
		System.GetCurrentScene().MenuSystem:Open( EGMenuPrompt, promptInfo )
	end
end


-------------------------------------------------------------------------------
EGMakeClass( "Items.FinalStoryLine",	"EGWorldObject" )
Items.FinalStoryLine.ShowInfo					= true
Items.FinalStoryLine.Name						= "To Alicja..."
Items.FinalStoryLine.Path						= "Items.Upgrade.egm"
Items.FinalStoryLine.DebrisNoRotate				= true

function Items.FinalStoryLine:OnCollectDebris( aActor )
	gGame:GetPlayerInfo():SetInventoryMinimum( "MainStoryline", 12 )
	
	local document = EGDocumentGetByID( "MainStoryline" )
	
	local function showPrompt()
		local promptInfo = 
		{
			Message = "Thank you for playing this far through the game. With your support, a future chapter of Rodina will complete the upgrades which your character is undergoing, allowing her/him to reproduce. I hope you've enjoyed the game thus far!",
			Button2Text = "Ok",
		}
		System.GetCurrentScene().MenuSystem:Open( EGMenuPrompt, promptInfo )
	end
	
	System.GetCurrentScene().MenuSystem:Open( DocumentMenu, { Document = document, DocPage = 12, Collection = true, OnCloseFunc = showPrompt } )	
end

-------------------------------------------------------------------------------
EGMakeClass( "Items.Diaconium", 		"EGWorldObject" )
Items.Diaconium.ShowInfo				= true
Items.Diaconium.Name					= "Diaconium Crystal"
Items.Diaconium.Path					= "Items.Diaconium.egm"

function Items.Diaconium:OnCollectDebris( aActor )
	local diaconiumCount = gGame:GetPlayerInfo():GetInventoryCount( "Items.Diaconium" )
	
	if( diaconiumCount == 0 ) then
		local promptInfo = 
		{
			Message = "Diaconium cystals are used to power the Limnal Drive. Now you can travel much faster across the solar system!",
			Button2Text = "Ok",
		}
		System.GetCurrentScene().MenuSystem:Open( EGMenuPrompt, promptInfo )
	end	
	gGame:GetPlayerInfo():AddInventoryItem( "Items.Diaconium", 1 )
end


-------------------------------------------------------------------------------
EGMakeClass( "Items.EmptyBarrel", "Items.Barrel" )
Items.EmptyBarrel.DisplayName		= "Empty Barrel"

-------------------------------------------------------------------------------
EGMakeClass( "Items.EmptyCrate", "Items.Crate" )
Items.EmptyCrate.DisplayName		= "Empty Crate"

-------------------------------------------------------------------------------
EGMakeClass( "Items.DebrisWall1", "EGWorldObject" )
Items.DebrisWall1.Path				= "TilesetEngineering.Wall.egm"
Items.DebrisWall1.ShowInfo			= false
Items.DebrisWall1.DisplayName		= "Useless Debris"

-------------------------------------------------------------------------------
EGMakeClass( "Items.AmmoCrate", "EGWorldObject" )
Items.AmmoCrate.DisplayName		= "Generic Ammo"
Items.AmmoCrate.Path			= "Furniture.Crate.egm"
Items.AmmoCrate.WeaponName		= "EGWeaponConcussionMissile"
Items.AmmoCrate.WeaponCount		= 10
Items.AmmoCrate.ShowInfo		= true

function Items.AmmoCrate:OnCollectDebris( aActor )
	local playerInfo = gGame:GetPlayerInfo()
	playerInfo:AddInventoryItem( self.WeaponName, self.WeaponCount )
	
	local weaponClass = EGGetClass( self.WeaponName )
	if( not playerInfo:IsDiscovered( weaponClass )	 ) then
		playerInfo:Discover( weaponClass )
	end	
end

-------------------------------------------------------------------------------
EGMakeClass( "Items.MissileCrate1", "Items.AmmoCrate" )
Items.MissileCrate1.DisplayName		= "Missile Ammo (2)"
Items.MissileCrate1.WeaponName		= "EGWeaponConcussionMissile"
Items.MissileCrate1.WeaponCount		= 2

-------------------------------------------------------------------------------
EGMakeClass( "Items.MissileCrate", "Items.AmmoCrate" )
Items.MissileCrate.DisplayName		= "Missile Ammo (5)"
Items.MissileCrate.WeaponName		= "EGWeaponConcussionMissile"
Items.MissileCrate.WeaponCount		= 5

-------------------------------------------------------------------------------
EGMakeClass( "Items.RingBlasterCrate", "Items.AmmoCrate" )
Items.RingBlasterCrate.Path				= "Furniture.Barrel.egm"
Items.RingBlasterCrate.DisplayName		= "Ring Blaster Ammo (20)"
Items.RingBlasterCrate.WeaponName		= "EGWeaponRingBlaster"
Items.RingBlasterCrate.WeaponCount		= 20

-------------------------------------------------------------------------------
EGMakeClass( "Items.HailBlasterCrate", "Items.AmmoCrate" )
Items.HailBlasterCrate.Path				= "Furniture.Barrel.egm"
Items.HailBlasterCrate.DisplayName		= "Hail Blaster Ammo (75)"
Items.HailBlasterCrate.WeaponName		= "EGWeaponLaserShotgun"
Items.HailBlasterCrate.WeaponCount		= 75

-------------------------------------------------------------------------------
EGMakeClass( "Items.MegaBlasterCrate", "Items.AmmoCrate" )
Items.MegaBlasterCrate.Path				= "Furniture.Barrel.egm"
Items.MegaBlasterCrate.DisplayName		= "Mega Blaster Ammo (5)"
Items.MegaBlasterCrate.WeaponName		= "EGWeaponMegablaster"
Items.MegaBlasterCrate.WeaponCount		= 5

-------------------------------------------------------------------------------
EGMakeClass( "Items.ShipLight", "EGWorldObject" )
Items.ShipLight.LightAddon				= "SHIP LIGHT"

function Items.ShipLight:Update( aDeltaTime )
	local playerVehicle = gGame:GetPlayerVehicle()
	local planet = playerVehicle and playerVehicle:GetCurrentPlanet()
	if( planet and planet.IsAsteroid ) then
		self.Engine:SetLight( "SHIP LIGHT", "POINT", EGVector( 1, 1, 1 ), 10000, .85 )
		--self.Engine:SetPartRotate( "SHIP LIGHT", EGVector( 0, -1, 0 ) )
	else
		self.Engine:SetLight( "SHIP LIGHT", "POINT", EGVector( 1.5, 1.5, 1.5 ), 100000, .85 )
		--self.Engine:SetPartRotate( "SHIP LIGHT", EGVector( 0, -.75, 0 ) )
	end
end

-------------------------------------------------------------------------------
EGMakeClass( "Items.ShipWalkway", "EGWorldObject" )
Items.ShipWalkway.Path				= "Ship1.ShipWalkway.egm"

Items.ShipWalkway.Physics					=
{
	ShapeType = "Box",
	MotionType = "ANIMATION_DRIVEN",	
	ExtentLow = EGVector( -2, -32.4, -.2 ),
	ExtentHigh = EGVector( 2, 0, 0 )
}

-------------------------------------------------------------------------------
EGMakeClass( "Items.PlayerLight", "EGWorldObject" )
Items.PlayerLight.LightAddon				= "PLAYER LIGHT"
function Items.PlayerLight:Update( aDeltaTime )
	self.Engine:SetLight( "PLAYER LIGHT", "POINT", EGVector( 2, 2, 2 ), 2000, .8 )
end

-------------------------------------------------------------------------------
---Kevin's version

EGMakeClass( "Items.DeskChair2", "EGWorldObject" )
Items.DeskChair2.Name				= "Desk Chair 2"
Items.DeskChair2.Path				= "Furniture.DeskChair2.egm"
Items.DeskChair2.ShowInfo			= false
Items.DeskChair2.IsChair				= true
System.Interior.RegisterEntityType( Items.DeskChair2 )

-------------

EGMakeClass( "Items.JetpackWall", "EGWorldObject" )
Items.JetpackWall.DisplayName		= "Long Range Jetpack"
Items.JetpackWall.Path				= "Machines.JetpackWall.egm"
Items.JetpackWall.ShowInfo			= true
Items.JetpackWall.CollectedTimer	= 0
System.Interior.RegisterEntityType( Items.JetpackWall )

local JETPACK_RESPAWN_TIME = 60


function Items.JetpackWall:Update( aDeltaTime )

	self.CollectedTimer = self.CollectedTimer - aDeltaTime
	
	if( self.CollectedTimer <= 0 ) then
		self.CollectedTimer = 0
		self.ShowInfo = true
		self.Engine:SetPartAlpha( "Data\\Models\\"..self.Path, 1 )
	else
		self.ShowInfo = false
		self.Engine:SetPartAlpha( "Data\\Models\\"..self.Path, 0 )
	end
end


function Items.JetpackWall:OnGrab( )
	if( self.CollectedTimer <= 0 ) then
		local existingAmmo = gGame:GetPlayerInfo():GetInventoryCount( "Items.Jetpack" )
		gGame:GetPlayerInfo():AddInventoryItem( "Items.Jetpack", 100 - existingAmmo )	
		gGame:GetPlayer():SetHeldItem( "Items.Jetpack" )
		self.CollectedTimer = JETPACK_RESPAWN_TIME
	end
end


function Items.JetpackWall:Save( aStream )
	aStream:WriteNumber( self.CollectedTimer )
end


function Items.JetpackWall:Load( aStream )
	if( aStream:GetVersion() >= 3 ) then
		self.CollectedTimer	= aStream:ReadNumber()
	end
end


EGMakeClass( "Items.Jetpack", "EGWorldObject" )
Items.Jetpack.Path				= "Machines.Jetpack.egm"
Items.Jetpack.Scale			= 1
--Items.FireExtinguisher.Weapon			= EGWeaponExtinguisher
Items.Jetpack.DisplayName		= "Jetpack"
Items.Jetpack.ParticlePos		= EGVector(0,.075,0)


function Items.Jetpack:Init( aCInfo )
	self.Weapon	= EGWeaponJetpack --Jetpack
end


function Items.Jetpack:Update( aDeltaTime )

	-- TEMP
	self.GunCooldown = self.GunCooldown or 0	
	self.GunCooldown = math.max( self.GunCooldown - aDeltaTime, 0 )
	
	local player = gGame:GetPlayer()
	local playerAlive = player.GetHealthPercent and player:GetHealthPercent() > 0
	
	if( playerAlive and System.GetPlayerControlActor() == player and gGame:GetControls():GetAction( "USE_RIGHT" ) > 0 ) then
	
		System.Audio.PlaySound( "FireExtinguisher", 1.0, self.Engine )
		System.Audio.PlaySound( "FireExtinguisher2", 1.0, self.Engine )
		System.Audio.PlaySound( "FireExtinguisher3", 1.0, self.Engine )
		System.Audio.SetSoundPitch( "FireExtinguisher2", .3 )
		System.Audio.SetSoundPitch( "FireExtinguisher3", .1 )
		self.Engine:AttachParticles( "FireExtinguish", "FireExtinguishProjectile", 1.0, self.ParticlePos, EGVector.FOREWARD )
		
		if( player.Engine:GetCharacterPhysicsContext() == "IN AIR" ) then
			player.Engine:AddLocalAcceleration( EGVector( 0, 500, 0 ) )
		end

	---[=[
		-- Hardcode this because defining it in the class doesn't work if the Extinguisher is defined before the weapon
		local weapon 	= EGWeaponJetpack
		local owner 	= self.Engine:GetCharacterOwner()
		if( weapon and owner and self.GunCooldown <= 0 ) then
		
			gGame:GetPlayerInfo():AddInventoryItem( self.FullName, -1 )

			local numProjectiles		= 1
			local bulletRandomSpreadX	= 0.01
			local bulletRandomSpreadY	= 0.01
			local cooldownTime			= 0.25
			local barrelTypeName		= weapon.BarrelTypeName
			local flareParticlesName	= weapon.FlareParticlesName
			local soundName				= weapon.SoundName
				
			local barrels = self[barrelTypeName]
			--if( type( barrels ) ~= "table" ) then		error( self.ClassName..".GunBarrels should be an EGEnum table, not a "..type( barrels ) )	end
			
			--for i,barrel in ipairs( barrels ) do
			
				--local camera = self.Engine:GetChildEntity( "Player Camera" )
				--local orientation = camera.Engine:GetLocalTransform()
				--local barrelOrientation = self.Engine:GetLocalObjectOrientation( EGEnum( "Player Camera" ) )
				--self.Engine:AttachParticles("BarrelFlare"..tostring(i), flareParticlesName, 1.0, barrelOrientation:GetTranslate(), EGVector(0,1,0) )
				
				for i = 1,numProjectiles do
					
					local bulletAngle = EGRandomFloat( 0, math.pi * 2 )
					local bulletDistance = EGRandomFloat( 0, 1 )
					local bulletExtraRotation = EGVector( math.cos( bulletAngle ) * bulletDistance * bulletRandomSpreadX, math.sin( bulletAngle ) * bulletDistance * bulletRandomSpreadY, 0 )
					
					local bullet = weapon:New{ Owner = owner }
					--bullet.Orientation		= orientation
					--bullet.ExtraRotation	= bulletExtraRotation
					bullet.OwnerEntity		= owner.Engine
					bullet.AnchorEntity		= self.Engine
					bullet.ParentPlanet	= self:GetCurrentPlanet().Engine
					System.GetCurrentScene():Add( bullet )
				end	
			--end
			
			self.GunCooldown = self.GunCooldown + cooldownTime
			--[[
			if( soundName and self.GunSoundCooldown <= 0 ) then
				System.Audio.PlaySound( soundName, 1, self.Engine )
				self.GunSoundCooldown = .1
			end
			--]]
		end
	--]=]
	end
end


--end Kevin's version
-------------------------------------------------------------------------------
EGMakeClass( "Items.FireExtinguisherWall", "EGWorldObject" )
Items.FireExtinguisherWall.DisplayName		= "Fire Extinguisher"
Items.FireExtinguisherWall.Path				= "Machines.FireExtinguisherWall.egm"
Items.FireExtinguisherWall.ShowInfo			= true
Items.FireExtinguisherWall.CollectedTimer	= 0
System.Interior.RegisterEntityType( Items.FireExtinguisherWall )

local FIRE_EXTINGUISHER_RESPAWN_TIME = 60

-------------------------------------------------------------------------------
function Items.FireExtinguisherWall:Update( aDeltaTime )

	self.CollectedTimer = self.CollectedTimer - aDeltaTime
	
	if( self.CollectedTimer <= 0 ) then
		self.CollectedTimer = 0
		self.ShowInfo = true
		self.Engine:SetPartAlpha( "Data\\Models\\"..self.Path, 1 )
	else
		self.ShowInfo = false
		self.Engine:SetPartAlpha( "Data\\Models\\"..self.Path, 0 )
	end
end

-------------------------------------------------------------------------------
function Items.FireExtinguisherWall:OnGrab( )
	if( self.CollectedTimer <= 0 ) then
		local existingAmmo = gGame:GetPlayerInfo():GetInventoryCount( "Items.FireExtinguisher" )
		gGame:GetPlayerInfo():AddInventoryItem( "Items.FireExtinguisher", 100 - existingAmmo )	
		gGame:GetPlayer():SetHeldItem( "Items.FireExtinguisher" )
		self.CollectedTimer = FIRE_EXTINGUISHER_RESPAWN_TIME
	end
end

-------------------------------------------------------------------------------
function Items.FireExtinguisherWall:Save( aStream )
	aStream:WriteNumber( self.CollectedTimer )
end

-------------------------------------------------------------------------------
function Items.FireExtinguisherWall:Load( aStream )
	if( aStream:GetVersion() >= 3 ) then
		self.CollectedTimer	= aStream:ReadNumber()
	end
end

-------------------------------------------------------------------------------
EGMakeClass( "Items.FireExtinguisher", "EGWorldObject" )
Items.FireExtinguisher.Path				= "Machines.FireExtinguisher.egm"
Items.FireExtinguisher.Scale			= 1
--Items.FireExtinguisher.Weapon			= EGWeaponExtinguisher
Items.FireExtinguisher.DisplayName		= "Extinguisher"
Items.FireExtinguisher.ParticlePos		= EGVector(0,.075,0)

-------------------------------------------------------------------------------
function Items.FireExtinguisher:Init( aCInfo )
	self.Weapon	= EGWeaponExtinguisher
end

-------------------------------------------------------------------------------
function Items.FireExtinguisher:Update( aDeltaTime )

	-- TEMP
	self.GunCooldown = self.GunCooldown or 0	
	self.GunCooldown = math.max( self.GunCooldown - aDeltaTime, 0 )
	
	local player = gGame:GetPlayer()
	local playerAlive = player.GetHealthPercent and player:GetHealthPercent() > 0
	
	if( playerAlive and System.GetPlayerControlActor() == player and gGame:GetControls():GetAction( "USE_RIGHT" ) > 0 ) then
	
		System.Audio.PlaySound( "FireExtinguisher", 1.0, self.Engine )
		System.Audio.PlaySound( "FireExtinguisher2", 1.0, self.Engine )
		System.Audio.PlaySound( "FireExtinguisher3", 1.0, self.Engine )
		System.Audio.SetSoundPitch( "FireExtinguisher2", .3 )
		System.Audio.SetSoundPitch( "FireExtinguisher3", .1 )
		self.Engine:AttachParticles( "FireExtinguish", "FireExtinguishProjectile", 1.0, self.ParticlePos, EGVector.FOREWARD )
		
		if( player.Engine:GetCharacterPhysicsContext() == "IN AIR" ) then
			player.Engine:AddLocalAcceleration( EGVector( 0, -15, 0 ) )
		end

	---[=[
		-- Hardcode this because defining it in the class doesn't work if the Extinguisher is defined before the weapon
		local weapon 	= EGWeaponExtinguisher
		local owner 	= self.Engine:GetCharacterOwner()
		if( weapon and owner and self.GunCooldown <= 0 ) then
		
			gGame:GetPlayerInfo():AddInventoryItem( self.FullName, -1 )

			local numProjectiles		= 1
			local bulletRandomSpreadX	= 0.01
			local bulletRandomSpreadY	= 0.01
			local cooldownTime			= 0.25
			local barrelTypeName		= weapon.BarrelTypeName
			local flareParticlesName	= weapon.FlareParticlesName
			local soundName				= weapon.SoundName
				
			local barrels = self[barrelTypeName]
			--if( type( barrels ) ~= "table" ) then		error( self.ClassName..".GunBarrels should be an EGEnum table, not a "..type( barrels ) )	end
			
			--for i,barrel in ipairs( barrels ) do
			
				--local camera = self.Engine:GetChildEntity( "Player Camera" )
				--local orientation = camera.Engine:GetLocalTransform()
				--local barrelOrientation = self.Engine:GetLocalObjectOrientation( EGEnum( "Player Camera" ) )
				--self.Engine:AttachParticles("BarrelFlare"..tostring(i), flareParticlesName, 1.0, barrelOrientation:GetTranslate(), EGVector(0,1,0) )
				
				for i = 1,numProjectiles do
					
					local bulletAngle = EGRandomFloat( 0, math.pi * 2 )
					local bulletDistance = EGRandomFloat( 0, 1 )
					local bulletExtraRotation = EGVector( math.cos( bulletAngle ) * bulletDistance * bulletRandomSpreadX, math.sin( bulletAngle ) * bulletDistance * bulletRandomSpreadY, 0 )
					
					local bullet = weapon:New{ Owner = owner }
					--bullet.Orientation		= orientation
					--bullet.ExtraRotation	= bulletExtraRotation
					bullet.OwnerEntity		= owner.Engine
					bullet.AnchorEntity		= self.Engine
					bullet.ParentPlanet	= self:GetCurrentPlanet().Engine
					System.GetCurrentScene():Add( bullet )
				end	
			--end
			
			self.GunCooldown = self.GunCooldown + cooldownTime
			--[[
			if( soundName and self.GunSoundCooldown <= 0 ) then
				System.Audio.PlaySound( soundName, 1, self.Engine )
				self.GunSoundCooldown = .1
			end
			--]]
		end
	--]=]
	end
end

-------------------------------------------------------------------------------
System.Interior.RegisterTileset
{
	Name		= "Bridge",
	GridWidth	= 2,
	GridHeight	= 3,
	FilePrefix	= "TilesetBridge",
	--FilePrefix	= "bedroom_livingroom",
	--FilePrefix	= "TubeTiles",
	-- Decorations
	Decorations =
	{
		--"LightCeiling" = "Light",			
	},
}

-------------------------------------------------------------------------------
System.Interior.RegisterTileset
{
	Name		= "Bathroom",
	GridWidth	= 2,
	GridHeight	= 3,
	FilePrefix	= "TilesetBathroom",
}

-------------------------------------------------------------------------------
System.Interior.RegisterTileset
{
	Name		= "Living Area",
	GridWidth	= 2,
	GridHeight	= 3,
	FilePrefix	= "TilesetLivingArea",
}

-------------------------------------------------------------------------------
System.Interior.RegisterTileset
{
	Name		= "Engineering",
	GridWidth	= 2,
	GridHeight	= 3,
	FilePrefix	= "TilesetEngineering",
}

-------------------------------------------------------------------------------
System.Interior.RegisterTileset
{
	Name		= "Corridor",
	GridWidth	= 2,
	GridHeight	= 3,
	FilePrefix	= "TilesetCorridor",
}

-------------------------------------------------------------------------------
System.Interior.RegisterTileset
{
	Name		= "Holoscreen",
	GridWidth	= 2,
	GridHeight	= 3,
	FilePrefix	= "TilesetHoloscreen",
}
