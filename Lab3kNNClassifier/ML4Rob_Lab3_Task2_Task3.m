clc
clear
close all

% Get the training observations and training classes.
[trainObs,trainClass] = loadMNIST(0);

% Get the test observations.
[testObs, testClass] = loadMNIST(1);

% OPTIONAL: FRAMING DATA INTERVAL
% Uncomment to take TRAINING data from an interval,
% specifying nLow and nUp values.
nLow = 1;
nUp = 10000;
nTrain = nUp - nLow + 1;

trainObsChosen   = trainObs(nLow:nUp, :);
trainClassChosen = trainClass(nLow:nUp, 1);

% Uncomment to take TEST data from an interval,
% % specifying mLow and mUp values.
mLow = 1001;
mUp = 1050;
nTest = mUp - mLow + 1;

testObsChosen = testObs(mLow:mUp, :);
testClassChosen = testClass(mLow:mUp, 1);

% END OF OPTIONAL: LIMITING DATA

% Uncomment to take all data.
% trainObsChosen   = trainObs;
% trainClassChosen = trainClass;
%
% testObsChosen = testObs;
% testClassChosen = testClass;

% k = 5;      % Choose k nearest-neighbour value.
%
% [labelResult, errorPer] = kNNClassifier(trainObsChosen,...
%     trainClassChosen,testObsChosen,k, testClassChosen);

% TASK 3: Test the kNN classifier
% Compute the accuracy on the test set on 10 tasks: each digit
% vs the remaining 9 (i.e., recognize whether the observation is
% a 1 or not; recognize whether it is a 2 or not; ...;
% recognize whether it is a 0 or not) and for for several values of k,
% e.g., k=1,2,3,4,5,10,15,20,30,40,50 (you can use these, or a subset
% of these, or add more numbers, and you can also implement the rule:
% "k should not be divisible by the number of classes," to avoid ties).
k = [1,2,3,4,5,10,15,20,30,40,50]';

accuracy = zeros(11,10);
for j = 1:11
    [labelResult, errorPer] = kNNClassifier(trainObsChosen,...
        trainClassChosen,testObsChosen,k(j,1), testClassChosen);
    for i = 1:10
        nOccOfNumb = 0;
        temp = 0;
        nCorrReadOfNumb = 0;
        temp2 = 0;
        for r = 1:nTest
            if testClassChosen(r) == i
                temp = nOccOfNumb + 1;
                nOccOfNumb = temp;
                if labelResult(r) == i
                    temp2 = nCorrReadOfNumb + 1;
                    nCorrReadOfNumb = temp2;
                end
            end
        end
        accuracy(j,i) = nCorrReadOfNumb / nOccOfNumb;
    end
end

% Visualize the results with nShow values.
nShow = 10;
for i = 1:nShow
    imshow(reshape(testObsChosen(i,:),28,28));
    if labelResult(i) == testClassChosen(i,1)
        title([num2str(mod(labelResult(i),10)),'! Correct!']);
    else
        title([num2str(mod(labelResult(i),10)),'! Wrong :( ',...
            'Truth: ', num2str(mod(testClassChosen(i),10))]);
    end
    pause(1.5);
end
close

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