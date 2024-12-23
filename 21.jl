using HorizonSideRobots

function rotate(side)
    return HorizonSide(((Int(side))+3)%4)
end

function inverse(side)
    return HorizonSide(((Int(side))+2)%4)
end 

function twenty_one!(robot, side1)
    side2 = rotate(side1)
    if isborder(robot, side1)
        move!(robot, side2)
        twenty_one!(robot, side1)
        move!(robot, inverse(side2))
    else
        move!(robot, side1) 
    end
end