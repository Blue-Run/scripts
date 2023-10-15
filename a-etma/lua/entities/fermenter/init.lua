AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()

	self:SetModel("models/props_wasteland/laundry_washer003.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	self.IsBaking = false
	self.DoneBaking = 0
	self.NumGrapesRequired = 1 -- Change this to set the number of grapes required
	self.TimePerGrape = 2 -- Change this to set the time required to crush each grape
	self.SugarInterval = 3 -- Change this to set the interval in seconds for adding sugar
	self.SugarAmount = 10 -- Change this to set the amount of sugar added
	self.MoneyPerSugar = 5 -- Change this to set the amount of money deducted per added sugar
	self.NextSugarAddTime = CurTime() + self.SugarInterval
	self.Money = 0
end

function ENT:OnTakeDamage(dmg)
	self:Remove()
end

function ENT:StartTouch(ent)
	if ent:GetClass() == "fermented_grapes" and self.IsBaking == false then
		ent:Remove()
		self.NumGrapes = (self.NumGrapes or 0) + 1
		if self.NumGrapes >= self.NumGrapesRequired then
			self.IsBaking = true
			self.DoneBaking = CurTime() + math.random(5, 25) --math.random(60, 120)
			self.NumGrapes = 0
		end
	end
end

function ENT:Use(activator, caller)
	if activator:IsPlayer() and self.IsBaking == true and self.NextSugarAddTime <= CurTime() then
		activator:addMoney(-self.MoneyPerSugar)
		self.Money = self.Money + self.MoneyPerSugar
		self.NextSugarAddTime = CurTime() + self.SugarInterval
	end
end


function ENT:Think()
	if self.IsBaking == true then
		self:SetColor(Color(200, 200, 200))
		self:EmitSound("ambient/machines/machine2.wav", 50, math.Round(65, 110))
		if math.random(1, 5) == 1 then
			local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos() + Vector(math.random(0, 10), math.random(-2.5, 10), 30))
			util.Effect("cball_explode", effectdata)
		end
	else
		self:SetColor(Color(235, 235, 235))
		self:StopSound("ambient/machines/machine2.wav")
	end
	if self.IsBaking == true then
		if self.DoneBaking <= CurTime() then
			self.IsBaking = false
			local wine = ents.Create("wine")
			wine:SetPos(self:GetPos() + Vector(0, 0, 30))
			wine:Spawn()
			self.DoneBaking = 0
			--self.Money = self.Money + 50 -- add money for producing wine
		end
	end
end

/*
function ENT:Think()
	if self.IsBaking == true then
		self:SetColor(Color(91, 0, 195))
	else
		self:SetColor(Color(235, 235, 235))
	end
	if self.IsBaking == true then
		if self.DoneBaking <= CurTime() then
			self.IsBaking = false
			local wine = ents.Create("wine")
			wine:SetPos(self:GetPos() + Vector(0, 0, 40))
			wine:Spawn()
			self.DoneBaking = 0
			--self.Money = self.Money + 50 -- add money for producing wine
		end
	end
end
