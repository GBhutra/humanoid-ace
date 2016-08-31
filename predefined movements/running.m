disp ('Hello !!');
ser = serial('COM3','Baudrate',9600,'Databits',8);
fopen(ser);

pause(1);
disp('running !!!!');

transmit_ra3(90,ser);
pause(0.3);
transmit_la3(90,ser);
pause(0.3);
transmit_ra2(45,ser);
pause(0.3);
transmit_la2(45,ser);
pause(0.3);
transmit_ra2(0,ser);
pause(0.3);
transmit_la2(0,ser);
pause(0.3);
transmit_ra2(45,ser);
pause(0.3);
transmit_la2(45,ser);
pause(0.3);
transmit_ra2(0,ser);
pause(0.3);
transmit_la2(0,ser);
pause(0.3);
transmit_ra2(45,ser);
pause(0.3);
transmit_la2(45,ser);
pause(0.3);
transmit_ra2(0,ser);
pause(0.3);
transmit_la2(0,ser);
pause(0.3);

fclose(ser);
resetposition;
disp('Thank You !!!');

