%script to process voting for SESE
%JRA May 13, 2020
clear all
close all
clc

%set up committee
T = readtable('0_Demo.csv'); %exported candidate names and ballots
Committee_name = '0_Demo';
fileID=0; %1 to write to standard output otherwise give file name
if(fileID~=1)
    fileID=fopen(sprintf([Committee_name,'.txt']), 'w');
    time = datestr(clock,'YYYY/mm/dd HH:MM:SS:FFF');
    fprintf(fileID,'%23s\n',time);
end

how_many_passes = 4; %this is a bit trial and error


%start with some basic reporting
Number_of_Votes = height(T);
Number_of_Candidates = width(T);
outputstr = ['Reporting for ', Committee_name, '\n'];
fprintf(fileID,outputstr);
fprintf(fileID,'There are %d candidates and %d votes\n',Number_of_Candidates, Number_of_Votes);
fprintf(fileID,'\n');


%first pass:
fprintf(fileID,'Round # %i; Number of first votes per candidate:\n', 1);
[votes_for_candidate] = run_thru_votes(T, fileID,0);
[locs] = top_and_bottom_votes(T, votes_for_candidate, fileID, 1);

for j=2:how_many_passes
%find top and bottom votes
[locs] = top_and_bottom_votes(T, votes_for_candidate, fileID, 0);

fprintf(fileID,'\n');
fprintf(fileID,'Round # %i; Number of first votes per candidate:\n', j);
%Do the update to the voting list with the IRV
[T] = IRVaction(T, locs);

[votes_for_candidate] = run_thru_votes(T, fileID,0);
[locs] = top_and_bottom_votes(T, votes_for_candidate, fileID, 1);

end

if(fileID~=1)
    fclose(fileID);
end












