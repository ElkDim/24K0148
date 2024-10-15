using HorizonSideRobots
function ugol!(robot)
    while !isborder(robot,West)
        move!(robot,West)
    end
    while !isborder(robot,Sud)
        move!(robot,Sud)
    end
end
function inverse(side)
    return HorizonSide((Int(side)+2)%4)
end    
function pokras!(robot)
    ugol!(robot)
    putmarker!(robot)
    side = (Ost,West)
    for s in side
        while !isborder(robot,Nord)
            while !isborder(robot,s)
                move!(robot,s)
                putmarker!(robot)
                if isborder(robot,s)
                    move!(robot,Nord)
                    putmarker!(robot)
                    s = inverse(s)
                end
            end
        end
    end
end