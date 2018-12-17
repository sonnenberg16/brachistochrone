%Main script
%is used to run the code without the GUI
%Change the parameters values in the code in order to different
%senarios.

close all
clear all
clc

global B xE yE dx dy Nx Ny g VelocityMethod

%VelocityMethod= 'ConstantVelocity'; %Choose one VelocityMethod
VelocityMethod = 'IntegratedVeloctiy'; %Mark the other line as a comment

Ndx = 40;                      %Define number of delta X
Ndy = 100;                     %Define number of delta Y

g = 9.81;

xS = 0;                        %Define X0. In this code must be zero!!!
yS = 0;                        %Define Y0. In this code must be zero!!!
xE = 2;                        %Define X1
yE = 1.83223;                  %Define y1

dx = (xE-xS)/Ndx;              %Calculate delta X
dy = (yE-yS)/Ndy;              %Calculate delta Y
Nx = Ndx + 1;                  %Nx is the the number of columns in B matrix
Ny = Ndy + 1;                  %Ny is the the number of rows in B matrix

calcB                          %Run the calcB script - see comments there

figure
hold on
optimalCurve                   %Find and plot the optimal curve. See the script
plot(B(1,1).path(:,1), -1*B(1,1).path(:,2)) %Plot the accepted curve
hold off

doneMap                        %Find the solutions space and print it, See the script