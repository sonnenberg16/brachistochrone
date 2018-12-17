%calcB script,
%initiates B matrix and strats the dynamic programing recursion
%Each cell in matrix B represents a grid node.
%B is a structure that contains the following fields:
%B(iy,ix).x - the X value of the grid node.
%B(iy,ix).y - the Y value of the grid node.
%B(iy,ix).time - the minimum time from this point to the end.
%B(iy,ix).path - the minimum path from this point to the end.
%B(iy,ix).nextIy - the row index of the next cell (in the minimum path).
%B(iy,ix).nextDeltaTime - the time to the next point (in the minimum path).
%B(iy,ix).done - a binary field that is true if the cell is already calculated

global B xE yE dx dy Nx Ny g VelocityMethod

for ix = 1:Nx                       %Initiates full B matrix
    for iy = 1:Ny               
        B(iy,ix).done = false;      %Mark cell as 'not done'
    end    
end    
    

ix = Nx;                            %Initiate last cell values (the end point)
iy = Ny;
B(iy,ix).x = xE;
B(iy,ix).y = yE;
B(iy,ix).time = 0;
B(iy,ix).path = [xE yE];            %Insert the last point to the miniumum path
B(iy,ix).done = true;

ix = 1;                             %Initiate first cell values (the strat point)
iy = 1;
B(iy,ix).x = xS;
B(iy,ix).y = yS;
[B(iy,ix).time B(iy,ix).path B(iy,ix).nextIy B(iy,ix).nextDeltaTime] = Rec(B(iy,ix).x, B(iy,ix).y);  
B(iy,ix).done = true;               %%.time .path .nextIy .nextDeltaTime are defined by the recursion.


