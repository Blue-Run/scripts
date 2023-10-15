AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()

	self:SetModel("models/revzin/wineglass2.mdl")
	self:SetColor(Color(216,106,106))
	--self:SetMaterial("models/debug/debugwhite")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	for k,v in pairs(player.GetAll()) do
		if v.numberOfWine == nil then
			v.numberOfWine = 0
			print("[Wine-Mod] No storagevar for player: " .. v:Nick() .. ", making it.")
		end
	end
end

function ENT:Use(a, c)
	if IsValid( c ) and c:IsPlayer() then
		if c.numberOfWine != nil then
			c.numberOfWine = c.numberOfWine + 1
		else
			c.numberOfWine = 1
		end
		print("[Wine-Mod]"..c:Nick() .. " now has " .. c.numberOfWine .. " Wine in their inv.")
		self:Remove()
	end
end

function ENT:OnTakeDamage()
	self:Remove()
end
