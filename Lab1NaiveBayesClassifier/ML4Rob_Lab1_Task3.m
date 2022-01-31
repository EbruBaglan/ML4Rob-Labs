clc
clear
close all

% Loads the weather data set (already converted in numeric form)
train0 = readmatrix('weather.data','FileType','text');

% Apripri knowledge of levels.
nLevelsGiven = [ 3, 3, 2, 2 ];

% Splits it into a training set with 10 randomly chosen patterns
% and a test set with the remaining 4 patterns
k = 10;
aValues = [0.0001,0.001,0.01,0.1,1,1.5,2,3,5];
final= zeros(9,1);
for j = 1:9
    a=aValues(j);
    times =1000;
    error = zeros(times,1);
    for i = 1:times
        % Splits it into a training set with 10 randomly chosen patterns
        % and a test set with the remaining 4 patterns
        [train, test] = randomselector(train0,k);

        % Check that the number c of columns of the second matrix is
        % at least the number d of columns of the first matrix - 1
        % Check that no entry in any of the two data sets is <1
        [n,d,m,c] = checkpoint(train,test);

        % The estimate of likelihood for test set is obtained.
        obtainedClass = nbclassifier2(train,test,n,d,nLevelsGiven,a);

        % The results are compared.
        % If the test set has a column number d+1, use this as a target,
        % compute and return the error rate obtained (number of errors / m)
        if c - d == 1
            disp(['CHECKED 3: Test set has target column.' ...
                ' Error ratios will be shown.'])
            success = checkwithtesttargets(obtainedClass,test(:,end));
            error(i,1) = 100 - success;
            if i == times
                fprintf(['\nError rate for NB classifier for %d run' ...
                    ' is %d/100.\n\n'],times,sum(error(:,1))/times);
                final(j,1) = sum(error(:,1))/times;
            end
        else
            disp(['CHECKED 3: NO target column.' ...
                ' Obtained classification is shown.'])
            obtainedClass
        end
    end
end

plot(aValues,final,'r'); hold on;
plot(aValues,final,'r.', 'MarkerSize', 20); hold on;


for i =1:9
        textString = sprintf('a = %s',num2str(aValues(i),2));
        text(aValues(i),final(i,1)+0.17, textString, 'FontSize', 9); hold on;
end
set(gca, 'XScale', 'log')
title('Effect of chosing different a in Laplace smoothing for NB classifier')
xlabel('a values (log)');
ylabel('Error rate');
grid on;
hold off