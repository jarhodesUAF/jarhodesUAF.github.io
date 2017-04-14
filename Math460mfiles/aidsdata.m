% aidsdata.m
%
% aidsdata.m defines the variables:
%
% "casesJan1982_Dec2000" -- 228-entry vector of monthly number of AIDS cases 
%        reported to the CDC from Jan 1982 - Dec 2000. The number of cases 
%        reported by Dec 31, 1981 is 158. This is not included in 
%        casesJan1982_Dec2000, since the month of reporting is unknown.
%
% "cases1982_2000"  -- 19-entry vector of yearly number of AIDS cases reported 
%        to the CDC from 1982 - 2000
%
% "cmlJan1982_Dec2000"   monthly cumulative number of cases from Jan 1982 - Dec 2000
% "cmlJan1982_Dec1987"   monthly cumulative number of cases from Jan 1982 - Feb 1993
%
% "cml1981_2000"         yearly cumulative number of cases for 1982-2000
% "cml1981_1987"         yearly cumulative number of cases used in textbook example
%
% Note: All cumulative counts are total number of AIDS cases reported from
% first recognition of AIDS up to and including the specified month or year.
% Thus these all include the 158 cases reported before Dec 31, 1981.
%
% Data is originally from CDC website. 
% Warning: Surveillance definition of AIDS changed in 1987 and 1993
%
% 8/2/03

casesJan1982_Dec2000=[
   21 17 26 30 39 68 55 68 58 53 66 108 114 106 106 113 140 197 197 248 186 195 ...
      173 245 280 217 331 326 363 367 360 421 336 410 462 538 482 461 637 636 713 ...
      697 843 738 658 782 754 855 960 852 1055 1276 1154 893 1100 1176 1278 1559 ...
      838 1034 1200 1416 2180 1627 899 2001 1790 1830 1159 2152 2307 3090 1914 2428 ...
      2900 3073 2761 2510 2961 3072 2388 2156 2690 3025 2440 2836 2845 3341 2844 ...
      2948 2444 3471 2975 3126 3047 2638 3960 3306 3368 4204 3655 3588 3565 3596 ...
      5042 2774 2557 3528 3065 3657 4061 3011 4227 3651 4067 4693 4123 3713 3359 ...
      3584 3316 3983 4699 3822 4319 3716 7224 744 4359 3963 3699 3489 7040 7505 ...
      21260 6784 10331 8304 7598 8506 9294 5209 6145 6937 7095 4372 9012 5974 6216 ...
      7369 6360 7813 7554 5854 6181 5370 5505 6045 8411 4909 5572 6104 6833 5238 ...
      7258 5133 6123 6048 4551 5621 6782 5141 6522 6302 5962 5562 6397 5351 5668 ...
      4484 4804 5158 5476 4667 5290 5447 4440 4920 5046 4779 4224 5737 3206 4387 ...
      4875 4211 4062 4053 3637 4163 3952 3689 3715 3825 3160 3996 4629 3419 3898 ...
      4655 3317 3993 3899 3437 3626 4114 2800 3606 3146 3539 3739 3872 3415 3068 ...
      4013 2879 3128 4951]';

%% Compute number of AIDS cases by calendar year (1982-2000)
cases1982_2000=[];
for i=1:19
   tot=sum(casesJan1982_Dec2000(12*i-11:12*i));
   cases1982_2000=[cases1982_2000; tot];
end;

%% Compute cumulative number of AIDS cases by month
cmlJan1982_Dec2000=[casesJan1982_Dec2000(1)+158]; 
for i=2:228 
   cmlJan1982_Dec2000=[cmlJan1982_Dec2000; cmlJan1982_Dec2000(i-1)+casesJan1982_Dec2000(i)]; 
end
cmlJan1982_Dec1987=cmlJan1982_Dec2000(1:72);

% Extract cumulative number of AIDS cases by year
cml1981_2000=[158; cmlJan1982_Dec2000(12*[1:19]) ];
cml1981_1987=cml1981_2000(1:7);

clear i j tot;
