%  mutate.m 
%
%  Markov model of DNA mutation  
%
%  The user is asked for a Markov matrix, an initial sequence or an initial base 
%  distribution vector p and a sequence length N, and a number of timesteps. 
%  An initial DNA sequence of length N is generated according to p, if necessary. 
%  Then the sequence is mutated at each site according to M to produce a sequence 
%  one time step later, etc.
%
%  All sequences are printed, and stored as entries in 'Seq', for later use.
%
%  8/2/03


base=['A' 'G' 'C' 'T'];

disp('Enter an initial DNA sequence such as ''AACGCTTG'' using quotes,');
initseq=input('or hit return to produce sequence randomly: ');

if isempty(initseq)
   disp(' ')
   disp('Enter a base distribution vector, using order A, G, C, T. ');
   p=input('(Default is [.25 .25 .25 .25]): ');
   if isempty(p) p=[.25 .25 .25 .25]; end
   
   if (length(p)~=4 | (sum(p)-1)>.0000001 )
      error('Invalid vector');    
   end;
   
      
   disp(' ')
   N=input('Enter a sequence length (Default is 40): ');
   if isempty(N) N=40; end
   if (N<0 | N~=floor(N))
      error('Invalid length');
   end
   
     
   pcuts=[p(1) p(1)+p(2) p(1)+p(2)+p(3) 1];

   current_bases=zeros(1,N);                 % create empty array
   init=rand(1,N);                           % generate random numbers  
   for i=1:4                                 % and convert to base sequence
      sites=find(init<pcuts(i));             % . . . coded by 1,2,3,4
      current_bases(sites)=i;
      init(sites)=2;
   end
   
   initseq='';                               % convert to `AGCT' sequence
   for i=1:N     
      initseq=[ initseq   base(current_bases(i)) ];
   end
else                           % make sure user's sequence is valid 
   N=length(initseq);     
   valid=(initseq=='A') + (initseq=='G') + (initseq=='C')...
      + (initseq=='T');
   if sum(valid)~=N
      error('Invalid sequence');
   end
   
   current_bases=zeros(1,N);   % convert to 1,2,3,4 coding
   for i=1:4                
      sites=find(initseq==base(i));
      current_bases(sites)=i;
   end
   
end

% 
disp(' ')
Markov=input('Enter a 4x4 Markov matrix (columns must add to 1): ');
if ( sum( size(Markov)~=[4 4] )~=0 |  norm( [1 1 1 1]*Markov-[1 1 1 1] ) > .0000001)
   error('Invalid matrix'); 
end

% 
disp(' ')
T=input('Enter the number of time steps for iteration (Default is 1): ');
if isempty(T) T=1; end;
%     

% save initial sequence 
Seq=initseq; 

%compute cutoffs for mutation
Mcuts=[0 0 0 0; Markov(1,:); Markov(1,:)+Markov(2,:);
   Markov(1,:)+Markov(2,:)+Markov(3,:)];  
for t=1:T 
   randmutate=rand(1,N);
   new_bases=zeros(1,N); 
   
   %Loop through sites
   for i=1:N 
      %compute new base
      new_bases(i)= sum( randmutate(i) > Mcuts(:,current_bases(i)) ); 
   end
   
   % convert to `AGCT' sequence
   newseq='';                  
   for i=1:N     
      newseq=[ newseq   base(new_bases(i)) ];
   end
   
   Seq=[ Seq; newseq];      % save sequence
   current_bases=new_bases; % prepare to loop again
   
end

Sinit=Seq(1,:);
Sfinal=Seq(T+1,:);
disp(' ') 
disp('All sequences are stored in Seq') 
disp(' ')
msg=sprintf('Initial sequence is Sinit = %s', Sinit);
disp(msg)
msg=sprintf(' Final sequence is Sfinal = %s', Sfinal);
disp(msg)
