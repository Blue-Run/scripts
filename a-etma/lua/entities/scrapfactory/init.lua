

AddCSLuaFile("shared.lua")
include("shared.lua")
/*
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
	self.NumScrapMetalRequired = 1 -- Change this to set the number of scrap metal required
	self.TimePerScrapMetal = 2 -- Change this to set the time required to process each scrap metal
	self.NextSpawnTime = 0 -- Change this to set the time interval between each spawn
	self.SpawnChanceTable = { -- Change this table to set the spawn chance and entity to spawn
		{spawnChance = 5, entityClass = "battery"},
		{spawnChance = 3, entityClass = "iron"},
		{spawnChance = 2, entityClass = "wood"}
	}
	self.MoneyPerScrapMetal = 5 -- Change this to set the amount of money deducted per scrap metal
	self.Money = 0
end
*/
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
	self.NumScrapMetalRequired = 1 -- Change this to set the number of scrap metal required
	self.TimePerScrapMetal = 2 -- Change this to set the time required to process each scrap metal
	self.NextSpawnTime = 0 -- Change this to set the time interval between each spawn
	self.SpawnChanceTable = { -- Change this table to set the spawn chance and entity to spawn
		{spawnChance = 80, entityClass = "prop_physics"},
		--{spawnChance = 20, entityClass = "prop_ragdoll"},
	}
	self.MoneyPerScrapMetal = 5 -- Change this to set the amount of money deducted per scrap metal
	self.Money = 0
	
	-- Initialize self.EntityTable here
	self.EntityTable = {
		--{ EntityName = "battery"},
		{ EntityName = "plastic" },
		{ EntityName = "iron" },
		{ EntityName = "wood" },
	}
end

function ENT:OnTakeDamage(dmg)
	self:Remove()
end

function ENT:StartTouch(ent)
	if ent:GetClass() == "scrapmetal" and self.IsBaking == false then
		ent:Remove()
		self.NumScrapMetal = (self.NumScrapMetal or 0) + 1
		if self.NumScrapMetal >= self.NumScrapMetalRequired then
			self.IsBaking = true
			self.DoneBaking = CurTime() + math.random(25, 125)
			self.NumScrapMetal = 0
		end
	end
end

function ENT:Use(activator, caller)
	if activator:IsPlayer() and self.IsBaking == true and self.NextSpawnTime <= CurTime() then
		activator:addMoney(-self.MoneyPerScrapMetal)
		self.Money = self.Money + self.MoneyPerScrapMetal
		self.NextSpawnTime = CurTime() + self.TimePerScrapMetal
		self:SpawnRandomEntity()
	end
end

function ENT:SpawnRandomEntity()
	local totalChance = 0
	for _, spawnData in ipairs(self.SpawnChanceTable) do
		totalChance = totalChance + spawnData.spawnChance
	end

	local randomChance = math.random(1, totalChance)
	local cumulativeChance = 0
	for _, spawnData in ipairs(self.SpawnChanceTable) do
		cumulativeChance = cumulativeChance + spawnData.spawnChance
		if randomChance <= cumulativeChance then
			local newEntity = ents.Create(spawnData.entityClass)
			newEntity:SetPos(self:GetPos() + Vector(0, 0, 30))
			newEntity:Spawn()
			break
		end
	end
end

function ENT:Think()
	if self.IsBaking == true then
		self:EmitSound("ambient/machines/machine2.wav", 50, math.random(65, 110))
		if math.random(1, 5) == 1 then
			local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos() + Vector(math.random(0, 10), math.random(-2.5, 10), 30))
			util.Effect("cball_explode", effectdata)
		end
		if self.DoneBaking <= CurTime() then
			self.IsBaking = false
			local randomEntity = table.Random(self.EntityTable)
			if randomEntity then
				local ent = ents.Create(randomEntity.EntityName)
				ent:SetPos(self:GetPos() + Vector(0, 0, 30))
				ent:SetAngles(self:GetAngles())
				ent:Spawn()
				if randomEntity.OnSpawn then
					randomEntity.OnSpawn(ent)
				end
			end
			self.DoneBaking = 0
			--self.Money = self.Money + 50 -- add money for producing wine
		end
	else
		self:StopSound("ambient/machines/machine2.wav")
	end
end
