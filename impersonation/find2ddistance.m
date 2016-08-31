function [ dist ] = find2ddistance( p1,p2 )
% calclates the distance between 2 points in 2 dimensions

dist = (((p1(2)-p2(2))^2)+((p1(1)-p2(1))^2))^0.5;


end

