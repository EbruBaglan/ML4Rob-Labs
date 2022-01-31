clc
clear
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% TASK 2_3 : One dimensional Motor Trends car data w/ intercept %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% data is read, turned into matrix,
% row number N and and column number c is taken
T = readmatrix('mtcarsdata-4features.csv');
[N , c]= size(T);

% columns except for the last one are taken
data = T(:,2:5);

% mpg and weight columns are taken for one dimensional regression
x_weight = data(:,4);
t_mpg = data(:,1);

% disp, hp, weight columns are taken as x for multi-dimensional regression
% mpg is taken as t as this will be predicted
% addition of one more column to x_multi for w_0 offset
x_multi = ones(N,4);
x_multi(:,2:4) = data(:,2:4);
t_multi = data(:,1);

% preallocation for some matrices
x_times_t = ones(N,1);
x_square = ones(N,1);

% mean values for x and t are found
x_bar = sum(x_weight(:,1))/N;
t_bar  = sum(t_mpg(:,1))/N;

for i = 1:N
    x_times_t(i,1) = (x_weight(i,1)-x_bar)*(t_mpg(i,1)-t_bar);
    x_square(i,1) = (x_weight(i,1)-x_bar)^2;
end

% one dimensional w's
w_1 = sum(x_times_t(:,1))/sum(x_square(:,1));
w_0 = t_bar - (w_1*x_bar) ;

% multi-dimensional w is found through Moore-Penrose pseudoinverse
w_multi = ((x_multi' * x_multi )^(-1) )* x_multi' * t_multi;

% x range is defined for graphical purposes
x  = linspace(1.5,5.5,8);

% model is obtained for one-dimensional
y = w_1 * x + w_0;

% model is obtained for multi-dimensional
y2 = w_multi(1,1) + (w_multi(2,1) * x_multi(:,2));
y3 = w_multi(1,1) + (w_multi(3,1) * x_multi(:,3));
y4 = w_multi(1,1) + (w_multi(4,1) * x_multi(:,4));

% Figure is drawn
figure(1)

% Window size and position are defined - cosmetic concerns
set(gcf, 'Position',  [100, 100, 1200, 500])
movegui('center')

% first graph initialized
subplot(121)
plot(x,y,'r','LineWidth',1);
title('Motor trends survey: The least squares solution')
xlabel('Car weight (lbs/1000)');
ylabel('Fuel efficiency (mpg)'); hold on; grid on
plot(x_weight, t_mpg,'X','color',[0 0 1],'LineWidth',1); hold off

% second graph initialized
subplot(122)
% real data are plotted
plot(x_multi(:,2)',t_multi','O','color',[0 0.4470 0.7410],'LineWidth',1,...
    'DisplayName',strcat('disp real')); hold on
plot(x_multi(:,3)',t_multi','O','color',[0.8500 0.3250 0.0980],'LineWidth',1,...
    'DisplayName',strcat('hp real')); hold on
plot(x_multi(:,4)',t_multi','O','color',[0.9290 0.6940 0.1250],'LineWidth',1,...
    'DisplayName',strcat('weight real')); hold on
title('Motor trends survey: Multi-dimensional solution')
xlabel('Car weight (lbs/1000), Displacement (cu.in), horse-power');
ylabel('Fuel efficiency (mpg)'); hold on
grid on
% estimated data are plotted
plot(x_multi(:,2)', y2','color',[0 0.4470 0.7410],'LineWidth',1,...
    'DisplayName',strcat('disp est')); hold on
plot(x_multi(:,3)', y3','color',[0.8500 0.3250 0.0980],'LineWidth',1,...
    'DisplayName',strcat('hp est')); hold on
plot(x_multi(:,4)', y4,'color',[0.9290 0.6940 0.1250],'LineWidth',1,...
    'DisplayName',strcat('weight est')); hold on
legend('show')
hold off

% colors, legends etc are here
% https://www.mathworks.com/help/matlab/ref/legend.html