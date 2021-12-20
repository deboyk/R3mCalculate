%% GeomCenter
% This script plots the geometric center as a yellow dot
% See also: PlotMolecule, CheckCentroid, R3mCalculate
%
% Author: Kevin DeBoyace
%         Wildfong Lab
%         Duquesne University
% Updated: Jan 2019

x_centroid = mean(M(:,1))
y_centroid = mean(M(:,2))

% If 3D coordinate system
if size(M,2) == 3; 
    z_centroid = mean(M(:,3))
    hold on
    scatter3(x_centroid,y_centroid,z_centroid,...
        'MarkerEdgeColor', 'k','MarkerFaceColor', [0.75 0.75 0]) % Plot yellow dot
% If 2D coordinate system
else 
    hold on
    scatter(x_centroid,y_centroid,...
        'MarkerEdgeColor', 'k','MarkerFaceColor', [0.75 0.75 0])
end