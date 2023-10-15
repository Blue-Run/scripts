-- Put your Lua here
-- Put your Lua here
--you forgot to make the oilbarrel spawn ajustable why did you remove the par its important
-- Put your Lua here

AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.IsOilRig = true

ENT.Battery = 0 -- Starting battery level
ENT.BatteryDrainRate = math.random(3,18) -- Battery drain rate per second
ENT.NotifyThreshold = 15 -- Battery level threshold for notification
ENT.BarrelSpawnRate = 35--math.random(45,144) -- Spawn rate in seconds

function ENT:Initialize()
    self:SetModel("models/props_wasteland/horizontalcoolingtank04.mdl")
  --  self:SetMaterial("models/shiny")
    self:SetColor(Color(255, 255, 255, 255))
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:Think()
    if self.Battery > 0 then
        local tr = util.TraceLine({
            start = self:GetPos() + Vector(0, 0, 5),
            endpos = self:GetPos() + Vector(0, 0, -100),
            mask = MASK_WATER
        })

        if not tr.Hit or not tr.MatType == MAT_WATER then
            -- Entity is not in or on top of water
            self:SetColor(Color(255, 255, 255, 255))
            return
        else
            -- Entity is in or on top of water
            self:SetColor(Color(235, 255, 239, 255))
        end

        self.Battery = math.max(self.Battery - self.BatteryDrainRate * FrameTime(), 0)

        if self.Battery < self.NotifyThreshold then
            self:SetColor(Color(255, 0, 0, 255)) -- Change color to red
            self:EmitSound("ambient/machines/machine2.wav", 50, math.Round(65, 110)) -- Emit sound effect
            if math.random(1, 5) == 1 then
                local effectdata = EffectData()
                effectdata:SetOrigin(self:GetPos() + Vector(math.random(0, 10), math.random(-2.5, 10), 30))
                util.Effect("cball_explode", effectdata) -- Play particle effect
            end
            self.CanSpawnBarrels = false -- Stop spawning of oil barrel entities
        end

        if self.Battery <= 0 then
            self:SetColor(Color(255, 0, 0, 255)) -- Change color to red
           -- self:Remove()
            return
        end
    else
        self.CanSpawnBarrels = false -- Stop spawning of oil barrel entities
    end

    -- Spawn oil barrel at set rate if can spawn barrels is true
    if CurTime() >= (self.NextBarrelSpawn or 0) and self.CanSpawnBarrels then

        local oilbarrel = ents.Create("oilbarrel")
        oilbarrel:SetPos(self:GetPos() + Vector(0, 0, 52))
        oilbarrel:Spawn()
        self.NextBarrelSpawn = CurTime() + self.BarrelSpawnRate
    end
end

function ENT:StartTouch(ent)
    if ent:GetClass() == "oilbattery" and self.Battery < 100 then
        ent:Remove()
        self.Battery = 100
        self.CanSpawnBarrels = true
    end
end

