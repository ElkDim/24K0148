using HorizonSideRobots

function HorizonSideRobots.move!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot, side)
    end
end

function do_upora!(robot::Robot, send::HorizonSide)
    n::Int=0
    while !isborder(robot, send)
        move!(robot, send)
        n+=1
    end
    return n
end

function listOst!(robot)
    n = 0
    listOst = []
    while !isborder(robot,Ost)
        move!(robot,Ost)
        if isborder(robot,Nord)
            n+=1
        end
        if !isborder(robot,Nord) && n!=0
            push!(listOst,max(n))
        end
    end
    unique_listOst = unique(listOst)
    return length(unique_listOst)
end

function listWest!(robot)
    n = 0
    listWest = []
    while !isborder(robot,West)
        move!(robot,West)
        if isborder(robot,Nord)
            n+=1
        end
        if !isborder(robot,Nord) && n!=0
            push!(listWest,max(n))
        end
    end
    unique_listWest = unique(listWest)
    return length(unique_listWest)
end

function count_borders!(robot)
    num_steps_West = do_upora!(robot,West)
    num_steps_Sud = do_upora!(robot,Sud)
    k = 0
    while !(isborder(robot, Nord) && (isborder(robot, Ost) || isborder(robot, West)))
        k+=listOst!(robot)
        if isborder(robot,Ost)
            move!(robot,Nord)
        end
        k+=listWest!(robot)
        if isborder(robot,West)
            move!(robot,Nord)
        end
        if isborder(robot, Nord) && (isborder(robot, Ost) || isborder(robot, West))
            do_upora!(robot,West)
            do_upora!(robot,Sud)
            move!(robot,Nord,num_steps_Sud)
            move!(robot,Ost,num_steps_West)
            break
        end
    end
    return k
end