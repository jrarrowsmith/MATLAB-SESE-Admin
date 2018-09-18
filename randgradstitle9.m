%script for random grads
%JRA Sept 17, 2018
%This feels like a hack but the cell arrays were difficult because 
%I had trouble referencing ranges of cells and then getting decent formatting

[num,txt] = xlsread('gradlisttitle9.xlsx'); 
%expects the file to look like: 
%column 1 | column 2
%name | M or F
women=[];
men=[];
for i=1:length(txt)
    if(strcmp(txt{i,2},'F'))
        women=[women i];
    end
    if(strcmp(txt{i,2},'M'))
        men=[men i];
    end
end

N=6; %5 plus one alternate
%select the women
randomwomen = randperm(length(women),N);
selectedwomen=cell(N,1);
for i=1:length(randomwomen)
    selectedwomen(i)=cellstr(txt{women(randomwomen(i))});
end
cell2table(selectedwomen)

%select the men
randommen = randperm(length(men),N);
selectedmen=cell(N,1);
for i=1:length(randommen)
    selectedmen(i)=cellstr(txt{men(randommen(i))});
end
cell2table(selectedmen)


