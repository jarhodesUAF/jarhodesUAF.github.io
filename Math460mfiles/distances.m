function [dJC, dK2, dLD]=distances(A)
% distances.m
%
% usage: [dJC, dK2, dLD]=distances(seqarray)
%
% Compute distances between all pairs of sequences, using
% Jukes-Cantor, Kimura-2, and Log-Det formulas
%
% seqarray is an array with each row a sequence in A,G,C,T;
% Entry (i,j) in output matrices is distance from sequence
% in ith row of seqarray to that in jth row.
% Output matrices give, in order, Jukes-Cantor, K2, and 
% log-det (paralinear) distances.
%
% 8/2/03

[n L]=size(A); %n=#of taxa, L=length of sequences
dJC=zeros(n,n);
dK2=zeros(n,n);
dLD=zeros(n,n);
for i=1:n
   for j=1:n
      F=compseq(A(i,:),A(j,:));
      dJC(i,j)=distJC(F);
      dK2(i,j)=distK2(F);
      dLD(i,j)=distLD(F);
      end
end

