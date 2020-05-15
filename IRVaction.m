function [G] = IRVaction(G, locs)
%JRA May 12, 2020
%This function does the ranked voting updates as Instant Runoff Voting
%Needs the main table G
%needs the locations of the 1 votes for the lowest candidate from
%top_and_bottom_votes function

Number_of_Candidates = width(G);
%Adjust votes with the lowest vote
name_of_candidate=G.Properties.VariableNames(locs(1));
candidate_votes = G.(name_of_candidate{1});
%These are the locations of the top votes for the lowest candidate. You can
%look at them with G(locs,:);
locs=find(candidate_votes==1);
votes_to_update=G{locs,[1:Number_of_Candidates]};
%this the first important step: decrement all the votes on the ballot by 1 
%(given that 1 is the top choice):
votes_to_update=G{locs,[1:Number_of_Candidates]}-1;
G{locs,[1:Number_of_Candidates]}=votes_to_update;
%Here is the second big step: get rid of candidate with lowest vote
G.(name_of_candidate{1})=[];


end

