function [ angle ] = anglebetweenline( l1p1,l1p2,l2p1,l2p2 )
%Calculates the the angle between the 2 dimensional lines defined by 2 points

slope1 = (l1p1(2)-l1p2(2))/(l1p1(1)-l1p2(1));
slope2 = (l2p1(2)-l2p2(2))/(l2p1(1)-l2p2(1));

temp = ((slope1-slope2)/(1+slope1*slope2));
angle = atand(temp);

end

