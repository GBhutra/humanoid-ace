function [ ] = transmit_ra1( data,ser )
%Transmitts the angle to reach to the motor La1

if data > 150
    data = hypot((10-data),0);
else
    data = data+5;
end


a0 = 32;
a1 = 160;

ln = bitand(data,15); % extracting the lower nibble
temp = bitand(data,240); %extracting the higher nibble
hn = bitshift(temp,-4,8); %left shift 4 the lower nibble

byte1 = bitor(a0,ln); %constructing the 1st byte with lower nibble
byte2 = bitor(a1,hn);   %constructing the 2nd byte with higher nibble

for i = 1 : 3
    fwrite(ser,byte1);
    fwrite(ser,byte2);
end


end