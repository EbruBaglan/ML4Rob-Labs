function [J_MSE_training, J_MSE_test] = Task3_4(percentage)

% data is read, turned into matrix,
% row number N is taken
T = readmatrix('mtcarsdata-4features.csv');
[N , ~]= size(T);

% first column has only names, getting rid of that
% columns except for the first one are taken
data = T(:,2:5);

% taking pencentage% of data,
% also rounding in case it is not an integer
m = round(N*percentage);

% preallocation for some matrices
x = ones(m,4); t = zeros(m,1);
% here are for remaining 100-percentage%
x_rem = ones(N-m,4); t_rem = zeros(N-m,1);

% random index numbers are chosen
random = randperm(N,m)';

% remaining elements' indexes are obtained here 
totalnumbers = ones(N,1);
for i = 1:N
    totalnumbers(i,1) = i;
end
rem_index = setdiff(totalnumbers,random);

% percentage% of data random data chosen
% and taken to 2:4 columns, as first one should be 1 for x
for i = 1:m
    x(i,2:4) = data(random(i,1),2:4);
    t(i,:) = data(random(i,1),1);
end

% For remaining data
for i = 1:N-m
    x_rem(i,2:4) = data(rem_index(i,1),2:4);
    t_rem(i,:) = data(rem_index(i,1),1);
end

% multi-dimensional w is found through Moore-Penrose pseudoinverse
w_multi = ((x' * x )^(-1) )* x' * t;

% model is obtained as y (estimated)
% and compared to t (real) for training data 
y = zeros(m,3);
J_MSE_training = zeros(1,3);

for j = 1:3
    % model is obtained here
    y(:,j) = w_multi(1,1) + (w_multi(j+1,1) * x(:,j+1));
    a = 0;
    sum_diff = 0;
    for i = 1:m
        sum_diff = a + (y(i,j)-t(i,1))^2;
        a = sum_diff;
    end
    % loss for training data is calculated
    J_MSE_training(1,j) = sum_diff/m;
end

% model is applied to remaining data (test data),
% and compared with t (real)
y_rem = zeros(N-m,3);
J_MSE_test = zeros(1,3);

for j = 1:3
    y_rem(:,j) = w_multi(1,1) + (w_multi(j+1,1) * x_rem(:,j+1));
    b = 0;
    sum_diff_rem = 0;
    for i = 1:N-m
        sum_diff_rem = b + (y_rem(i,j)-t_rem(i,1))^2;
        b = sum_diff_rem;
    end
    J_MSE_test(1,j) = sum_diff_rem/(N-m);
end

end