### R3mCalculate ###

A function to calculate the molecular descriptor R3m. 

This function calculates the molecular matrix (M), geometry matrix (G), molecular influence matrix (H), and influence distance matrix (R). This is accomplished by calling the following subfunctions: ImportSDF, MolecMatrix, EuclidDistance, MolecInfluenceMatrix, and InfluenceDistanceMat. This function currently only works for SDF files. Other file formats can be converted to SDF using OpenBabel. When the code is run, the user is prompted to select an SDF file. Next, the molecule is plotted using the PlotMolecule function to ensure the 3D coordinates are reasonable. Finally, the R3m value is calculated and output to the command window and workspace.

---------------------------------------------------------------------------------------------
NOTE: The R3mCalculate function is the primary function. The other functions and scripts are 
      referenced by this function. The user will only need to run the R3mCalculate function:
      e.g. [R3m] = R3mCalculate;
---------------------------------------------------------------------------------------------


References: 
  [1] Todeschini, R.; Consonni, V., Molecular Descriptors for Chemoinformatics, Volume 
      41 (2 Volume Set). 2nd ed.; John Wiley & Sons: 2009.
  [2] Consonni V, Todeschini R, Pavan M, Gramatica P 2002. Structure/response correlations 
      and similarity/diversity analysis by GETAWAY descriptors. 2. Application of the novel 
      3D molecular descriptors to QSAR/QSPR studies. Journal of chemical information and 
      computer sciences  42(3):693-705.
  [3] Tetko, I. V.; Gasteiger, J.; Todeschini, R.; Mauri, A.; Livingstone, D.; Ertl, P.; 
      Palyulin, V. A.; Radchenko, E. V.; Zefirov, N. S.; Makarenko, A. S.  Virtual 
      computational chemistry laboratory–design and description. J. Comput. Aided Mol. 
      Des. 2005, 19, (6), 453-463.
  [4] DeBoyace, K.; Buckner, I. S.; Gong, Y.; Ju, T.-c. R.; Wildfong, P. L. D.  Modeling 
      and Prediction of Drug Dispersability in Polyvinylpyrrolidone-Vinyl Acetate Copolymer 
      Using a Molecular Descriptor. J. Pharm. Sci. 2018, 107, (1), 334-343.

R3m can also be calculated online with appoximately 1600 other descriptors at http://www.vcclab.org/lab/edragon/

 
 Author: Kevin DeBoyace
	 Wildfong Lab
         Duquesne University
  
 Last Updated: January 2019