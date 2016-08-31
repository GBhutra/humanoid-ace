function [ ] = resetposition(  )
%resets the humanoid to original position

ser = serial('COM3','Baudrate',9600,'Databits',8);
fopen(ser);



transmit_la1(0,ser);
pause(0.5);
transmit_la2(0,ser);
pause(0.5);
transmit_la3(0,ser);
pause(0.5);
transmit_ra1(0,ser);
pause(0.5);
transmit_ra2(0,ser);
pause(0.5);
transmit_ra3(0,ser);
pause(0.5);


fclose(ser);


end

