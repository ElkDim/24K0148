using HorizonSideRobots
function crest!(robot::Robot)
    for side = (Nord, Ost,Sud,West)
        putmarker!(robot)
        num_steps = mark_direct!(robot,side)
        side = inverse(side)
        move!(robot,side,num_steps)
    end
end


# #include(C:/julia/1.jl)
