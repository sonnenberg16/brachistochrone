%optimalCurve script,
%searchers the Cicloid that connects the start (0,0) and the end points and prints it
%The Cycliod known as the optimal curve(solution).
%The search finds a solution that almost gets to the end-point
%A small (0.01) is good enough for the illustration.

global yE xE
kOpt = yE/2;                                        %Guess initial optimal k
x = -1*sqrt(2*kOpt*yE-yE^2)+kOpt*acos(1-yE/kOpt);   %Calculate the X value of yE
xErrorOpt = abs(x-xE);                              %Calculates the error of the guess
for k=yE/2: 0.01:1000*yE                            %Search a k value
    x = -1*sqrt(2*k*yE-yE^2)+k*acos(1-yE/k);
    xError = abs(x-xE);                             %Calculate the error of each k
    if (xError<xErrorOpt)                           %update optimal k if the error reduces
        xErrorOpt = xError;
        kOpt = k;
    end
    if xErrorOpt<0.01                               %Stop if error is less than 0.01
        break
    end
end
y = [0: 0.001: yE];
x = -1*sqrt(2*kOpt*y-y.^2)+kOpt*acos(1-y/kOpt);
plot(x,-1*y, 'r')                                   %Plot the optimal curve
    

