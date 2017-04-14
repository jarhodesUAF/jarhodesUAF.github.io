function seq=seqgen(d,N)
% seqgen.m
%
% usage: seq=seqgen(d,N)
%
% generate a DNA sequence, with base distribution d (4x1)
% and length N bases; entries of d should add to 1
%
% 8/2/03

base=['A' 'G' 'C' 'T'];

%compute cutoffs for mutation
scuts=[0  d(1) d(1)+d(2) d(1)+d(2)+ d(3) ];  

randseq=rand(1,N);
new_bases=zeros(1,N); 
%Loop through sites
for i=1:N  
  new_bases(i)= sum( randseq(i) > scuts ); %compute new base
  end

% convert to `AGCT' sequence
seq='';    
for i=1:N     
    seq=[ seq   base(new_bases(i)) ];
end
    
