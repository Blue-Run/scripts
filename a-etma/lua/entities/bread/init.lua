AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()

	self:SetModel("models/bread/bread.mdl")
	--self:SetColor(Color(100,1000,1000))
	--self:SetMaterial("models/debug/debugwhite")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	for k,v in pairs(player.GetAll()) do
		if v.numberOfBread == nil then
			v.numberOfBread = 0
			print("[Bread-Mod] No storagevar for player: " .. v:Nick() .. ", making it.")
		end
	end
end

function ENT:Use(a, c)
	if IsValid( c ) and c:IsPlayer() then
		if c.numberOfBread != nil then
			c.numberOfBread = c.numberOfBread + 1
		else
			c.numberOfBread = 1
		end
		print("[Bread-Mod]"..c:Nick() .. " now has " .. c.numberOfBread .. " Bread in their inv.")
		self:Remove()
	end
end

function ENT:OnTakeDamage()
	self:Remove()
end
