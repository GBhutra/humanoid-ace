function [ angle ] = anglebetweenline3d( l1p1,l1p2,l2p1,l2p2 )
%Calculate the angle between 2 vectors in 3d

vect1 = l1p1 - l1p2;
vect2 = l2p1 - l2p2;

numer = (vect1(1)*vect2(1))+(vect1(2)*vect2(2))+(vect1(3)*vect2(3));
denominor  = (sqrt((vect1(1)^2)+(vect1(2)^2)+(vect1(3)^2)))*(sqrt((vect2(1)^2)+(vect2(2)^2)+(vect2(3)^2)));

angle = acosd(numer/denominor);


end

