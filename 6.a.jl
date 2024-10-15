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

function corner!(robot)
    track = []
    while !isborder(robot, Sud) || !isborder(robot, West)
        push!(track, do_upora!(robot, Sud))
        push!(track, do_upora!(robot, West))
    end
    return track
end

function perWest!(robot)
    while isborder(robot,West)
        move!(robot,Nord)
        putmarker!(robot)
        if isborder(robot,Nord)
            move!(robot,Ost)
            putmarker!(robot)
        end
    end
end

function perNord!(robot)
    while isborder(robot,Nord)
        move!(robot,Ost)
        putmarker!(robot)
        if isborder(robot,Ost)
            move!(robot,Sud)
            putmarker!(robot)
        end
    end
end

function perOst!(robot)
    while isborder(robot,Ost)
        move!(robot,Sud)
        putmarker!(robot)
        if isborder(robot,Sud)
            move!(robot,West)
            putmarker!(robot)
        end
    end
end

function perSud!(robot)
    while isborder(robot,Sud)
        move!(robot,West)
        putmarker!(robot)
        if isborder(robot,West)
            move!(robot,Nord)
            putmarker!(robot)
        end
    end
end

function perAll!(robot)
    track = corner!(robot)
    perWest!(robot)
    perNord!(robot)
    perOst!(robot)
    perSud!(robot)
    move!(robot,Sud)
    for i in 1:length(track)
        if ((i+2) % 2) == 0
            move!(robot, Nord, track[length(track)-i + 1])
            
        else
            move!(robot, Ost, track[length(track)-i + 1])
        end
    end
end