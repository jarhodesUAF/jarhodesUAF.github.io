function nj(D,varargin)
% nj.m
%
% usage: nj(Distarray, Names{:})  
%    or: nj(Distarray,'Name1','Name2',...,'Namen') 
%    or: nj(Distarray)
%
% Performs neighbor joining on distance data. 
%
% Distarray should be a square matrix with distances in 
% upper triangle (all other entries are ignored);
% Names should be a cell array with names of taxa.
% Otherwise names of taxa can be listed, or omitted.
% If Names is omitted, taxa are called S1, S2, etc.
%
% 8/2/03

[n,m]=size(D);
if n~=m 
   error('Matrix is not square.')
elseif n<3
   error('Must have at least 3 taxa.')
else
     
   N=n;            % save original size
   names=varargin; %   and names of taxa
   
     if isempty(names)
      for i=1:N
         names=[names, {['S',num2str(i)]} ];
      end
   end
   
   if sum(size(names)~=[1,N])
      error('Incorrect number of taxon names.')
   end
      
   D=triu(D,1); %wipe out diagonal and lower left triangle
   D=D+D';       %    and copy upper right triangle there
   
   while n>3 % iterative reduction of taxa to 3
      
      %step 1
      R=sum(D);% compute total distances from one taxon to all others
      M=(n-2)*D-ones(n,1)*R -R'*ones(1,n);% compute M array
      M=M + diag(NaN*ones(n,1));         %      set diagonals to NaN 
      [colmins, rowinds]=min(M);
      [minofM, colind] =min(colmins);
      rowind=rowinds(colind); % min entry of M is at (rowind,colind)
      % so taxa rowind and colind are to be joined 
      newvertex=['V',num2str(N-n+1)];% new internal vertex name
      
      disp(' ')
      disp(['Taxa ',names{colind},' and ',names{rowind},...
            ' are joined at ',newvertex])
      
      % step 2
      dVr=D(rowind,colind)/2+ (R(rowind)-R(colind))/(2*(n-2));
      dVc=D(rowind,colind)-dVr; %compute distances from joined taxa to new vertex
      
      disp(['Edge from ',names{colind},' to ',newvertex,...
            ' has length ',num2str(dVc)])      
      
      disp(['Edge from ',names{rowind},' to ',newvertex,...
            ' has length ',num2str(dVr)])
      disp('Hit enter to continue.')
      
      pause
      
      % step 3
      names([colind,rowind])=[];  %remove names of joined taxa
      names=[names,{newvertex}]; %    and add new internal vertex name
      
      newD=D; 
      newD([colind,rowind],:)=[]; %eliminate rows with entries from joined taxa
      newD=[newD, (newD(:,colind)+newD(:,rowind)-D(rowind,colind))/2]; % compute distances to new vertex
      newD(:,[colind,rowind])=[]; % eliminate columns with joined taxa
      n=n-1;
      D=[newD;newD(:,n)' 0];
      
   end
   
   %3 taxa remain for final fit
   
   
   newvertex=['V',num2str(N-n+1)];% new internal vertex name
   
   disp(' ')
   disp(['Taxa ',names{1},', ',names{2},', and ',names{3},...
         ' are joined at ',newvertex])
   
   
   d1=(D(1,2)+D(1,3)-D(2,3))/2;
   d2=(D(2,1)+D(2,3)-D(1,3))/2;
   d3=(D(3,1)+D(3,2)-D(1,2))/2;    
   disp(['Edge from ',names{1},' to ',newvertex,...
         ' has length ',num2str(d1)])      
   disp(['Edge from ',names{2},' to ',newvertex,...
         ' has length ',num2str(d2)])
   disp(['Edge from ',names{3},' to ',newvertex,...
         ' has length ',num2str(d3)])
   
end


