clc
clear
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% TASK 2_1/2 : One dimensional Turkish Stock Exchange w/o intercept %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% data is read, turned into matrix,
% row number N and and column number c is taken
T = readtable('turkish-se-SP500vsMSCI.csv');
data = table2array(T);
[N , ~]= size(data);

% taking 10% as described in problem statement,
% also rounding in case it is not an integer
percentage = 0.1;
m = round(N*percentage);

% preallocation for some matrices
% x, x2, t, t2 are for random choices
% xf, xl, tf, tl are for first-last choices
x = zeros(m,1);
t = zeros(m,1);
x2 = zeros(m,1);
t2 = zeros(m,1);
xf = zeros(m,1);
tf = zeros(m,1);
xl = zeros(m,1);
tl = zeros(m,1);
x_times_t = ones(m,1);
x_square = ones(m,1);
x_times_t2 = ones(m,1);
x_square2 = ones(m,1);
x_times_tf = ones(m,1);
x_squaref = ones(m,1);
x_times_tl = ones(m,1);
x_squarel = ones(m,1);

% two random numbers are chosen to draw two w lines
random = randperm(N,m)';
random2 = randperm(N,m)';

for i = 1:m
    x(i,1) = data(random(i,1),1);
    t(i,1) = data(random(i,1),2);
    x2(i,1) = data(random2(i,1),1);
    t2(i,1) = data(random2(i,1),2);
    xf(i,1) = data(i,1);
    tf(i,1) = data(i,2);
    xl(i,1) = data(N-i+1,1);
    tl(i,1) = data(N-i+1,2);
    % Necessary calculations are made
    x_times_t(i,1) = x(i,1)*t(i,1);
    x_square(i,1) = x(i,1)^2;
    x_times_t2(i,1) = x2(i,1)*t2(i,1);
    x_square2(i,1) = x2(i,1)^2;
    x_times_tf(i,1) = xf(i,1)*tf(i,1);
    x_squaref(i,1) = xf(i,1)^2;
    x_times_tl(i,1) = xl(i,1)*tl(i,1);
    x_squarel(i,1) = xl(i,1)^2;
end

% w are calculated accordingly
w1  = sum(x_times_t(:,1))/sum(x_square(:,1));
w2  = sum(x_times_t2(:,1))/sum(x_square2(:,1));
wf  = sum(x_times_tf(:,1))/sum(x_squaref(:,1));
wl  = sum(x_times_tl(:,1))/sum(x_squarel(:,1));

% x range is defined for graphical purposes
x = linspace(-0.06,0.08,30);

% y are calculated with found w values
y1 = w1 * x;
y2 = w2 * x;
yf = wf * x;
yl = wl * x;

% Figures are drawn
figure(1)
% Window size and position are defined - cosmetic concerns
set(gcf, 'Position',  [100, 100, 1200, 500])
movegui('center')

% first graph initialized
subplot(121)
plot(x,y1,'r','DisplayName',strcat('w1=',num2str(w1))); hold on
plot(x,y2,'b','DisplayName',strcat('w2=',num2str(w2))); hold on
title('Turkish Stock Exchange Data (random 2 choices)')
xlabel('x values of dataset');
ylabel('Corresponding y values of dataset'); hold on
plot(data(:,1),data(:,2),'O','color',[0, 0.4470, 0.7410]);
legend('show');

% second graph initialized
subplot(122)
plot(x,yf,'r','DisplayName',strcat('wf=',num2str(wf))); hold on
plot(x,yl,'b','DisplayName',strcat('wl=',num2str(wl))); hold on
title('Turkish Stock Exchange Data (first and last choices)')
xlabel('x values of dataset');
ylabel('Corresponding y values of dataset'); hold on
plot(data(:,1),data(:,2),'O','color',[0, 0.4470, 0.7410]); hold off
legend('show')