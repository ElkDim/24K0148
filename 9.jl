using HorizonSideRobots

function do_upora!(robot::Robot, send::HorizonSide)
    n::Int=0
    while !isborder(robot, send)
        move!(robot, send)
        n+=1
    end
    return n
end

function HorizonSideRobots.move!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot, side)
    end
end

function inverse(side)
    return HorizonSide((Int(side)+2)%4)
end

function go!(robot, side::HorizonSide, s::HorizonSide)
    n = 0
    while !isborder(robot,side)
        move!(robot,side)
        n+=1
        if n%2==0
            putmarker!(robot)
        end
        if isborder(robot,side) && !isborder(robot,s)
            move!(robot,s)
            n += 1
            side = inverse(side)
            if n%2==0
                putmarker!(robot)
            end
        end
        if isborder(robot,s) && isborder(robot,side)
            do_upora!(robot,Ost)
            break
        end
    end
end

function cross_board!(robot, side::HorizonSide, s::HorizonSide)
    putmarker!(robot)
    while !isborder(robot,s)
        go!(robot,side,s)
    end
end

function super_chess!(robot)
    y1 = do_upora!(robot,Nord)
    x1 = do_upora!(robot,Ost)
    move!(robot,Sud,y1)
    move!(robot,West,x1)
    y2 = do_upora!(robot,Sud)
    x2 = do_upora!(robot,West)
    move!(robot,Nord,y2)
    move!(robot,Ost,x2)
    side = Ost
    s = Nord
    cross_board!(robot,side,s)
    move!(robot,West,x1)
    move!(robot,Sud,y1)
    s = inverse(s)
    side = inverse(side)
    cross_board!(robot,side,s)
    move!(robot,West,x1)
    move!(robot,Nord,y2)
end
