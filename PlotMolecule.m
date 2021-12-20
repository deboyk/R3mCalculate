function [ output_args ] = PlotMolecule( M, colorset, Connectivity, Atoms )
%PlotMolecule: 3-D plot a molecule.
%   Generate a 3-D plot of a molecule with colors representing different
%   atom types. This function requires an input of the molecules cartesian
%   coordinates (M) and a matrix of the colors which correspond to each
%   atom. 'color' is generated in the 'AtomicWeighting' function. 'M' is
%   generated in the 'ImportSDF' function.
%
%   Single bond = Black Line
%   Double bond = Blue Line
%   Triple bond = Red Line
%
% See Also: AtomicWeighting, MolecMatrix, MolecInfluenceMatrix, ImportSDF, R3mCalculate
%
% Author: Kevin DeBoyace
%         Wildfong Lab
%         Duquesne University
%  Updated: Jan 2019


%% Plot Spheres
% Plot atoms as spheres of different colors and sizes.
% Note that the sizes are arbitrarily set for visualization purposes, and 
% are not to scale.
[x,y,z] = sphere(10);
scalefac = 0.3;
x = x*scalefac; y = y*scalefac; z = z*scalefac;
figure;
for ii = 1:size(M,1);
    if strcmp(Atoms(ii), 'C') == 1; % Draw Carbon
        h = surf(0.8*x+M(ii,1),0.8*y+M(ii,2), 0.8*z+M(ii,3));
        hold on
        set(h,'Facecolor',colorset(ii,:));
        elseif strcmp(Atoms(ii), 'H') == 1; % Draw Hydrogen 
                h = surf(0.5*x+M(ii,1),0.5*y+M(ii,2), 0.5*z+M(ii,3));
                hold on
                set(h,'Facecolor',colorset(ii,:));
            elseif strcmp(Atoms(ii), 'O') == 1; % Draw Oxygen
                    h = surf(1*x+M(ii,1),1*y+M(ii,2), 1*z+M(ii,3));
                    hold on
                    set(h,'Facecolor',colorset(ii,:));
                elseif strcmp(Atoms(ii), 'N') == 1; % Draw Nitrogen
                        h = surf(0.9*x+M(ii,1),0.9*y+M(ii,2), 0.9*z+M(ii,3));
                        hold on
                        set(h,'Facecolor',colorset(ii,:));
                    elseif strcmp(Atoms(ii), 'Cl') == 1; % Draw Chlorine
                            h = surf(1.3*x+M(ii,1),1.4*y+M(ii,2), 1.4*z+M(ii,3));
                            hold on
                            set(h,'Facecolor',colorset(ii,:));
                        elseif strcmp(Atoms(ii), 'S') == 1; % Draw Sulfur
                                h = surf(1.25*x+M(ii,1),1.3*y+M(ii,2), 1.3*z+M(ii,3));
                                hold on
                                set(h,'Facecolor',colorset(ii,:));
                            elseif strcmp(Atoms(ii), 'P') == 1; % Draw Phosphorous
                                    h = surf(1.2*x+M(ii,1),1.2*y+M(ii,2), 1.2*z+M(ii,3));
                                    hold on
                                    set(h,'Facecolor',colorset(ii,:));
                                elseif strcmp(Atoms(ii), 'F') == 1; % Draw Fluorine
                                        h = surf(1.1*x+M(ii,1),1.1*y+M(ii,2), 1.1*z+M(ii,3));
                                        hold on
                                        set(h,'Facecolor',colorset(ii,:));


    end
end

xlabel('X', 'FontSize', 16)
ylabel('Y', 'FontSize', 16)
zlabel('Z', 'FontSize', 16)

%% Draw Bonds
Connect = Connectivity(:,1:2);

for ii = 1:size(Connectivity,1);
    if Connectivity(ii,3) == 1; % Draw Single Bonds
        plot3(M([Connect(ii,1),Connect(ii,2)], 1), M([Connect(ii,1),Connect(ii,2)], 2),M([Connect(ii,1),Connect(ii,2)], 3), 'k', 'LineWidth', 2);
    else if Connectivity(ii,3) == 2; % Drew Double Bonds
            plot3(M([Connect(ii,1),Connect(ii,2)], 1), M([Connect(ii,1),Connect(ii,2)], 2),M([Connect(ii,1),Connect(ii,2)], 3), 'b', 'LineWidth', 4);
        else if Connectivity(ii,3) == 3; % Draw Triple Bonds
                plot3(M([Connect(ii,1),Connect(ii,2)], 1), M([Connect(ii,1),Connect(ii,2)], 2),M([Connect(ii,1),Connect(ii,2)], 3), 'r', 'LineWidth', 8);
            else if Connectivity(ii,3) == 4; % Draw Aromatic Bonds
                    plot3(M([Connect(ii,1),Connect(ii,2)], 1), M([Connect(ii,1),Connect(ii,2)], 2),M([Connect(ii,1),Connect(ii,2)], 3), '--b', 'LineWidth', 4);
                end
            end
        end
    end
end

%% Atom Labels
% Label atoms with corresponding number from file
for ii = 1:size(Atoms,1);
    atomLabel = ii;
    text(M(ii,1), M(ii,2), M(ii,3), ['     ',num2str(atomLabel)], 'FontSize', 12)
    hold on
end

hold off

end

