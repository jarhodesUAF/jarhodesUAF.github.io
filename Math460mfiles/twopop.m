%  twopop.m
% 
%  Two Species Population Model  
%
%  The user is asked for equations defining the model. Then by clicking
%  on an initial population, time and phase-plane plots of the population 
%  are produced.
%
%  8/2/03


p=0;q=0;                           % initialize to check formulas
%
disp('Enter formulas defining the population size of the two species,') 
disp('using "p" to denote the first species and "q" to denote the second:')
disp('(Ex: next_p = p+.4*p*(1-p/10)-.05*p*q')
disp('     next_q = q-.2*q+.08*p*q          )')
%
next_p=input ('next_p = ','s');
p=eval(next_p);                    % check formula
%
next_q=input ('next_q = ','s');
q=eval(next_q);                    % check formula
% 
disp(' ')
disp('Enter the limits for values of "p" and "q" to be displayed')
disp('graphically: (Default is [pmin pmax qmin qmax]=[0 10 0 10])')
%
limits=input('[pmin pmax qmin qmax] = ');
if isempty(limits) limits=[0 10 0 10]; end;
%
disp(' ')
n=input('Enter the number of time steps for iteration: (Default is n=100) ');
if isempty(n) n=100; end;
%
disp(' ')
disp('Position the cursor on the phase plane to choose initial populations')
disp('and click left to iterate. Hit any key to begin. Click right to quit.')
%
pause
%
% begin new figure at left for phase plane
pp=figure('Units','normalized','Position',[.01,.3,.485,.6],...   
   'Name','Phase plane');     
hold on;
axis(limits); grid;      
xlabel('Species p');ylabel('Species q');
title(['next\_p=',next_p,'  next\_q=',next_q]);
%
% begin new figure at right for time plot
tp=figure('Units','normalized','Position',[.505,.3,.485,.6],...   
   'Name','Time plot');                  
xlabel('Time');ylabel('Populations');         
title(['next\_p=',next_p,'  next\_q=',next_q]);
%
figure(pp)                 % go to phase plane figure
[p,q,button]=ginput(1);    % get initial populations 
%
while button==1            % loop until non-left button hit
   pops=[p;q];
   for i=1:n               % loop to build up matrix of population values 
      newp=eval(next_p);
      newq=eval(next_q);
      p=newp;
      q=newq;
      pops=[pops,[p;q]];
   end
   plot(pops(1,:),pops(2,:),pops(1,:),pops(2,:),'o');   % plot populations in phase space
   %
   figure(tp)                                    % go to time plot figure
   plot([0:n], pops(1,:), [0:n], pops(2,:));     % plot populations in last simulation
   xlabel('Time');ylabel('Populations');         
   title(['next\_p=',next_p,'  next\_q=',next_q]);
   %
   figure(pp)                                    % return to phase plane
   [p,q,button]=ginput(1);                       % get next initial populations 
end
%
hold off                                % end phase plane

