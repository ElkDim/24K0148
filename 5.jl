using HorizonSideRobots
function inverse(side)
    return HorizonSide((Int(side)+2)%4)
end
function ugol!(robot)
    while !isborder(robot,West)
        move!(robot,West)
    end
    while !isborder(robot,Sud)
        move!(robot,Sud)
    end
    while !isborder(robot,West)
        move!(robot,West)
    end
end
function Ost_perimetr!(robot)
    ugol!(robot)
    putmarker!(robot)
    side = (Ost,West)
    for s in side
        while !isborder(robot,Nord)
            while !isborder(robot,s)
                move!(robot,s)
            end
            if isborder(robot,s)
                putmarker!(robot)
                move!(robot,Nord)
                putmarker!(robot)
                s = inverse(s)
            end
        end
    end
end
function West_perimetr!(robot)
    ugol!(robot)
    putmarker!(robot)
    side = (West,Ost)
    for s in side
        while !isborder(robot,Nord)
            while !isborder(robot,s)
                move!(robot,s)
            end
            if isborder(robot,s)
                putmarker!(robot)
                move!(robot,Nord)
                putmarker!(robot)
                s = inverse(s)
            end
        end
    end
end
function Nord_perimetr!(robot)
    ugol!(robot)
    putmarker!(robot)
    side = (Nord,Sud)
    for s in side
        while !isborder(robot,Ost)
            while !isborder(robot,s)
                move!(robot,s)
            end
            if isborder(robot,s)
                putmarker!(robot)
                move!(robot,Ost)
                putmarker!(robot)
                s = inverse(s)
            end
        end
    end
end
function Sud_perimetr!(robot)
    ugol!(robot)
    putmarker!(robot)
    side = (Sud,Nord)
    for s in side
        while !isborder(robot,Ost)
            while !isborder(robot,s)
                move!(robot,s)
            end
            if isborder(robot,s)
                putmarker!(robot)
                move!(robot,Ost)
                putmarker!(robot)
                s = inverse(s)
            end
        end
    end
end
function double_perimetr!(robot)
    Ost_perimetr!(robot)
    West_perimetr!(robot)
    Nord_perimetr!(robot)
    Sud_perimetr!(robot)
end