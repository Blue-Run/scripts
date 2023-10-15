include("shared.lua")
include("config.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
util.AddNetworkString("notiNPC")
function ENT:Initialize( )
	self:SetModel("models/Humans/Group03/male_06.mdl");
	self:SetHullType(HULL_HUMAN);
	self:SetHullSizeNormal();
	self:SetNPCState( NPC_STATE_SCRIPT )
	self:SetSolid(  SOLID_BBOX )
	self:CapabilitiesAdd( CAP_ANIMATEDFACE )
	self:CapabilitiesAdd( CAP_TURN_HEAD )
	self:SetSolid(SOLID_BBOX);
	self:SetUseType(SIMPLE_USE);
	self:SetBloodColor(BLOOD_COLOR_RED);
	local seq = self:LookupSequence("lineidle02")
	self:ResetSequence(seq)
	self:SetSequence(seq)
	self:DropToFloor()
end

function ENT:AcceptInput(inn, activator, caller)
    if inn == "Use" and caller:IsPlayer() and caller.numberOfOil and caller.numberOfOil > 0 then
        net.Start("notiNPC")
        net.WriteString("You sold " .. caller.numberOfOil .. " Oil, and earned $" .. (caller.numberOfOil * PricePerOil))
        net.WriteString("buttons/button14.wav")
        net.WriteInt(0, 3)
        net.Send(caller)

        self.timeStamp = true
        caller:addMoney(caller.numberOfOil * PricePerOil)
        print("[Oil] " .. caller:Nick() .. " just sold their Oil" .. "  And, Earned $" .. (caller.numberOfOil * PricePerOil))
        timer.Simple(0.15, function() self.timeStamp = false end)

        caller.numberOfOil = 0
    elseif inn == "Use" and caller:IsPlayer() then
        if not self.timeStamp then
            net.Start("notiNPC")
            net.WriteString("You don't have any Oil.")
            net.WriteString("buttons/button10.wav")
            net.WriteInt(1, 3)
            net.Send(caller)

            self.timeStamp = true
            timer.Simple(0.15, function() self.timeStamp = false end)
        end
    end
end
