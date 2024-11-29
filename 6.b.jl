using HorizonSideRobots

function four_dots!(robot)
    way = corner_way!(robot)
    for i in 1:length(way)
        if ((i+2) % 2) == 0
            move!(robot, Sud, way[length(way)-i + 1])
            
        else
            move!(robot, Ost, way[length(way)-i + 1])
        end
    end
    (x1, y1, x2, y2) = (0, 0, 0, 0)
    for i in 1:length(way)
        if ((i+2) % 2) == 0
            x1 += way[i]
        else
            y1 += way[i]
        end
    end
    x2 = 11 - x1
    y2 = 10 - y1

    corner_way!(robot)

    move!(robot, Ost, x1)
    putmarker!(robot)
    do_upora!(robot, Ost)
    move!(robot, Sud, y1)
    putmarker!(robot)
    do_upora!(robot, Sud)
    move!(robot, West, x2)
    putmarker!(robot)
    do_upora!(robot, West)
    move!(robot, Nord, y2)
    putmarker!(robot)
    do_upora!(robot, Nord)

    for i in 1:length(way)
        if ((i+2) % 2) == 0
            move!(robot, Sud, way[length(way)-i + 1])
            
        else
            move!(robot, Ost, way[length(way)-i + 1])
        end
    end

end


function corner_way!(robot)
    way = []
    while !isborder(robot, Nord) || !isborder(robot, West)
        push!(way, do_upora!(robot, Nord))
        push!(way, do_upora!(robot, West))
    end
    return way
end

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