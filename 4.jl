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
            n = 0
            while !isborder(robot,s)
                move!(robot,s)
                n += 1
                if n%2 == 0
                    putmarker!(robot)
                end
                if isborder(robot,s)
                    move!(robot,Nord)
                    n += 1
                    s = inverse(s)
                    putmarker!(r)
                end
            end
        end
    end
end