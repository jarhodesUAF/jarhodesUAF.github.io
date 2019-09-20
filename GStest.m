n=5

A=rand(n,n);
[Q,R]=GS(A);
    
Q'*Q-eye(n)
norm(Q'*Q-eye(n),'fro')
A-Q*R
norm(A-Q*R,'fro')

