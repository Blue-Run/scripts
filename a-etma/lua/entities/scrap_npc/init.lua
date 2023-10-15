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


function ENT:AcceptInput( inn, a, c )	
	if inn == "Use" && c:IsPlayer() && c:IsValid() then
		if c.numberOfScrap != nil && c.numberOfScrap > 0 then
			net.Start("notiNPC")
			net.WriteString("You sold "..c.numberOfScrap.." Scrap, and earned $"..c.numberOfScrap*PricePerScrap)
			net.WriteString("buttons/button14.wav")
			net.WriteInt(0, 3)
			net.Send(c)
			self.timeStamp = true
			c:addMoney(c.numberOfScrap*PricePerScrap) -- Remove this line if addon is used for anything else then DarkRP or something deriverted of that.
			print("[Scrap] "..c:Nick().." just sold their Scrap".."  And, Earned $"..c.numberOfScrap*PricePerScrap)
			timer.Simple(0.15,function() self.timeStamp = false end)
			c.numberOfScrap = 0
		else
			if(self.timeStamp == false) then
			net.Start("notiNPC")
			net.WriteString("You don't have any Scrap.")
			net.WriteString("buttons/button10.wav")
			net.WriteInt(1, 3)
			net.Send(c)
			self.timeStamp = true
			timer.Simple(0.15,function() self.timeStamp = false end)
			end
		end
	end
end

