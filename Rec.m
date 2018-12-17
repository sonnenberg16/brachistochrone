%Rec function,
%is the recurtion function
%Input: x,y of the current-point
%Output: totalTime, path, nextIy, nextDeltaTime of the solution form the 
%current-path to the end point.
%Minimun Y (1), Minimum Y (2) - match definitions 1,2 in Bellman and Dryfus, 1962, page 330.

function [totalTime, path, nextIy, nextDeltaTime] = Rec(x,y)
    global B xE yE dx dy Nx Ny
    ix = int16(x/dx+1);                 %Extracting column index from x value
    iy = int16(y/dy+1);                 %Extracting row index from y value
    yMin1 = y + dx*(yE-y)/(xE-x);       %Minimun y (1) - below the slope of the line to end point
    iyMin1 = Ny-floor(abs(yE-yMin1)/dy);%Row index of the minimum y
    iyMin2 = 0;
    if (iy > 1)
        if (B(iy-1,ix).done)
            iyMin2 = B(iy-1,ix).nextIy;     %Minimun Y (2) - below the minimun y of higher point solution
        end
    end
    iyMin = int16(max(iyMin1, iyMin2));     %Finding the maximum of the 2 minimums
    optTime = inf;                          %Initiate the optimal time from current-point to the end
    optNextIy = inf;                        %Initiate the optimal-next-point
    optNextDeltaTime = inf;                 %Initiate the optimal time from current-point to optimal-next-point
    ix = int16(x/dx +2);                    %Extracting the next column index of the from x value
    for iy = iyMin:Ny                       %Searching for the optimal-next-point from the minimum y to the end
        if (~B(iy,ix).done)                 %If the next point was not calculated yet..
            B(iy,ix).x = x+dx;              %Calculate x value of the next point
            B(iy,ix).y = (double(iy)-1)*dy; %Calculate y value of the next point
            [B(iy,ix).time B(iy,ix).path B(iy,ix).nextIy B(iy,ix).nextDeltaTime]= Rec(B(iy,ix).x, B(iy,ix).y); %Find .time .path .nextIy .nextDeltaTime by a recursion
            B(iy,ix).done = true;           %mark the cell as done
        end
        deltaTime = time(y, B(iy,ix).y);    %Calculate the time interval to the next point. See time function...
        tmpTime = deltaTime + B(iy,ix).time;%Add next time interval to the optimal time from the next point to the end
        if (tmpTime > optTime)              %If the total time grows, stop searching (break for loop).
            break;                          %Match definition 3 in Bellman and Dreyfus,1962,page 331
        else                                %If the time decreases, update optimal-next-point
            optTime = tmpTime;              %and continue to search (for loop)
            optNextIy = int16(iy);
            optNextDeltaTime = deltaTime;
        end
    end                                     %end the searching loop (for)
    path = [x y; B(optNextIy,ix).path];     %Update the path from the current-point to the end. by adding the
                                            %current-point to the path form the optima-next-point to the end
    totalTime = optTime;                    %Update the optimal time from current-point to the end
    nextIy = optNextIy;                     %update the row index of the optimal-next-point
    nextDeltaTime = optNextDeltaTime;       %Update the time from current-point to the optimal-next-point
end