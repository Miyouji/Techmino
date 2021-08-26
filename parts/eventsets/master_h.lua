local death_lock={12,11,10,9,8, 7,7,7,7,6}
local death_wait={10,9, 8, 7,6, 6,6,5,5,4}
local death_fall={10,9, 8, 7,6, 6,5,5,4,4}

return{
    dropPiece=function(P)
        local D=P.modeData

        local c=#P.clearedRow
        if c==0 and D.pt%100==99 then return end
        local s=c<3 and c+1 or c==3 and 5 or 7
        if P.combo>7 then s=s+2
        elseif P.combo>3 then s=s+1
        end
        D.pt=D.pt+s

        if D.pt%100==99 then
            SFX.play('blip_1')
        elseif D.pt>=D.target then--Level up!
            s=D.target/100
            local E=P.gameEnv
            E.lock=death_lock[s]
            E.wait=death_wait[s]
            E.fall=death_fall[s]
            if s==2 then
                E.das=5
                BG.set('rainbow')
            elseif s==4 then
                E.das=4
                BG.set('rainbow2')
            elseif s==5 then
                if P.stat.frame>183*60 then
                    D.pt=500
                    P:win('finish')
                    return
                else
                    E.bone=true
                    P.gameEnv.freshLimit=10
                    BG.set('glow')
                    BGM.play('secret7th remix')
                end
            elseif s==6 then
                E.das=3
                BG.set('lightning')
            elseif s==7 then
                E.bone=true
            elseif s==10 then
                D.pt=1000
                P:win('finish')
                return
            end
            D.target=D.target+100
            P:_showText(text.stage:gsub("$1",s),0,-120,80,'beat')
            SFX.play('reach')
        end
    end,
    task=function(P)
        P:set20G(true)
        P.lockDelay=death_lock[1]
        P.gameEnv.lock=death_lock[1]
        P.gameEnv.wait=death_wait[1]
        P.gameEnv.fall=death_fall[1]

        P.modeData.pt=0
        P.modeData.target=100
    end,
}