using HorizonSideRobots

function mark_direct!(robot)
    for side ∈ (Nord, Ost, Sud, West)
        while isborder(robot, side)==false
            move!(robot, side)
            putmarker!(robot)
        end
    end
end

num_steps = mark_direct!(robot)


function HorizonSideRobots.move!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot, side)
    end
end

function inverse!(side)
    return HorizonSide((Int(side)+2)%4)
end


function dyra!(robot)
    k = 0
    while isborder(robot,Nord)
        k += 1
        move!(robot,Ost,k)
        if isborder(robot,Nord)
            k += 1
            move!(robot,West,k)
        end
    end
end