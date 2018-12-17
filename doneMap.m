%doneMap script
%creates an image that illustrates the solution space
%that the recurtion calculated.

for ix = 1:Nx                         %Im matrix contains ones for all the cells that are done
    for iy = 1:Ny                     %and contains zeros for all untuched cells
        if (B(iy,ix).done==true), Im(iy,ix) = 1; end
    end
end
figure
colormap gray
imagesc(Im)                           %Prints the Im matrix. Ones are colored in white and zeros are in black