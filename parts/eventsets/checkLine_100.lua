return{
    dropPiece=function(P)
        if P.stat.row>=100 then
            P:win('finish')
        end
    end
}