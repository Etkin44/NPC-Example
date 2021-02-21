AddCSLuaFile("cl_init.lua") --Include draw and menu
AddCSLuaFile("shared.lua") --Include entity information to server
include("shared.lua") --Include entity information
util.AddNetworkString("OpenNPCBaseMenu") --Add a network

function ENT:Initialize() --Entity Features
    self:SetModel("models/gman_high.mdl") --Model
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
    if caller:IsPlayer() then --if caller is player,start network.
        net.Start("OpenNPCBaseMenu")
        net.Send(caller)
    end
end
