function [ ] = transmit_ra2( data,ser )
%Transmitts the angle to reach to the motor La1

data  = data +75;

a0 = 80;
a1 = 208;

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