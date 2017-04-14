function d=distJC(F)
% distJC.m
%
% usage: d=distJC(F)
%
% F is a 4x4 frequency array from comparing two sequences
% (e.g., by using compseq.m). Output is Jukes-Cantor distance
% between sequences.
%
% 8/2/03

A=F-diag(diag(F));
p=sum(sum(A))/sum(sum(F));
d=(-3/4)*log(1-4*p/3);
