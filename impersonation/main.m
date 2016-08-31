%--------------initialisation of required files--------------------%
addpath('Mex')
SAMPLE_XML_PATH='Config/SamplesConfig.xml';
ser = serial('COM3','Baudrate',9600,'Databits',8);
fopen(ser);
%--------------allocating memory--------------------%

KinectHandles=mxNiCreateContext(SAMPLE_XML_PATH);

%--------------displaying the rgb image--------------------%
figure,
Pos= mxNiSkeleton(KinectHandles); 
I=mxNiPhoto(KinectHandles); I=permute(I,[3 2 1]);
h=imshow(I);

%--------------detecting user--------------------%        
while(Pos(1)==0);
    mxNiUpdateContext(KinectHandles);   % updating the kinect values
    I=mxNiPhoto(KinectHandles); I=permute(I,[3 2 1]);
    Pos= mxNiSkeleton(KinectHandles); 
    set(h,'Cdata',I); drawnow;
end

%--------------tracking the skeleton--------------------%
hh=zeros(1,9);
while(Pos(1)>0)
    mxNiUpdateContext(KinectHandles);
    I=mxNiPhoto(KinectHandles); I=permute(I,[3 2 1]);
    set(h,'Cdata',I); drawnow;
    Pos= mxNiSkeleton(KinectHandles,1); 
    if(hh(1)>0);
        for i=1:9, delete(hh(i)); end
    end
    hold on
    y=Pos(1:15,7);
    x=Pos(1:15,6);
    
    %--------coordinates of the data points in millimeters----------%
    
    head = [ Pos(1,3) Pos(1,4) Pos(1,5) ];
    neck = [ Pos(2,3) Pos(2,4) Pos(2,5) ];
    lshoulder = [ Pos(3,3) Pos(3,4) Pos(3,5) ];
    lelbow = [ Pos(4,3) Pos(4,4) Pos(4,5) ];
    lhand = [ Pos(5,3) Pos(5,4) Pos(5,5) ];
    rshoulder = [ Pos(6,3) Pos(6,4) Pos(6,5) ];
    relbow = [ Pos(7,3) Pos(7,4) Pos(7,5) ];
    rhand = [ Pos(8,3) Pos(8,4) Pos(8,5) ];
    torso = [ Pos(9,3) Pos(9,4) Pos(9,5) ];
    lhip = [ Pos(10,3) Pos(10,4) Pos(10,5) ];
    lknee = [ Pos(11,3) Pos(11,4) Pos(11,5) ];
    lfoot = [ Pos(12,3) Pos(12,4) Pos(12,5) ];
    rhip = [ Pos(13,3) Pos(13,4) Pos(13,5) ];
    rknee = [ Pos(14,3) Pos(14,4) Pos(14,5) ];
    rfoot = [ Pos(15,3) Pos(15,4) Pos(15,5) ];
    
    %--------calculating the right and left arm angle 1----------%
    
    ra1 = anglebetweenline(torso(1:2),head(1:2),rshoulder(1:2),relbow(1:2));
    if ra1 > 0 
        ra1 = 180 - ra1;
    else
        ra1 = hypot(ra1,0);
    end
    
    
    la1 = anglebetweenline(torso(1:2),head(1:2),lshoulder(1:2),lelbow(1:2));
    if la1 > 0 
        la1 = 180 - la1;
    else
        la1 = hypot(la1,0);
    end
    
    la1 = 170-la1
    

    %--------calculating the right and left arm angle 2----------%
    
    ra2 = anglebetweenline(torso(2:3),head(2:3),rshoulder(2:3),relbow(2:3));
    if ra2 > 0
        ra2 = 180 - ra2;
    else
        ra2 = hypot(ra2,0);
    end
    
    
    la2 = anglebetweenline(torso(2:3),head(2:3),lshoulder(2:3),lelbow(2:3));
    la2 = hypot(la2,0);
        
    %--------calculating the right and left arm angle 3----------%
    
    ra3 = anglebetweenline3d(rshoulder,relbow,rhand,relbow);
    ra3 = 180 - ra3;
    if ra3 > 90 
        ra3 = 90
    else
        ra3 = floor(ra3)
    end
    
    
    la3 = anglebetweenline3d(lshoulder,lelbow,lhand,lelbow);
    la3 = 180 - la3;
    if la3 > 90 
        la3 = 90
    else
        la3 = floor(la3)
    end 
        
    %--------movement----------%
    
    level = hypot(rknee(2)-lknee(2),0);
    if level < 150
        dist = find2ddistance(rknee(1:2),lknee(1:2))
        if dist > 250
            disp('forward');
            transmit_move(1,ser);
        else
            disp('stop');
            transmit_move(4,ser);
        end
    elseif rknee(2) > lknee(2)
        disp('right');
        transmit_move(2,ser);
    elseif lknee(2) > rknee(2)
        disp('left');
        transmit_move(3,ser);
    else
        disp('stop');
        transmit_move(4,ser);
    end

    %--------transmission----------%
    
    transmit_ra1(floor(ra1),ser);
    pause(0.2)
    transmit_la1(floor(la1),ser);
    pause(0.2)
    transmit_ra2(floor(ra2),ser);
    pause(0.2);
    transmit_la2(floor(la2),ser);
    pause(0.2);
    transmit_ra3(floor(ra3),ser);
    pause(0.2);
    transmit_la3(floor(la3),ser);
    pause(0.2);


    hh(1)=plot(x,y,'r.');
    hh(2)=plot(x([13 14 15]),y([13 14 15]),'g');
    hh(3)=plot(x([10 11 12]),y([10 11 12]),'g');
    hh(4)=plot(x([9 10]),y([9 10]),'m');
    hh(5)=plot(x([9 13]),y([9 13]),'m');
    hh(6)=plot(x([2 3 4 5]),y([2 3 4 5]),'b');
    hh(7)=plot(x([2 6 7 8]),y([2 6 7 8]),'b');
    hh(8)=plot(x([1 2]),y([1 2]),'c');
    hh(9)=plot(x([2 9]),y([2 9]),'c');
    drawnow
    
end 

mxNiDeleteContext(KinectHandles);
  


    