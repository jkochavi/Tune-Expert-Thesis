function properties = importMaterial(material, params)
% importMaterial This function imports the desired properties of a
% particular piezo material from the spreadsheet, Piezo_Materials.xlxs.
%
% material - A string containing the material to be imported.
%
% params - A string or array of strings containing the parameter(s) to be
% imported from the material.
%
% properties - An array of numbers containing the imported material
% properties.
properties = zeros(1,length(params));  % Init output of appropriate size
% Obtain the corresponding column to each material
switch material       % 
    case  '840'       % If material is 840  
        column = 'C'; %     Look in column C
    case  '841'       % If material is 841
        column = 'D'; %     Look in column D
    case  '850'       % If material is 850
        column = 'E'; %     Look in column E
    case  '854'       % If material is 854   
        column = 'F'; %     Look in column F
    case  '855'       % If material is 855
        column = 'G'; %     Look in column G
    case  '860'       % If material is 860
        column = 'H'; %     Look in column H  
    case  '880'       % If material is 880  
        column = 'I'; %     Look in column I
end
% Read all the variable names from the spreadsheet, store in cell array
var_names = table2array(readtable('Piezo_Materials.xlsx','Sheet','Sheet1','Range','B2:B23'));
% Create a range of values to look through in a particular column
range = [column,'3:',column,'23'];
% Import the material properties from a specific column
data = readmatrix('Piezo_Materials.xlsx','Sheet','Sheet1','Range',range);
for k = 1:length(params)                      % For each output parameteter
    if ismember(params(k), var_names)         %    If the parameter is a valid variable...
        index = find(var_names == params(k)); %         Find its index
        properties(k) = data(index);          %         Grab the corresponding value
    end
end
end