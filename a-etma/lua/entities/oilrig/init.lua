AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.IsOilRig = true
ENT.Battery = 0 -- Starting battery level
ENT.BatteryDrainRate = math.random(3, 18) -- Battery drain rate per second
ENT.NotifyThreshold = 15 -- Battery level threshold for notification
ENT.BarrelSpawnRate = 35 --math.random(45,144) -- Spawn rate in seconds

function ENT:Initialize()
    self:SetModel("models/props_wasteland/horizontalcoolingtank04.mdl")
    --  self:SetMaterial("models/shiny")
    self:SetColor(Color(255, 255, 255, 255))
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then phys:Wake() end
end

function ENT:Think()
    if self.Battery > 0 then
        local tr = util.TraceLine(
            {
                start = self:GetPos() + Vector(0, 0, 5),
                endpos = self:GetPos() + Vector(0, 0, -100),
                mask = MASK_WATER
            }
        )

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
