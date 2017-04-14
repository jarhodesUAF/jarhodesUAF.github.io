function seq2=mutatef(seq1,Markov)
% mutatef.m
%
% usage: seq2=mutatef(seq1,M)
%
% A function version of mutate.m
%
% Mutate seq1 according to Markov matrix M
%
% 8/2/03

base=['A' 'G' 'C' 'T'];

N=length(seq1);
current_bases=zeros(1,N);   % convert to 1,2,3,4 coding
for i=1:4                
   sites=find(seq1==base(i));
   current_bases(sites)=i;
end

Mcuts=[0 0 0 0; Markov(1,:); Markov(1,:)+Markov(2,:);
   Markov(1,:)+Markov(2,:)+Markov(3,:)];  %compute cutoffs for mutation

randmutate=rand(1,N);
new_bases=zeros(1,N); 
for i=1:N  %Loop through sites
   new_bases(i)= sum( randmutate(i) > Mcuts(:,current_bases(i)) ); %compute new base
end

seq2='';    % convert to `AGCT' sequence
for i=1:N     
   seq2=[ seq2   base(new_bases(i)) ];
end

