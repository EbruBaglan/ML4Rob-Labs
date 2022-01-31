clc
clear
close all

load('results.mat')

% Figures are drawn
figure(1)
% Window size and position are defined - cosmetic concerns
set(gcf, 'Position',  [100, 100, 1200, 500])
movegui('center')

% first graph initialized
subplot(121)
for i =1:11
    if i == 1
        textString = sprintf('k = %d', k(i,1));
        text(k(i,1)-0.9,accuracy(i,2)+0.0016, textString, 'FontSize', 9); hold on;
    elseif i < 6 && i ~= 1
        textString = sprintf('k = %d', k(i,1));
        text(k(i,1)+0.6,accuracy(i,2)+0.001, textString, 'FontSize', 9); hold on;
    elseif i ==7
        textString = sprintf('k = %d', k(i,1));
        text(k(i,1)+0.6,accuracy(i,2)+0.001, textString, 'FontSize', 9); hold on;
    end
end

plot(k,accuracy(:,2),'r'); hold on;
plot(k,accuracy(:,2),'r.', 'MarkerSize', 20); hold on;

title('Recognize 2 with various k values')
xlabel('k values');
ylabel('Accuracy of the kNN Classifier');
grid on;
hold off

% second graph initialized
subplot(122)
for i =1:11
    if i == 3
        textString = sprintf('k = %d', k(i,1));
        text(k(i,1)-1.8,accuracy(i,8)+0.001, textString, 'FontSize', 9); hold on;
    elseif i < 6 && i ~= 3
        textString = sprintf('k = %d', k(i,1));
        text(k(i,1)+0.6,accuracy(i,8)+0.001, textString, 'FontSize', 9); hold on;
    elseif i == 7
        textString = sprintf('k = %d', k(i,1));
        text(k(i,1)-2,accuracy(i,8)+0.001, textString, 'FontSize', 9); hold on;
    end
end

plot(k,accuracy(:,8),'b'); hold on;
plot(k,accuracy(:,8),'b.', 'MarkerSize', 20); hold on;

title('Recognize 8 with various k values')
xlabel('k values');
ylabel('Accuracy of the kNN Classifier');
grid on;
hold off

colors(1,:) = [0 0.4470 0.7410];
colors(2,:) = [0.8500 0.3250 0.0980];
colors(3,:) =[0.9290 0.6940 0.1250];
colors(4,:) =[0.4940 0.1840 0.5560];
colors(5,:) =[0.4660 0.6740 0.1880];
colors(6,:) =[0.3010 0.7450 0.9330];
colors(7,:) =[0.6350 0.0780 0.1840];
colors(8,:) =[1 0 0];
colors(9,:) =[0 0 1];
colors(10,:)=[0 1 1];


for i = 1:10
figure(i+1)
plot(k,accuracy(:,i),'color',colors(mod(i,7)+1,:)); hold on;
plot(k,accuracy(:,i),'.','MarkerSize', 20,'color',colors(mod(i,7)+1,:)); hold on;

title("Recognize " + mod(i,10)+ " with various k values")
xlabel('k values');
ylabel('Accuracy of the kNN Classifier');
grid on;
hold off
end


figure(12)
for i = 1:10
plot(k,accuracy(:,i),'color',colors(i,:),...
    'LineWidth',1,'DisplayName',sprintf('Digit %d',mod(i,10))); hold on;
end

title("Recognize all numbers with various k values")
xlabel('k values');
ylabel('Accuracy of the kNN Classifier');
grid on;
legend('show');
hold off

figure(13)
for i = 1:10
    if i == 7 || i ==8 || i==9 % i ==3 || i == 4 
    plot(k(1:6,1),accuracy(1:6,i),'color',colors(i,:),...
        'LineWidth',1,'DisplayName',sprintf('Digit %d',mod(i,10))); hold on;
    end
end

title("Recognize 7, 8, 9 with various k < 15 values")
xlabel('k values');
ylabel('Accuracy of the kNN Classifier');
grid on;
legend('show');
hold off