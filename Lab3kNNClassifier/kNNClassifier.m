function [labelResult, errorPer] = kNNClassifier(trainObs,trainLabel,testObs,k,testLabel)

% INPUT CONTROL
% Check that the number of arguments received (nargin) equals
% at least the number of mandatory arguments.
if nargin < 4
    fprintf(['Missing input arguments. Please provide ' ...
        'at least 4 inputs.\n']);
    return;
elseif nargin > 5
    fprintf(['You entered way too many arguments.' ...
        ' Please provide at most 5 inputs.\n']);
    return;
else
    % Check that the number of columns of the second matrix equals
    % the number of columns of the first matrix.
    [n1 , d1] = size(trainObs);
    [n2 , d2] = size(trainLabel);
    [m1 , d3] = size(testObs);
    if d1 ~= d3  || n1 ~= n2 ||  d2 ~= 1
        fprintf(['Check the size of the matrices again. ' ...
            'There is something that does not add up...\n']);
        return;
    end

    if nargin == 5
        [m2 , d4] = size(testLabel);
        if m1 ~= m2 || d4 ~= 1
            fprintf(['Check the size of the matrices again. ' ...
                'There is something that does not add up...\n']);
            return;
        end
    end

    % Check that k>0 and k<=cardinality of the training set
    % (number of rows, above referred to as n.
    if k <= 0 || k > n1
        fprintf(['Check the k value and the size of the matrices' ...
            ' again. There is something that does not add up...\n']);
        return;
    end

end
% END OF INPUT CONTROL

n = n1; d = d1; m = m1;

% Calculate the difference between test set and training set rows,
% make this for every row of test set by comparing it with every
% observation in the training set. Get this difference into diff matrix.
diff = zeros(m,n);
for i = 1 : m
    % comparing with every training row,
    for j = 1 : n
        % one test row,
        addUp = 0;
        for l = 1:d
            temp = addUp + (testObs(i,l) - trainObs(j,l))^2;
            addUp = temp;
        end
        diff(i,j) = addUp;
    end
end

% Find the k smallest indices and take them into smallestIndices.
smallestIndices = zeros(m,k);
for i = 1:m
    [~,smallestIndices(i,:)] = mink(diff(i,:),k);
end

% Take the class label of smallest indices with an additional column
% in the end, to put maximum occured label using mode().
label = zeros(m, k+1);
for i = 1:m
    for j = 1:k
        label(i,j) = trainLabel(smallestIndices(i,j),1);
    end
    label(i,j+1) = mode(label(i,1:k));
end

labelResult = label(:,end);
error = zeros(m,1);
if nargin == 5
    for i = 1:m
        if label(i,k+1) ~= testLabel(i,1)
            error(i,1) = 1;
        end
    end
    errorPer = sum(error,1)/m;

    % The number of different test labels is obtained to compute
    % accuracy. This is to get individual results.
    % the numbers occuring in test set
    row = cell(1,10);               % 1,2,4,5,6,7,8,10
    for i = 1:10
        row{1,i} = find(testLabel==i);
    end
    



    

end

end

%     labelsInd = unique(testLabel)';
%     nLabel = size(labelsInd);
%     errorInd = zeros(nLabel,1);
%     nOcc = zeros(nLabel,1);
%     for i = 1: nLabel
%         for j = 1: m
%             if labelResult(j) == labelsInd(i) % if label1 = 1
%                 temp = nOcc(labelsInd(i),1) +  1;
%                 nOcc(labelsInd(i),1) = temp;
%             end
%         end
%     end