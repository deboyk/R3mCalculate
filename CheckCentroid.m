%%CheckCentroid
% The purpose of this script is to check that the imported coordinates are
% centered (i.e. at x,y,z coordinate (0,0,0)). If the coordinates are not 
% centered, text is output to the command window and the coordinates
% are centered for the user.
% See Also: R3mCalculate, GeomCenter
%
% Author: Kevin DeBoyace
%         Wildfong Lab
%         Duquesne University
% Updated: Jan 2019

x_centroid = mean(M(:,1));
round_x = round(x_centroid*10); %Multipy by 10 to round to nearest tenth.
round_x = round_x/10;

y_centroid = mean(M(:,2));
round_y = round(y_centroid*10);
round_y = round_y/10;

if size(M,2) == 3;
    z_centroid = mean(M(:,3));
    round_z = round(z_centroid*10);
    round_z = round_z/10;
end

errorcount = 0;

if round_x ~= 0
    fprintf(2,'ERROR: Coordinates not centered (X)!\n')
    errorcount = errorcount+1;
end

if round_y ~= 0
    fprintf(2,'ERROR: Coordinates not centered (Y)!\n')
    errorcount = errorcount+1;
end

if round_z ~= 0
    fprintf(2,'ERROR: Coordinates not centered (Z)!\n')
    errorcount = errorcount+1;
end

if errorcount > 0;
    M(:,1) = M(:,1)-x_centroid;
    M(:,2) = M(:,2)-y_centroid;
    M(:,3) = M(:,3)-z_centroid;
    fprintf(2, 'NOTICE: Coordinates have now been centered.')
end

    