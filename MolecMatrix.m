function [ M, Atoms, numatoms, Connectivity] = MolecMatrix( filename )
%MolecMatrix Summary: Function to calculate the molecular matrix (M)
% This function extracts coordinates from a .sdf file and generates the
% molecular matrix (M). This function also extracts the connectivity table
% and creates a separate matrix for this information. The connectivity
% table contains the bond information.
%
% See Also: R3mCalculate, ImportSDF
%
% Author: Kevin DeBoyace & Mustafa Bookwala
%         Wildfong Lab
%         Duquesne University
% Updated: Jan 2019

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
delimiter = ' ';
startRow = 2;
formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';
fileID = fopen(filename,'r');

dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'ReturnOnError', false);
fclose(fileID);
for ii = 1:size(dataArray{1,1},1)
    for jj = 1:size(dataArray,2)
        dataArraynum(ii,jj) = str2double(dataArray{1,jj}{ii});
    end
end

%% Separate merged atom connections.

% The .sdf text file uses space as a delimiter, however when the atoms are
% beyond 99, the delimiter space is absent. This results in a code error. 
% Code below overcomes this problem. This code has been tested for 
% molecules containing atoms until 203. This code should function without issues
% for molecules containing atoms less than 1000.

X = dataArraynum(:,1); 
[Row] = find(X>1000 & X<X(3,1)); %Extract the rows that contain unrealistic atom number


for i = 1:size(Row,1) %For loop to scan the X matrix at specific rows for segregation
    if ceil(log10(X(Row(i),1))) == 4 %if/elseif loop to determine and segregate based on the digits present
        AtomCon1(i,:) = num2str(X(Row(i),1)); 
    elseif ceil(log10(X(Row(i),1))) == 5
        AtomCon2(i,:) = num2str(X(Row(i),1));
    elseif ceil(log10(X(Row(i),1))) == 6
        AtomCon3(i,:) = num2str(X(Row(i),1));
    elseif ceil(log10(X(Row(i),1))) == 7
        AtomCon4(i,:) = num2str(X(Row(i),1));
    end
end
 
BondType = dataArraynum(Row,2); %Extract connectivity information for these atoms

%While loop - if variable exists, breakdown the two atoms as strings and then 
% convert back to numeric followed by concatenating
while exist('AtomCon1') == 1; 
    atom1 = str2num(AtomCon1(:,1));
    atom2 = str2num(AtomCon1(:,2:end));
    Digit4 = [atom1 atom2];
    break
end

while exist('AtomCon2') == 1;
    atom3 = str2num(AtomCon2(:,1:2));
    atom4 = str2num(AtomCon2(:,3:end));
    Digit5 = [atom3 atom4];
    break
end

while exist('AtomCon3') == 1;
    atom5 = str2num(AtomCon3(:,1:3));
    atom6 = str2num(AtomCon3(:,4:end));
    Digit6 = [atom5 atom6];
    break
end

while exist('AtomCon4') == 1;
    atom7 = str2num(AtomCon4(:,1:4));
    atom8 = str2num(AtomCon4(:,5:end));
    Digit7 = [atom7 atom8];
    break 
end

%Compile all the connections back 
Compiled = [];
  if exist('Digit4') == 1
      Compiled = [Compiled; Digit4];
  end
  if exist('Digit5') == 1    
      Compiled = [Compiled; Digit5];
  end
  if exist('Digit6') == 1
      Compiled = [Compiled; Digit6];
  end
  if exist('Digit7') == 1
      Compiled = [Compiled; Digit7];
  end

Compiled = [Compiled BondType]; %Final matrix with correctly separated information

dataArraynum(Row,1:3)= Compiled(:,:); %Replace the separated atoms and connectivity information in their right location

%% Extract cartesian coordinates from file and place them in a single matrix.
dataArraynum_cut = dataArraynum(:,1:3); %Take first three columns
datarem = rem(dataArraynum_cut,1);
jj = 1;
for ii = 1:size(dataArraynum_cut, 1);
    if sum(datarem(ii,:)) == 0 || isnan(datarem(ii,1))
        temp_rem(ii) = 0; 
    else
        temp_rem(ii) = 1; 
        coords(jj,:) = dataArraynum_cut(ii,:);
        Atoms(jj,:) = dataArray{1,4}(ii); % Extract atom names
    end
    jj = jj+1;
end

for ii = 1:size(Atoms,1)
    temp_emp(ii) = isempty(Atoms{ii});
    try
        temp(ii) = str2num(Atoms{ii});
    catch
        temp(ii) = 0;
    end
end
[row,col] = find(temp ~= 0 | temp_emp == 1);
Atoms(col) = [];
coords(col,:) = [];

[r,c] = size(Atoms);

Message = sprintf('Molecule contains %d atoms', r);
msgbox(Message);

M = coords; % Matrix of cartesian coordinates
clear ii jj

numatoms = size(M,1);

%% Connectivity table
jj = 1;

for ii = 1:size(dataArraynum_cut,1)
    if (sum(datarem(ii,:))) == 0 && ~isnan(datarem(ii,1)) && sum(dataArraynum_cut(ii,1:3)~=0) == 3 %For those numbers which are part of connectivity or NaN --> delete
        e(jj,:) = dataArraynum_cut(ii,:); %Build matrix with connectivity data
        jj = jj + 1;
    else
        jj = jj;
    end
end

Connectivity = e;

clear ii jj d e f %Clear Temp variables

end

