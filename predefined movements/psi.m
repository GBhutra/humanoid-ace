disp ('Hello !!');
ser = serial('COM3','Baudrate',9600,'Databits',8);
fopen(ser);

pause(1);
disp('PSI position');

transmit_la1(90,ser);
pause(0.5);
transmit_ra1(90,ser);
pause(0.5);
transmit_la2(90,ser);
pause(0.5);
transmit_ra2(90,ser);
pause(0.5);
transmit_la3(90,ser);
pause(0.5);
transmit_ra3(90,ser);
pause(0.5);

disp('Thank You !!!');
fclose(ser);
