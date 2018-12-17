%time function,
%calculates the time it takes traverse an incremental horizontal
%distance deltaX at angle yTag.
%Input:
%y - the hight of intial point of the interval 
%y1 - the hight of final point of the interval 
%(dx is deltaX and it is contant for a spesific problem)
%Output: the interval time
%VelocityMethod is determined by the user in Main either
%Constant or Integratedmothod. See Bellman Dreyfus, 1962, page 331-332

function deltaTime = time(y,y1)
    global dx dy Nx g VelocityMethod
    yTag = (y1-y)/dx;                           %Calculates yTag
    switch VelocityMethod                       %calculate the velocity in accordance
        case 'ConstantVelocity'                 %   with the velocitymethod
            if (y==0)
                v = (0+sqrt(2*g*y1))/2;         %For the first interval (y=0) use average of
            else                                %   inital (zero) and final velocity
                v = sqrt(2*g*y);                %for all other intevals use the inital velocity
            end
            deltaTime = sqrt((1+yTag^2))/v*dx;  %Use the constant velocity to calculate the time
        case 'IntegratedVeloctiy'
            if (yTag<(dy/dx))
                deltaTime = dx/sqrt(2*g*y);     %If next interval is horizontal uses a constantvelocity
            else                                %If it is not, calculate the integrated time
                deltaTime = sqrt(2*(1+yTag^2)/g)/yTag*(sqrt(y+dx*yTag)-sqrt(y));
            end
    end
end