/*
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.IsOilRig = true

ENT.Battery = 0 -- Starting battery level
ENT.BatteryDrainRate = 100 -- Battery drain rate per second
ENT.NotifyThreshold = 15 -- Battery level threshold for notification
ENT.BarrelSpawnRate = 35--math.random(45,144) -- Spawn rate in seconds

function ENT:Initialize()
    self:SetModel("models/props_wasteland/horizontalcoolingtank04.mdl")
  --  self:SetMaterial("models/shiny")
    self:SetColor(Color(255, 255, 255, 255))
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:Think()
    if self.Battery > 0 then
        local tr = util.TraceLine({
            start = self:GetPos() + Vector(0, 0, 5),
            endpos = self:GetPos() + Vector(0, 0, -100),
            mask = MASK_WATER
        })

        if not tr.Hit or not tr.MatType == MAT_WATER then
            -- Entity is not in or on top of water
            self:SetColor(Color(255, 255, 255, 255))
            return
        else
            -- Entity is in or on top of water
            self:SetColor(Color(235, 255, 239, 255))
        end

        self.Battery = math.max(self.Battery - self.BatteryDrainRate * FrameTime(), 0)

        if self.Battery < self.NotifyThreshold then
            self:SetColor(Color(255, 0, 0, 255)) -- Change color to red
            self:EmitSound("ambient/machines/machine2.wav", 50, math.Round(65, 110)) -- Emit sound effect
            if math.random(1, 5) == 1 then
                local effectdata = EffectData()
                effectdata:SetOrigin(self:GetPos() + Vector(math.random(0, 10), math.random(-2.5, 10), 30))
                util.Effect("cball_explode", effectdata) -- Play particle effect
            end
        end

        if self.Battery <= 0 then
            self:SetColor(Color(255, 0, 0, 255)) -- Change color to red
            self:Remove()
            local oilbarrel = ents.Create("oilbarrel")
            oilbarrel:SetPos(self:GetPos() + Vector(0, 0, 52))
            oilbarrel:Spawn()
            return
        end
    end

    -- Spawn oil barrel at set rate
    if CurTime() >= (self.NextBarrelSpawn or 0) then
        if self.Battery == 0 then return end
        self.NextBarrelSpawn = CurTime() + self.BarrelSpawnRate
        local oilbarrel = ents.Create("oilbarrel")
        oilbarrel:SetPos(self:GetPos() + Vector(0, 0, 52))
        oilbarrel:Spawn()
    end
end


/*

still isnt changing colors when detecting water maybe waterlevle local isnt working properly

https://wiki.facepunch.com/gmod/util.PointContents
function ENT:Think()
    if self.Battery > 0 then
        local waterLevel = util.PointContents(self:GetPos() + Vector(0,0,5))

        if waterLevel ~= CONTENTS_WATER then
        -- Entity is not in or on top of water
        self:SetColor(Color(255, 255, 255, 255))
        return
    else
        -- Entity is in or on top of water
        self:SetColor(Color(0, 255, 0, 255))
    end
        self.Battery = math.max(self.Battery - self.BatteryDrainRate * FrameTime(), 0)

        if self.Battery < self.NotifyThreshold then
            DarkRP.notify(self:Getowning_ent(), 1, 5, "Oil rig battery level is low!")
        end

        if self.Battery <= 0 then
            self:Remove()
            local oilbarrel = ents.Create("oilbarrel")
            oilbarrel:SetPos(self:GetPos() + Vector(0, 0, 10))
            oilbarrel:Spawn()
            return
        end

        -- Spawn oil barrel at set rate
        if CurTime() >= (self.NextBarrelSpawn or 0) then
            self.NextBarrelSpawn = CurTime() + self.BarrelSpawnRate
            local oilbarrel = ents.Create("oilbarrel")
            oilbarrel:SetPos(self:GetPos() + Vector(0, 0, 10))
            oilbarrel:Spawn()
        end
    end
end
*/

/*
function ENT:Initialize()
    self:SetModel("models/props_wasteland/horizontalcoolingtank04.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()
    if (phys:IsValid()) then
        phys:Wake()
    end

    self.IsDrilling = false
    self.OilBarrelsProduced = 0
    self.DrillRate = 2 -- change this to set the rate at which oil barrels are produced (in seconds)
    self.BatteryDrainRate = 1 -- change this to set the rate at which the battery is drained (in seconds)
    self.BatteryCapacity = 100 -- change this to set the maximum battery capacity
    self.Battery = self.BatteryCapacity -- initialize the battery at full capacity
end

function ENT:OnRemove()
    self:StopSound("ambient/levels/citadel/field_loop1.wav")
end


function ENT:Think()
    if self.IsDrilling and self.Battery > 0 and self:InWater() then
        self.Battery = self.Battery - self.BatteryDrainRate
        self.NextProductionTime = CurTime() + (1 / self.ProductionRate)
        local oilbarrel = ents.Create(self.OilBarrel)
        oilbarrel:SetPos(self:GetPos() + Vector(0, 0, 50))
        oilbarrel:Spawn()
    end

    if self.IsProducing and self.NextProductionTime <= CurTime() then
        local oilbarrel = ents.Create(self.OilBarrel)
        oilbarrel:SetPos(self:GetPos() + Vector(0, 0, 50))
        oilbarrel:Spawn()
        self.NextProductionTime = CurTime() + (1 / self.ProductionRate)
    end

    self:NextThink(CurTime() + 1)
    return true
end

function ENT:Use(activator, caller)
    if self.Battery >= self.BatteryDrainRate and not self.IsDrilling and not self.IsProducing and self:InWater() then
        local batteries = ents.FindByClass(self.BatteryClass)
        local num_batteries = 0

        for _, battery in pairs(batteries) do
            if IsValid(battery) then
                battery:Remove()
                num_batteries = num_batteries + 1
                if num_batteries >= self.NumBatteriesRequired then
                    break
                end
            end
        end

        if num_batteries >= self.NumBatteriesRequired then
            self.IsDrilling = true
            self:EmitSound("ambient/levels/citadel/field_loop1.wav", 50, math.random(90, 110))
            self.Battery = self.Battery - self.BatteryDrainRate
        end
    end
end

function ENT:StartTouch(ent)
    if ent:GetClass() == self.BatteryClass and self.IsDrilling == false then
        ent:Remove()
        self.Battery = self.Battery + self.BatteryDrainRate
        if self.Battery >= self.BatteryDrainRate then
            self.IsProducing = true
        end
    end
end 