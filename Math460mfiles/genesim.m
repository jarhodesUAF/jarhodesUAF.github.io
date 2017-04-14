%  genesim.m
%
%  Genetic Drift Program (with selection option)
%
%  The user is asked for an initial population size, number of generations,
%  and whether to use relative fitness values.  Then by clicking on
%  an initial allele frequency, the frequency as a function of time will be
%  graphed. 
%
%  8/2/03


% reset the state of the random number generator 
rand('state',sum(100*clock));

disp(' ')
disp('Enter the size N of the population:'); 
popsize=input('(Default is N = 50) ');
if isempty(popsize) popsize=50; end;
% 
disp(' ')
n=input('Enter the number of generations for iteration: (Default is n = 100) ');
if isempty(n) n=100; end;
%
disp(' ')
selection=input('Do you want to model the effect of natural selection? (Y/N) ','s');
if isempty(selection)
    selection = 'N';
end;
if (selection == 'y') 
    selection = 'Y';
end;
if (selection == 'Y') 
    fAA = input('     Enter the relative fitness value for genotype AA: ' );
    fAa = input('     Enter the relative fitness value for genotype Aa: ' );
    faa = input('     Enter the relative fitness value for genotype aa: ' );
end;
%
disp(' ')
disp('Position the cursor on the graph to choose initial frequency and')
disp('click to iterate. Press `d'' to display numerical values for the')
disp('most recent sequence of iterations.  Press any other key to exit.')
disp('  ')
disp('Hit any key to begin.')
pause
%
figure;                           % set up display of new figure
axis([0 n 0 1]); grid on;    
xlabel('Generations');ylabel('Allele Frequency p');
title(['Change in allele frequency for population of size ',int2str(popsize)]); 
hold on;
%
times=[0:n];                      % generate time vector for plotting
color='brgmkyc';                  % generate ColorOrder for plotting
colorindex=0;
% 
newcontinue=1;
while newcontinue                 % loop until non-left button is hit
    [t,p,button]=ginput(1);       % get initial population
    if button==1
        pops=p;
        if selection=='Y'         % with selection coefficients
            for i=1:n
                AA=p^2*fAA;
                Aa=2*p*(1-p)*fAa;
                aa=(1-p)^2*faa;
                newtot=AA+Aa+aa;
                AA=AA/newtot;
                Aa=Aa/newtot;
                aa=aa/newtot;
                p=AA+.5*Aa;
                p=(sum(rand(1,2*popsize)<p))/(2*popsize);
                pops=[pops,p];
            end
        else
            for i=1:n             % build up vector of iterated populations
                p=(sum(rand(1,2*popsize)<p))/(2*popsize);
                pops=[pops,p];
            end
        end
        % plot time vs. population
        plot(times,pops,color((mod(colorindex,7)+1)));         
        colorindex=colorindex+1;  % change color of subsequent graphs
    elseif button==100            % if user hits `d' for display
        [times;pops]'             % print last times and populations 
        newcontinue=1; 
    else 
        newcontinue=0;            % don't loop again
    end
end
%
hold off
