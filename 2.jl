using HorizonSideRobots
side = (Ost,Nord,West,Sud)
function do_upora!(robot::Robot, side)
    while !isborder(robot,side)
        move!(robot,side)
        putmarker!(robot)
    end
end
function perimetr!(robot)
    while !isborder(robot,Sud)
        move!(robot,Sud)
    end
    while !isborder(robot,West)
        move!(robot,West)
    end
    do_upora!(robot,Nord)
    do_upora!(robot,West)
    do_upora!(robot,Sud)
    do_upora!(robot,Ost)
    do_upora!(robot,Nord)
    do_upora!(robot,West)
end