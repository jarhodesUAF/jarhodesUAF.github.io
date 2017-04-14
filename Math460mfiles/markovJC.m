function M=MarkovJC(a)
% MarkovJC.m
%
% usage: M=MarkovJC(a)
%
% create a 4x4 Jukes-Cantor matrix with parameter a
%
% 8/2/03

M=[1-a a/3 a/3 a/3; a/3 1-a a/3 a/3; a/3 a/3 1-a a/3; a/3 a/3 a/3 1-a];

