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

function Ost_way!(robot)
    OstRes = []
    while !isborder(robot,Ost)
        push!(OstRes,do_upora!(robot,Ost))
    end
    return OstRes
end

function West_way!(robot)
    WestRes = []
    while !isborder(robot,West)
        push!(WestRes,do_upora!(robot,West))
    end
    return WestRes
end

function Nord_way!(robot)
    NordRes = []
    while !isborder(robot,Nord)
        push!(NordRes,do_upora!(robot,Nord))
    end
    return NordRes
end

function Sud_way!(robot)
    SudRes = []
    while !isborder(robot,Sud)
        push!(SudRes,do_upora!(robot,Sud))
    end
    return SudRes
end

function inverse(side)
    return HorizonSide((Int(side)+2)%4)
end

function super_chess!(robot)
    NordRes = Nord_way!(robot)
    OstRes = Ost_way!(robot)
    move!(robot,West,OstRes[begin])
    move!(robot,Sud,NordRes[begin])
    SudRes = Sud_way!(robot)
    WestRes = West_way!(robot)
    move!(robot,Ost,WestRes[begin])
    move!(robot,Nord,SudRes[begin])
    putmarker!(robot)
    side = (Ost,West)
    for s in side
        while !isborder(robot,Nord)
            n = 0
            while !isborder(robot,s)
                move!(robot,s)
                n += 1
                if n%2 == 0
                    putmarker!(robot)
                end
                if isborder(robot,s) && !isborder(robot,Nord)
                    move!(robot,Nord)
                    n += 1
                    s = inverse(s)
                    if n%2 == 0
                        putmarker!(robot)
                    end
                end
                if isborder(robot,s) && isborder(robot,Nord)
                    do_upora!(robot,Ost)
                    move!(robot,West,OstRes[begin])
                    move!(robot,Sud,NordRes[begin])
                    break
                end
            end
            if ismarker(robot)
                break
            end
        end
        s = inverse(s)
        while !isborder(robot,Sud)
            n = 0
            while !isborder(robot,s)
                move!(robot,s)
                n += 1
                if n%2 == 0
                    putmarker!(robot)
                end
                if isborder(robot,s) && !isborder(robot,Sud)
                    move!(robot,Sud)
                    n += 1
                    s = inverse(s)
                    if n%2 == 0
                        putmarker!(robot)
                    end
                end
                if isborder(robot,s) && isborder(robot,Sud)
                    do_upora!(robot,West)
                    move!(robot,Ost,WestRes[begin])
                    move!(robot,Nord,SudRes[begin])
                    break
                end
            end
            if ismarker(robot)
                break
            end
        end
    end
end