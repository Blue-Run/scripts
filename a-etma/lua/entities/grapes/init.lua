AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()

	self:SetModel("models/props/cs_italy/orange.mdl")
	self:SetColor(Color(149, 0, 179))
	self:SetMaterial("phoenix_storms/gear")
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
