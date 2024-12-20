using HorizonSideRobots

function HorizonSideRobots.move!(robot, side, num_steps::Integer)
    for _ in 1 : num_steps
        move!(robot, side)
    end
end

function inverse(side)
    return HorizonSide((Int(side)+2)%4)
end

mutable struct ChessRobot
    robot::Robot
    flag::Bool
end

function HorizonSideRobots.move!(robot::ChessRobot, side)
    robot.flag && putmarker!(robot.robot)
    robot.flag  = !robot.flag
    move!(robot.robot, side)
end

function do_upora_SUPER!(stop_condition::Function, robot, side)
    n=0
    while !stop_condition()
        move!(robot, side)
        n+=1
    end
    robot.flag && putmarker!(robot.robot)
    return n
end

function do_upora!(robot, side)
    k = 0 
    while !isborder(robot, side)
        move!(robot, side)
        k+=1
    end
    return k
end

function snake!(stop_condition::Function, robot, sides::NTuple{2,HorizonSide})
    s=sides[1]
    while !stop_condition(s)
        do_upora_SUPER!(()->stop_condition(s) || isborder(robot.robot, s), robot,s)
        if stop_condition(s)
            break
        end
    s = inverse(s)
    move!(robot, sides[2])
    end
end

function Super_Puper_Chess!(robot)
    y = do_upora!(robot.robot, Sud)
    x = do_upora!(robot.robot, West)
    move!(robot.robot, Nord, y)
    move!(robot.robot, Ost, x)
    putmarker!(robot.robot)
    snake!( s -> isborder(robot.robot, Nord) && isborder(robot.robot, s), robot, (Ost, Nord))
    snake!( s -> isborder(robot.robot, Sud) && isborder(robot.robot, s), robot, (West, Sud))
    do_upora!(robot.robot, Sud)
    do_upora!(robot.robot, West)
    move!(robot.robot, Nord, y)
    move!(robot.robot, Ost, x)
end