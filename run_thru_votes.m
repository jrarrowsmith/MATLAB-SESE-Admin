function [votes_for_candidate] = run_thru_votes(G, fid, verbose)
%This function goes through the table of votes and tallies the votes
%foreach candidate and reports out
%G is the table of votes
%fid is the file id
%verbose is if you want it to print out everything (1 or 0)
%
%it returns a cell array of their listed votes
votes_for_candidate = {};
Number_of_Votes = height(G);
Number_of_Candidates = width(G);

for i=1:Number_of_Candidates
name_of_candidate=G.Properties.VariableNames(i);
candidate_votes = G.(name_of_candidate{1});
[C,ia,ic] = unique(candidate_votes);
a_counts = accumarray(ic,1);
votes_for_candidate{i} = [C, a_counts, a_counts./Number_of_Votes];

if(verbose)
fprintf(fid,name_of_candidate{1});
fprintf(fid,'\n');
[mrows, ncols] = size(votes_for_candidate{i});
outputstr = ['%' num2str(mrows) '.2f ']; % template for the string, you put your datatype here
outputstr = repmat(outputstr, 1, ncols); % replicate it to match the number of columns
outputstr = [outputstr '\n']; % add a new line if you want
fprintf(fid,outputstr, votes_for_candidate{i}.'); % write it
fprintf(fid,'\n');
end
end

%number of first votes per candidate
total = 0;
for i=1:Number_of_Candidates
name_of_candidate=G.Properties.VariableNames(i);
votes=votes_for_candidate{i};
outputstr = [name_of_candidate{1} ': %i\n'];
fprintf(fid,outputstr,votes(1,2));
total = total + votes(1,2);
end
fprintf(fid,'Total of the number 1 votes is %d\n',total); %this is a check for exhausted ballots
end

