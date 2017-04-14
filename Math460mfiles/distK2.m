function d=distK2(F)
% distK2.m
%
% usage: d=distK2(F)
%
% F is a 4x4 frequency array from comparing two sequences
% (e.g., by using compseq.m). Output is Kimura 2-parameter
% distance between sequences.
%
% 8/2/03

N=sum(sum(F));
p1=(F(1,2)+F(2,1)+F(3,4)+F(4,3) )/N;
p2= sum(sum(F(1:2,3:4)+F(3:4,1:2)))/N;
d=(-1/2)*log(1-2*p1-p2)-(1/4)*log(1-2*p2);
