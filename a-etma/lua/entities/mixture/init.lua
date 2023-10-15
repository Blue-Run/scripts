AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()

	self:SetModel("models/props_junk/garbage_bag001a.mdl")
	self:SetColor(Color(173, 113, 39))
	self:SetMaterial("models/debug/debugwhite")
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
