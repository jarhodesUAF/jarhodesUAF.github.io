function [Q,R] = GS(A)
%Perform classical Gram-Schmidt to obtain QR factorization
%coded by J.Rhodes
[m,n]=size(A);
Q=zeros(m,n); %allocate space for Q,R
R=zeros(n,n);
r=norm(A(:,1));% handle first vector
Q(:,1)=A(:,1)/r;
R(1,1)=r;
for i=2:n
    r=Q(:,1:(i-1))'*A(:,i); %inner products for projection of a-i
    w=A(:,i)-Q(:,1:(i-1))*r; % remove q_j components, j<i 
    n=norm(w);
    Q(:,i)=w/n;
    R(1:i,i)=[r;n];
end
end

