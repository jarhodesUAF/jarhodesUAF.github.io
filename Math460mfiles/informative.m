function sites=informative(seqarray)
% informative.m
%
% usage: sites=informative(seqarray)
%
% Each row of seqarray should be a sequence in A,G,C, and T, 
% with one row per taxa;
% sites returns the indices of columns with at least 2 bases 
% appearing at least twice each. These are the informative 
% sites of the method of maximum parsimony.
%
% 8/2/03

[m,n]=size(seqarray);
if m<4 
   disp('Too few sequences.')
end

As=( (sum(seqarray=='A')) > 1 );
Gs=( (sum(seqarray=='G')) > 1 );
Cs=( (sum(seqarray=='C')) > 1 );
Ts=( (sum(seqarray=='T')) > 1 );

sites=find( (As+Gs+Cs+Ts)>1 );
