function [J_MSE_training, J_MSE_test] = Task3_2(percentage)

% data is read, turned into matrix,
% row number N is taken
T = readmatrix('mtcarsdata-4features.csv');
[N , ~]= size(T);

% columns except for the last one are taken
data = T(:,2:5);

% mpg and weight columns are taken for one dimensional regression
x_weight = data(:,4);
t_mpg = data(:,1);

% taking pencentage% of data as described in problem statement,
% also rounding in case it is not an integer
m = round(N*percentage);

% preallocation for some matrices
x_times_t = ones(N,1);
x_square = ones(N,1);
x = zeros(m,1);
t = zeros(m,1);
% here are for remaining 95%
x_rem = zeros(N-m,1);
t_rem = zeros(N-m,1);

% random index numbers are chosen
random = randperm(N,m)';

% remaining elements'indexes are obtained here 
totalnumbers = ones(N,1);
for i = 1:N
    totalnumbers(i,1) = i;
end
rem_index = setdiff(totalnumbers,random);

% For 0.05 of data random data chosen
for i = 1:m
    x(i,1) = x_weight(random(i,1),1);
    t(i,1) = t_mpg(random(i,1),1);
end

% mean values for x and t are found
x_bar = sum(x(:,1))/m;
t_bar = sum(t(:,1))/m;

for i = 1:m
    x_times_t(i,1) = (x(i,1)-x_bar)*(t(i,1)-t_bar);
    x_square(i,1) = (x(i,1)-x_bar)^2;
end

% w are calculated accordingly
w1 = sum(x_times_t(:,1))/sum(x_square(:,1));
w0 = t_bar - (w1*x_bar) ;

% model is obtained for one-dimensional case
a = 0;
sum_diff = 0;
y = zeros(m,1);
for i = 1:m
    y(i,1) = w1 * x(i,1) + w0;
    sum_diff = a + (y(i,1)-t(i,1))^2;
    a = sum_diff;
end

J_MSE_training = sum_diff/m;

% For remaining 95% of data
for i = 1:N-m
    x_rem(i,1) = x_weight(rem_index(i,1),1);
    t_rem(i,1) = t_mpg(rem_index(i,1),1);
end

% For remaining 95% data
b = 0;
sum_diff_rem = 0;
y_rem = zeros(N-m,1);
for i = 1:N-m
    y_rem(i,1) = w1 * x_rem(i,1) + w0;
    sum_diff_rem = b + (y_rem(i,1)-t_rem(i,1))^2;
    b = sum_diff_rem;
end

J_MSE_test = sum_diff_rem/(N-m);

end