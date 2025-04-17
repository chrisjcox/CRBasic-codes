function [hdr1,hdr2,hdr3,hdr4,file,nvars] = cr1000x_reader(fname,begDir)
%
% C. Cox 
% August 2019
%
% cr1000x_reader reads .dat files form the loggers
%
% Relies on matlab function readtable, which nicely handles
% unexpected data types that occasionally appear in Campbell files, most
% notably "NAN", which importdata cannot interpret.
%
% Arguments: 
%
%   fname  = name of the file you want to read (string)
%   begDir = directory path to fname
%
% Returns:
%
%   hdr1  = the first Campbell file header, which is metadata (logger serial number, compile results, etc)
%   hdr2  = the column header for the variable names
%   hdr3  = the column header for the variable units
%	hdr4  = the column header for the variable computation (e.g., sample, average, or standard devation).
%   file  = a matlab table containing the data. Works like a structure (file.variable; e.g., file.TIMESTAMP or file.PTemp_Avg)
%   nvars = number of variables (i.e., columns)       

% grab the header using importdata and do some string manipulation because readtable is picky
tmp = importdata([begDir,fname]);
nhdrs = size(tmp.textdata,1)-size(tmp.data,1);

% these are the headers
hdr1 = tmp.textdata(1,1);
hdr2 = tmp.textdata(2,1);
hdr3 = tmp.textdata(3,1);
hdr4 = tmp.textdata(4,1);

% CR1000X information as char format sans double quotes
hdr1 = erase(char(hdr1),'"');

% Variable Names as char format sans double quotes
hdr2 = erase(char(hdr2),'"');
% string parse by comma delimeter. now we have an array of nvars strings
% with the variables name column headers
hdr2 = string(strsplit(hdr2,','));

% Variable Units. As with variable names, but for the units.
hdr3 = strsplit(char(hdr3),',');

% There might some variables without units, so find those and make them say 'N/A
for k = 1:length(hdr3)
    tmp = char(hdr3(k));
    tmp = strrep(tmp,'"','');
    if isempty(tmp); tmp = 'N/A'; end
    hdr3(k) = {tmp};
end
hdr3 = string(hdr3);

% Sample type (some files). As with variable names, but for the storage parameters 
hdr4 = strsplit(char(hdr4),',');
% There might some variables without a value, so find those and make them say 'N/A
for k = 1:length(hdr4)
    tmp = char(hdr4(k));
    tmp = strrep(tmp,'"','');
    if isempty(tmp); tmp = 'N/A'; end
    hdr4(k) = {tmp};
end
hdr4 = string(hdr4);

% number of variables/columns
nvars = length(hdr2);

% Set the options that will be passed to readtable. Some of these are not
% apparently available before Matlab 2019!
% Note that these strings do need to be " and not '. This is a new matlab
% thing. Strings ("..") are now distinct from chars ('..') and I think have
% some special powers more like object oriented programming than array
% programming. 

% Setup the Import Options
opts = delimitedTextImportOptions("NumVariables",nvars);
% Specify range and delimiter
opts.DataLines = [nhdrs+1, Inf];                                        % begin reading at the first data line and Inf(inite) denotes unknown file size
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = hdr2;                                              % what are the columns I'm looking for?
opts.VariableTypes = cellstr(["datetime", repmat("double",1,nvars-1)]); % tell matlab that the first column is a datestring and that everything after that should be imported as a double
opts = setvaropts(opts, 1, "InputFormat", "yyyy-MM-dd HH:mm:ss");       % this is the format of the date used by Campbell
opts.ExtraColumnsRule = "ignore";                                       % ignore extra columns that were not specifid by hdr2 above
opts.EmptyLineRule = "read";                                            % for proper bean counting we should import NaNs if there is an empty line, but this probably won't happen 

% Import the data
% using readtable instead of importdata because importdata cannot deal with
%   some unexpected data types that appear (esp "NAN"). This is way faster 
%   than a line-by-line read too.
file = readtable([begDir,fname], opts);

end
% =========================================================================