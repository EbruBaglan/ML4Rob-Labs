function [J_MSE_training, J_MSE_test] = Task3_1(percentage)
T = readtable('turkish-se-SP500vsMSCI.csv');
data = table2array(T);
[N , ~]= size(data);

% taking percentage% as described in problem statement,
% also rounding in case it is not an integer
m = round(N*percentage);

% preallocation for some matrices
% x, t are for 5% choice
x = zeros(m,1);
t = zeros(m,1);
x_times_t = ones(m,1);
x_square = ones(m,1);
% here are for remaining 95%
x_rem = zeros(N-m,1);
t_rem = zeros(N-m,1);

% two random numbers are chosen to draw two w lines
random = randperm(N,m)';

% remaining elements'indexes are obtained here 
totalnumbers = ones(N,1);
for i = 1:N
    totalnumbers(i,1) = i;
end
rem_x1 = setdiff(totalnumbers,random);

% For 5% of data
for i = 1:m
    x(i,1) = data(random(i,1),1);
    t(i,1) = data(random(i,1),2);
    % Necessary calculations are made
    x_times_t(i,1) = x(i,1)*t(i,1);
    x_square(i,1) = x(i,1)^2;
end

% w is calculated accordingly
w  = sum(x_times_t(:,1))/sum(x_square(:,1));

% For chosen 5% data
a = 0;
y = zeros(m,1);
for i = 1:m
    y(i,1) = w * x(i,1);
    sum_diff = a + (y(i,1)-t(i,1))^2; 
    a = sum_diff;
end

J_MSE_training = sum_diff/m;

% For remaining 95% of data
for i = 1:N-m
    x_rem(i,1) = data(rem_x1(i,1),1);
    t_rem(i,1) = data(rem_x1(i,1),2);
end

% For remaining 95% data
b = 0;
sum_diff_rem = 0;
y_rem = zeros(N-m,1);
for i = 1:N-m
    y_rem(i,1) = w * x_rem(i,1);
    sum_diff_rem = b + (y_rem(i,1)-t_rem(i,1))^2;
    b = sum_diff_rem;
end

J_MSE_test = sum_diff_rem/(N-m);

end