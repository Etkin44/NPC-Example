if CLIENT then
    include("shared.lua")

    surface.CreateFont("NPC_F1", {
        font = "Arial",
        size = 35,
        antialias = true,
    })

    surface.CreateFont("NPC_F2", {
        font = "Arial",
        size = 16,
        antialias = true,
    })

    local function OpenNPCBaseMenuFunction()
        local NPCBaseMenu = vgui.Create("DFrame")
        NPCBaseMenu:SetSize(ScrW() / 4, ScrH() / 4)
        NPCBaseMenu:Center()
        NPCBaseMenu:SetDraggable(false)
        NPCBaseMenu:SetBackgroundBlur(5)
        NPCBaseMenu:MakePopup()
        NPCBaseMenu:SetTitle("NPC Example Menu")
        local BGPanel = vgui.Create("DPanel", NPCBaseMenu)
        BGPanel:Dock(FILL)

        BGPanel.Paint = function(self, w, h)
            surface.SetDrawColor(0, 0, 0, 200)
            surface.DrawRect(0, 0, w, h)
        end

        local DModelPanel = vgui.Create("DModelPanel", NPCBaseMenu)
        DModelPanel:SetSize(200, 200)
        DModelPanel:Center()
        DModelPanel:SetModel("models/gman_high.mdl")
        DModelPanel:SetAnimated(true)
    end

    function ENT:Draw()
        self:DrawModel()
        local ang = LocalPlayer():EyeAngles()
        ang = Angle(0, ang.y, 0)
        ang:RotateAroundAxis(ang:Forward(), 180)
        ang:RotateAroundAxis(ang:Right(), 90)
        ang:RotateAroundAxis(ang:Up(), 90)
        cam.Start3D2D(self:WorldSpaceCenter(), ang, 0.1)
        draw.RoundedBox(0, -125, -430, 250, 40, Color(0, 0, 0, 200))

        if LocalPlayer():GetEyeTrace().Entity:GetClass() == "npc" then
            draw.SimpleText("NPC Example", "NPC_F1", -90, -430, Color(255, 255, 255))
        else
            draw.SimpleText("NPC Example", "NPC_F1", -90, -430, Color(100, 100, 100))
        end

        cam.End3D2D()
    end

    net.Receive("OpenNPCBaseMenu", function(len, ply)
        local caller = net.ReadEntity()
        if not caller:IsPlayer() then return end
        OpenNPCBaseMenuFunction()
    end)
end