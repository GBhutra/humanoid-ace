disp ('Hello !!');
ser = serial('COM3','Baudrate',9600,'Databits',8);
fopen(ser);

pause(1);
disp('hi !!!');

transmit_ra1(90,ser);
pause(0.5);
transmit_ra2(90,ser);
pause(2);
transmit_ra3(30,ser);
pause(0.3);
transmit_ra3(90,ser);
pause(0.3);
transmit_ra3(30,ser);
pause(0.3);
transmit_ra3(90,ser);
pause(0.3);
transmit_ra3(30,ser);
pause(0.3);
transmit_ra3(90,ser);
pause(0.3);

fclose(ser);
resetposition;
disp('Thank You !!!');

