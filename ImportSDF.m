function [ filename ] = ImportSDF
%Import data from sdf file.
% Script for importing data from .sdf files. Cartesian coordinates obtained
% from molecular structure (e.g. through CCDC, Smiles conversion to 3D
% through CORINA or Open Babel, etc.)
% See Also: R3mCalculate
%
% Author: Kevin DeBoyace
%         Wildfong Lab
%         Duquesne University
% Updated: Jan 2019


%% Initialize variables.
[file, path] = uigetfile('.sdf'); % Prompt user to select file
filename = [path,file]; %stich filename and pathname together 

end

