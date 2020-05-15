function [locs] = top_and_bottom_votes(G, votes_for_candidate, fid, verbose)
%This function finds the top and bottom votes.
%it returns the locations of the #1 votes of the lowest vote getter
%It needs the main table as well as the extracted votes_for_candidate and
%the fid for the fprintf
%verbose is if you want to see the output written
top_votes=[];
Number_of_Candidates = width(G);

for i = 1:Number_of_Candidates
top_votes(i)=votes_for_candidate{i}(1,2);
end

if(verbose)
tf=top_votes==max(top_votes); %Report on the vot getting with the most top choices
locs=find(tf);
for i=1:length(locs)
    votes=votes_for_candidate{locs(i)};
    name_of_candidate=G.Properties.VariableNames(locs(i));
    outputstr = [name_of_candidate{1}, ' has the highest number of votes with %i (%.2f%%)\n'];
    fprintf(fid,outputstr,votes(1,2),votes(1,3).*100);
end
end

tf=top_votes==min(top_votes); %Report on the vot getting with the least top choices
locs=find(tf); %we need these locations for the least vote getting to redestribut the votes and then to delete that candidate.
if(verbose)
for i=1:length(locs)
    votes=votes_for_candidate{locs(i)};
    name_of_candidate=G.Properties.VariableNames(locs(i));
    outputstr = [name_of_candidate{1}, ' has the lowest number of votes with %i (%.2f%%)\n'];
    fprintf(fid,outputstr,votes(1,2),votes(1,3).*100);
end
end


end

