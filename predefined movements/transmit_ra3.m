function [ ] = transmit_ra3( data,ser )
%Transmitts the angle to reach to the motor La1

a0 = 48;
a1 = 176;

ln = bitand(data,15); % extracting the lower nibble
temp = bitand(data,240); %extracting the higher nibble
hn = bitshift(temp,-4,8); %left shift 4 the lower nibble

byte1 = bitor(a0,ln); %constructing the 1st byte with lower nibble
byte2 = bitor(a1,hn);   %constructing the 2nd byte with higher nibble

for i = 1 : 5
    fwrite(ser,byte1);
    fwrite(ser,byte2);
end


end