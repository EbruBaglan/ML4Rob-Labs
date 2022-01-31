clc
clear
close all

% Loads the weather data set (already converted in numeric form)
train0 = readmatrix('weather.data','FileType','text');

% Splits it into a training set with 10 randomly chosen patterns
% and a test set with the remaining 4 patterns
k = 10;

times = 1000;
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
    obtainedClass = nbclassifier(train,test,n,d);

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
        end
    else
        disp(['CHECKED 3: NO target column.' ...
            ' Obtained classification is shown.'])
        obtainedClass
    end
end