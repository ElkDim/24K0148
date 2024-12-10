using HorizonSideRobots

function HorizonSideRobots.move!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        if ismarker(robot)
            break
        else
            move!(robot, side)
        end
    end
end

function dot_finder!(robot)
    k = 0
    while !ismarker(robot)
        k += 1
        move!(robot,Ost,k)
        move!(robot,Nord,k)
        k += 1
        move!(robot,West,k)
        move!(robot,Sud,k)
    end
end
