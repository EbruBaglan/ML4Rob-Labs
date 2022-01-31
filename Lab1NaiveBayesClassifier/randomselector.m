function [A2, B2] = randomselector(A,k)
% RANDOM SELECTOR divides given matrix into test and training matrices.
%   [A, B] = randomselector(C, k) divides C matrix into two matrices
% A and B where A has k rows, and B has the remaining rows randomly. 
% Every call gives different division as it is random.

[n, d] = size(A);
m = n - k;
A2 = zeros(k,d);
B2 = zeros(m,d);

x = 1:n;
y = x(randperm(numel(x),k));
z = setdiff(x,y);

for i = 1:k 
    A2(i,:) = A(y(1,i),:);
end

for i = 1:m
    B2(i,:) = A(z(1,i),:);
end

end