% cobweb.m
%
% Cobweb Plot for 1-population Difference Equation Model
%
% The user is asked for an equation defining the model.  Then by 
% clicking on an initial population, the "cobweb" of future populations
% will be graphed.
%
% 8/2/03

p=0;                                              % initialize population
%                             
disp ('Enter a formula defining the population model, using "p" to denote')
disp ('the size of the population:  (Ex:  next_p = p+1.8*p*(1-p/10) )')
next_p=input ('next_p = ','s');
if isempty(next_p) next_p='p+1.8*p*(1-p/10)'; end;
eval( [next_p ';']);                              % test formula
%  
disp (' ');
disp ('Enter the upper and lower extremes of population at time t to be ')
disp ('shown on the graph:')
limits=input('(Default is [pmin pmax]=[0 20])      [pmin pmax]= ');
if isempty(limits) limits=[0 20]; end;
pinc=(limits(2)-limits(1))/50;
x=limits(1):pinc:limits(2);
%
p=limits(1); y=eval (next_p);
for i=x(2):pinc:limits(2);                 % loop to create population vector
   p=i;                                        
   p=eval (next_p); 
   y=[y p]; 
end;
%
%
figure                                     % set up graphics
plot(x,y,x,x)
axis([limits(1),limits(2),limits(1),limits(2)]);    
xlabel ('population at time "t" ');
ylabel ('population at time "t+1"');
title (['next\_p=',next_p]);
%
continueb=1;                               % set boolean continue value to true
while continueb                            % loop until nonleft button is hit
   [p,q,button]=ginput(1);                 % get initial population
   if button==1
      %
      plot (x,y,x,x);                      %sets up graphics  
      axis([limits(1),limits(2),limits(1),limits(2)]);      
      hold on
      xlabel ('population at time "t" ');
      ylabel ('population at time "t+1"');
      title (['next_p=',next_p]);
      %
      for i=1:50;                             % loop to build cobweb sections
         w=p;                                
         p=eval (next_p);
         plot([w,w],[w,p],'k','EraseMode','none');   % plots vertical cobweb step
         pause(.1);
         if p<0; break; end;                 % eliminates negative population
         plot([w,p],[p,p],'k','EraseMode','none');   % plots horizontal cobweb step
         pause(.1);
      end;
      hold off;
   else continueb=0;                          % stop looping
   end
end
