if SERVER then
    AddCSLuaFile("cl_init.lua")
    AddCSLuaFile("shared.lua")
    include("shared.lua")
    util.AddNetworkString("OpenNPCBaseMenu")

    function ENT:Initialize()
        self:SetModel("models/gman_high.mdl")
        self:SetHullType(HULL_HUMAN)
        self:SetHullSizeNormal()
        self:SetNPCState(NPC_STATE_SCRIPT)
        self:SetSolid(SOLID_BBOX)
        self:CapabilitiesAdd(CAP_ANIMATEDFACE, CAP_TURN_HEAD)
        self:SetUseType(SIMPLE_USE)
        self:DropToFloor()
        self:SetMaxYawSpeed(90)
        self:PhysWake()
    end

    function ENT:Use(activator, caller, useType, value)
        if caller:IsPlayer() then
            net.Start("OpenNPCBaseMenu")
            net.Send(caller)
        end
    end
end
