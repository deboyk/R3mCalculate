function [ R3m ] = R3mCalculate
%R3mCalculate - A function to calculate the R3m molecular descriptor. 
%   This function calculates the molecular matrix (M), geometry matrix (G),
%   molecular influence matrix (H), and influence distance matrix (R). This
%   is accomplished by calling the following subfunctions: ImportSDF,
%   MolecMatrix, EuclidDistance, MolecInfluenceMatrix, and
%   InfluenceDistanceMat. This function currently only works for SDF files.
%   Other file formats can be converted to SDF using OpenBabel.
%   When the code is run, the user is prompted to select an SDF file. 
%   Next, the molecule is plotted using the PlotMolecule
%   function to ensure the 3D coordinates are reasonable. Finally, the R3m
%   value is calculated and output to the command window and workspace.
%
%   See also: AtomConnection, AtomicWeighting, CheckCentroid, EuclidDistance,
%   GeomCenter, ImportSDF, InfluenceDistanceMat, MolecInfluenceMatrix,
%   MolecMatrix, Origin, PlotMolecule
%
%   References: 
%       [1] Todeschini, R.; Consonni, V., Molecular Descriptors for 
%           Chemoinformatics, Volume 41 (2 Volume Set). 2nd ed.; John 
%           Wiley & Sons: 2009.
%       [2] Consonni V, Todeschini R, Pavan M, Gramatica P 2002. 
%           Structure/response correlations and similarity/diversity 
%           analysis by GETAWAY descriptors. 2. Application of the novel 
%           3D molecular descriptors to QSAR/QSPR studies. Journal of 
%           chemical information and computer sciences  42(3):693-705.
%
%   R3m can also be calculated online with appoximately 1600 other
%   descriptors at http://www.vcclab.org/lab/edragon/
%       [3] Tetko, I. V.; Gasteiger, J.; Todeschini, R.; Mauri, A.; 
%           Livingstone, D.; Ertl, P.; Palyulin, V. A.; Radchenko, E. V.;  
%           Zefirov, N. S.; Makarenko, A. S.  Virtual computational  
%           chemistry laboratory謀esign and description. J. Comput. Aided 
%           Mol. Des. 2005, 19, (6), 453-463.
%
%
% To output more data to the workspace, replace the first line of the function with the
% following:
% function [filename, M, H, G, R, MolecWeight, Atoms, Leverage, Connectivity, connections, weightedmass, topology_mat, R3m, colorset] = R3mCalculate
%
%   Code Author: Kevin DeBoyace
%                Duquesne University
%   
%   Updated: January 2019
%
%   Note: If 3D coordinates are unavailable, they can be predicted
%   using software such as CORINA. See
%   https://www.mn-am.com/online_demos/corina_demo 
%   The output file can then be converted to .sdf using Open Babel: http://openbabel.org/wiki/Main_Page
%

%% File Import

[filename] = ImportSDF;

%% Matrices
% M - Molecular Matrix
% G - Geometry Matrix
% H - Molecular Influence Matrix
% R - Influence Distance Matrix

% Molecular Matrix
[ M, Atoms, numatoms, Connectivity] = MolecMatrix( filename );


% Check that molecule is centered (correct if not)
CheckCentroid 

% Atomic weighting
[ weightedmass, MolecWeight, colorset ] = AtomicWeighting( Atoms );

% Geometry Matrix
[ G ] = EuclidDistance(M);

% Molecular Influence Matrix
[ H, Leverage ] = MolecInfluenceMatrix( M );

% Influence Distance Matrix
[ R ] = InfluenceDistanceMat( Atoms, Leverage, G );


%% Plot Molecule
% Note that this section of the code is optional.
% Comment this section out if you do not wish to plot the molecule.
% This is included since plotting the molecule can be useful for troubleshooting

PlotMolecule( M, colorset, Connectivity, Atoms ) % Plot the Molecule. 

%Plot a blue dot on the plot origin
Origin % Comment out if you do not wish to plot the origin 

%Plot a yellow dot at the geometric center
GeomCenter % Comment out if you do not wish to plot the geometric center


%% Atom connections
% Find atoms 1, 2 and 3 bond distances away.
[ connections, topology_mat ] = AtomConnection( Connectivity, Atoms );

%% R3m calculation
% Equation:  R3m = sum(i to A-1)sum(j>i) R*wi*wj*delta(k;dij) k =1,2..., d
R3m = 0;
for ii = 1:size(Atoms,1)-1;
    for jj = ii+1:size(Atoms,1);
        if topology_mat(ii,jj) == 1;
            calc = R(ii,jj)*weightedmass(ii)*weightedmass(jj);
            R3m = calc + R3m;
        else
        end
    end
end

R3m % Print R3m value to screen

end
