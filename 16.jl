using HorizonSideRobots

function HorizonSideRobots.move!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot, side)
    end
end

function shuttle!(stop_condition::Function, robot, side)
    k = 0
    side1 = Ost
    side2 = West
    while stop_condition(robot,side) == 1
        k += 1
        move!(robot,side1,k)
        if stop_condition(robot,side) == 1
            k += 1
            move!(robot,side2,k)
        end
    end
end