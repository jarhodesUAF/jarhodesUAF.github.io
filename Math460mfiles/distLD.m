function d=distLD(F)
% distLD.m
%
% usage: d=distLD(F)
%
% F is a 4x4 frequency array from comparing two sequences
% (e.g., by using compseq.m). Output is log-det (paralinear) 
% distance between sequences.
%
% 8/2/03

f1=sum(F);
f2=sum(F');
d=(-1/4)*(log(det(F))-(1/2)*log( prod(f1)*prod(f2) ) );
