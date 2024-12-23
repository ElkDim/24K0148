using HorizonSideRobots

function inverse(side)
    return HorizonSide(((Int(side))+2)%4)
end 

function twenty!(robot,side)
    if isborder(robot,side)
        putmarker!(r)
    else
        move!(robot,side)
        twenty!(robot,side)
        move!(robot, inverse(side))
    end 
end 