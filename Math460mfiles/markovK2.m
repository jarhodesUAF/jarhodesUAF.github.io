function M=MarkovK2(b,c)
% MarkovK2.m
%
% usage: M=MarkovK2(a)
%
% create a 4x4 Kimura 2-parameter matrix with parameters b,c
%
% 8/2/03

M=[1-b-2*c b c c; b 1-b-2*c c c;c c 1-b-2*c b;c c b 1-b-2*c];

