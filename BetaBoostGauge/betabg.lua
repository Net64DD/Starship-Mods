sBoostGaugeArrow = {
    Asset.Register("assets/hud/sBoostGaugeArrow0"),
    Asset.Register("assets/hud/sBoostGaugeArrow1"),
    Asset.Register("assets/hud/sBoostGaugeArrow2"),
    Asset.Register("assets/hud/sBoostGaugeArrow3"),
    Asset.Register("assets/hud/sBoostGaugeArrow4"),
    Asset.Register("assets/hud/sBoostGaugeArrow5"),
    Asset.Register("assets/hud/sBoostGaugeArrow6"),
    Asset.Register("assets/hud/sBoostGaugeArrow7"),
    Asset.Register("assets/hud/sBoostGaugeArrow8"),
}

sColors = {
    ImVec4.new(0.24, 0.31, 0.71, 1.0)
}

function OnBoostGaugeDraw(ev)
    local restore = CVarGetInteger("gRestoreBetaBoostGauge", 0) == 1

    if not restore then
        return
    end

    ev.event.cancelled = true

    local x = 70
    local y = 30
    local step = math.floor(math.min(8, (Game.gPlayer().boostMeter / 90.0) * 9))

    RCP_AutoSetupDL(SetupDL.SETUPDL_76_POINT)
    gDPSetPrimColor(0, 0, 255, 255, 255, 255)
    Lib_TextureRect_CI8(gRefMasterDisp(), Assets.D_1012290:Load8(), Assets.D_10126B0:Load16(), 48, 22, OTRGetRectDimensionFromRightEdgeOverride(ScreenSize.WIDTH - x), y, 1.0, 1.0)
    Lib_TextureRect_CI8(gRefMasterDisp(), Assets.D_10126F0:Load8(), Assets.D_1012750:Load16(), 24, 4, OTRGetRectDimensionFromRightEdgeOverride(ScreenSize.WIDTH - (x - 9)), y + 3, 1.0, 1.0)
    Lib_TextureRect_RGBA16(gRefMasterDisp(), sBoostGaugeArrow[step + 1]:Load16(), 32, 32, OTRGetRectDimensionFromRightEdgeOverride(ScreenSize.WIDTH - (x - 6)), y - 1, 0.9, 0.9)
end

function OnBombCounterDraw(ev)
    local restore = CVarGetInteger("gRestoreBetaBoostGauge", 0) == 1

    if not restore then
        return
    end

    ev.event.cancelled = true
    HUD_BombCounter_Draw(253.0, 18.0)
end

function OnLivesCounterDraw(ev)
    local restore = CVarGetInteger("gRestoreBetaBoostGauge", 0) == 1

    if not restore then
        return
    end

    ev.event.cancelled = true
    HUD_LivesCount2_Draw(258.0, ScreenSize.HEIGHT - 20, Game.gLifeCount(Game.gPlayerNum()))
end

function OnMenubar(ev)
    if UIWidgets.BeginMenu("Enhancements", sColors[1]) then
        if UIWidgets.BeginMenu("Restoration", sColors[1]) then
            UIWidgets.CVarCheckbox("Beta: Restore beta boost/brake gauge", "gRestoreBetaBoostGauge", UIWidgets.DefaultCheckboxOptions("Restores the beta boost gauge that was seen in some beta footage"))
            UIWidgets.EndMenu()
        end
        UIWidgets.EndMenu()
    end
end

RegisterListener(Events.EngineRenderMenubarEvent, OnMenubar, EventPriority.NORMAL)
RegisterListener(Events.DrawBoostGaugeHUDEvent, OnBoostGaugeDraw, EventPriority.NORMAL)
RegisterListener(Events.DrawBombCounterHUDEvent, OnBombCounterDraw, EventPriority.NORMAL)
RegisterListener(Events.DrawLivesCounterHUDEvent, OnLivesCounterDraw, EventPriority.NORMAL)