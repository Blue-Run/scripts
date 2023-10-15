AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()

	self:SetModel("models/props/de_inferno/crate_fruit_break_p1.mdl")
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
	self.numGrapesRequired = 3 -- Change this to set the number of grapes required
	self.timePerGrape = 2 -- Change this to set the time required to crush each grape
end


function ENT:OnTakeDamage(dmg)
	self:Remove()
end

-------------------------
/*
now could you make this start touch so whereever a grape touches it a spark apears 

function ENT:StartTouch(ent)
	if ent:GetClass() == "grapes" and self.IsBakeing == false then
		ent:Remove()
		self.NumGrapes = (self.NumGrapes or 0) + 1
		if self.NumGrapes >= self.numGrapesRequired then
			self.IsBakeing = true
			self.DoneBakeing = CurTime() + math.random(5,10)--math.random(60, 120)
		end
	end
end
*/

function ENT:StartTouch(ent)
	if ent:GetClass() == "grapes" and self.IsBakeing == false then
		ent:Remove()
		self.NumGrapes = (self.NumGrapes or 0) + 1
		if self.NumGrapes >= self.numGrapesRequired then
			self.IsBakeing = true
			self.DoneBakeing = CurTime() + math.random(35,65)--math.random(60, 120)
		end
		
		-- Create spark effect
		local effectdata = EffectData()
		effectdata:SetOrigin(ent:GetPos())
		effectdata:SetMagnitude(1)
		util.Effect("cball_explode", effectdata)
	end
end


function ENT:Think()
	if self.IsBakeing == true then
		self:SetColor(Color(91, 0, 195))
	else
		self:SetColor(Color(235, 235, 235))
	end
	if self.IsBakeing == true then
		if self.DoneBakeing <= CurTime() then
			self.IsBakeing = false
			self.NumGrapes = 0
			local fermented_grapes = ents.Create("fermented_grapes")
			fermented_grapes:SetPos(self:GetPos() + Vector(0, 0, 0))
			fermented_grapes:Spawn()
			self:Remove() -- remove the current entity
		end
	end
end
