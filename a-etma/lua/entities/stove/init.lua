AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()

	self:SetModel("models/props/cs_militia/stove01.mdl")
	--self:SetColor(Color(100,100,100))
	--self:SetMaterial("models/debug/debugwhite")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	self.IsBakeing = false
	self.DoneBakeing = 0
end


function ENT:OnTakeDamage(dmg)
			self:Remove()
end

-------------------------

function ENT:StartTouch(ent)
	if ent:GetClass() == "mixture" and self.IsBakeing == false then
	ent:Remove()
		self.IsBakeing = true
		self.DoneBakeing = CurTime() + math.random(60,120)
	end	
end

function ENT:Think()
	if self.IsBakeing == true then
		self:SetColor(Color(255,100,100))
	else
		self:SetColor(Color(235,235,235))
	end
	if self.IsBakeing == true then
		if self.DoneBakeing <= CurTime() then
			self.IsBakeing = false
			--done--


			local bread = ents.Create("bread")
			bread:SetPos(self:GetPos() + Vector(0,0,25))
			bread:Spawn()
		end
	end
end
