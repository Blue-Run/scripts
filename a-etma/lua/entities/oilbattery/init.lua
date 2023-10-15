AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()

	self:SetModel("models/items/car_battery01.mdl")
	--self:SetColor(Color(59, 171, 83))
	--self:SetMaterial("phoenix_storms/gear")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	if (IsValid()) then
		
		phys:Wake()

	end
end


----damage------
function ENT:OnTakeDamage(dmg)
			self:Remove()
end
----------------
