%  sir.m
%
%  Difference equation SIR infectious disease model
%
%  The user is asked for equations defining the SIR model. Then by clicking
%  on initial SI populations, phase plane and time plots are produced
%  of a simulation.  Numerical data is displayed to the MATLAB command window
%  after each simulation.
%
%  8/2/03

s=.9;i=.1;r=0;      % initialize to check formulas evaluate ok

disp('Enter formulas for difference equations defining the model, using "s" to') 
disp('denote the susceptible class, "i" to denote the infective class, and "r"')
disp('to denote the removed class:')
disp('(Ex: next_s = s-.1*s*i')
disp('     next_i = i+.1*s*i-.05*i')
disp('     next_r = r+.05*i        )')
disp(' ')
%
next_s=input (' next_s = ','s');
s=eval(next_s);                    % check formula
next_i=input (' next_i = ','s');
i=eval(next_i);                    % check formula
next_r=input (' next_r = ','s');
r=eval(next_r);                    % check formula
% 
disp(' ')
disp('Enter the total population size N. Initial s and i will be entered')
totpop=input('graphically. Initial r satisfies s+i+r=N. (Default is N=1): ');  
if isempty(totpop) totpop=1; end;
limits=[0 totpop 0 totpop];

disp(' ')
n=input('Enter the number of time steps for iteration: (Default is T=100): ');
if isempty(n) n=100; end;

disp(' ')
disp('Position the cursor on the phase plane to choose initial populations')
disp('and click left to iterate. Hit any key to begin. Click right to quit.')

pause

% begin new figure at left top for phase plane
pp=figure('Units','normalized','Position',[.01,.3,.485,.6],... 
   'Name','Phase plane');                                 
hold on;
axis(limits); grid;      
xlabel('Susceptibles');ylabel('Infectives');
title(['next\_s=',next_s,'  next\_i=',next_i]);
plot([0 totpop] , [totpop 0],'k') % put in line above triangle of valid inputs 

% begin new figure at left right for time plot  
tp=figure('Units','normalized','Position',[.505,.3,.485,.6],... 
   'Name','Time plot');                                  
xlabel('Time');ylabel('Populations');         
title(['next\_s=',next_s,'  next\_i=',next_i, '  next\_r=',next_r]);

figure(pp)                 % go to phase plane figure
[s,i,button]=ginput(1);    % get initial populations 
r = totpop-s-i;                     % initial r value

while button==1            % loop until non-left button hit
   pops=[s;i;r];  
   for j=1:n                % loop to build up matrix of population values 
      news=eval(next_s);
      newi=eval(next_i);
      newr=eval(next_r);  
      s=news;
      i=newi;
      r=newr; 
      pops=[pops,[s;i;r]];
   end
   
   % plot orbit in phase space
   plot(pops(1,:),pops(2,:),pops(1,:),pops(2,:),'o');   
   
   % go to time plot figure and plot populations
   figure(tp)                                   
   plot([0:n], pops(1,:), [0:n], pops(2,:), [0:n], pops(3,:));      
   xlabel('Time');ylabel('Populations');      
   title(['next\_s=',next_s,'  next\_i=',next_i,'  next\_r=',next_r]);
   
   % display values to main window
   [[0:n]' pops']             
   
   % return to phase plane and get next initial populations
   figure(pp)                 
   [s,i,button]=ginput(1);  
   % compute initial r value
   r = totpop-s-i;       
end

hold off                     % end phase plane

