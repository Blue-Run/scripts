AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()

	self:SetModel("models/props_c17/oildrum001.mdl")
	self:SetColor(Color(137,100,0))
	self:SetMaterial("phoenix_storms/dome")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	for k,v in pairs(player.GetAll()) do
		if v.numberOfOil == nil then
			v.numberOfOil = 0
			print("[Oil-Mod] No storagevar for player: " .. v:Nick() .. ", making it.")
		end
	end
end

function ENT:Use(a, c)
	if IsValid( c ) and c:IsPlayer() then
		if c.numberOfOil != nil then
			c.numberOfOil = c.numberOfOil + 1
		else
			c.numberOfOil = 1
		end
		print("[Oil-Mod]"..c:Nick() .. " now has " .. c.numberOfOil .. " Oil in their inv.")
		self:Remove()
	end
end

function ENT:OnTakeDamage()
	self:Remove()
end
