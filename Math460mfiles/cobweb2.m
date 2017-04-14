% cobweb2.m
%
% Cobweb Plot for 1-population Difference Equation Model
%
% The user is asked for an equation defining the model.  Then by 
% clicking on an initial population, the "cobweb" of future populations
% will be graphed.  Old web lines are gradually erased as time increases.
%
% 8/2/03

m=[];                                      
s=16;                                      % length of cobweb to draw 
p=0;                                       % initializes population for
%                                          % testing formula
disp (' ')
disp ('Enter a formula defining the population model, using "p" to denote')
disp ('the size of the population:  (Ex:  next_p = p+2.5*p*(1-p/10) ) ')
next_p=input ('next_p = ','s');
if isempty(next_p) next_p='p+2.5*p*(1-p/10)';
end;
p=eval (next_p);                           % tests population formula
%
disp (' ')
disp ('Enter the upper and lower extremes of population at time t to be')
disp ('shown on the graph:')
plimits=input ('(Default is [pmin pmax]=[0 20])      [pmin pmax]= ');
if isempty(plimits) plimits=[0 20]; end;
%
% Create data for plotting model
pinc=(plimits(2)-plimits(1))/20;            % sets up interval between
%                                           %         population values    
h=[plimits(1):pinc:plimits(2)];               
for k=1:21;                                 % loop to create next_p vector
   p=h(k);
   p=eval (next_p); 
   m=[m p];
end;
% begin a new figure with plot of model and diagonal line
figure;                                        
hold on;
axis([plimits plimits]);                       
curve=plot(h,m,'Color','b');
diag=plot(h,h,'Color','g');                    
xlabel (' population at time "t" ');
ylabel (' population at time "t+1" ');
title (['next\_p=',next_p] );
% create vector for handles for steps
stephan=ones(1,2*s);
button=1;

% get initial population from user 
disp(' ')
disp('Click left on initial population or click right to quit.')
[p,x,button]=ginput(1);                        
%
while(button==1)
   % 
   x=p;
   for i=1:s;                                  % loop to create beginning of cobweb
      p=eval (next_p);
      stephan(2*i-1)=plot([x;x],[x;p],'k','EraseMode','background');
      pause(.1); 
      stephan(2*i)=plot([x;p],[p;p],'k','EraseMode','background');
      pause(.1); 
      x=p; 
   end
   %
   for i=1:64;                                  % loop that removes start of web and adds new end
      p=eval(next_p);                           % calculate next population
      delete(stephan(1))                        % delete vertical line 
      stephan(1:2*s-1)=stephan(2:2*s);          %     and forget handle
      for k=1:2*s-1
         set(stephan(k),'EraseMode','background');% Redraw lines in case partially deleted
      end;
      set(curve,'Color','b');                   % redraw curves in case partially deleted
      set(diag,'Color','g');           
      stephan(2*s)=plot([x;x],[x;p],'k','EraseMode','background');%   add new line and save handl
      pause(.1);
      delete(stephan(1))                        % delete horizontal line
      stephan(1:2*s-1)=stephan(2:2*s);          %      and forget handle
      for k=1:2*s-1
         set(stephan(k),'EraseMode','background');% Redraw lines in case partially deleted
      end;
      set(curve,'Color','b');           % redraw curves in case partially deleted
      set(diag,'Color','g');           
      stephan(2*s)=plot([x;p],[p;p],'k','EraseMode','background');%   add new line and save handle
      x=p;                                      %   remember the new population
      pause(.1); 
   end
   % get initial population from user 
   disp(' ')
   disp('Click left on initial population or click right to quit.')
   [p,x,button]=ginput(1);                            
   if (button==1) delete(stephan); end;
   % 
end