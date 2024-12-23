using HorizonSideRobots

function do_upora_recursion!(robot, side)
    while !isborder(robot,side)
        move!(robot,side)
        do_upora_recursion!(robot,side)
    end
    return nothing
end