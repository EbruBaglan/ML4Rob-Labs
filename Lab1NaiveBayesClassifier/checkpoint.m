function [n,d,m,c] = checkpoint(A,B)
[n, d] = size(A);
d = d - 1 ; % the number of attributes. excluded target here.

[m, c] = size(B);

if c >= d
    disp('CHECKED 1: Test set column number is at least the number of training columns - 1.')
else
    disp('FAILED 1:Test set column number is LESS THAN the number of training columns - 1.')
end

if all(A(:) >= 1)
    if all(B(:) >= 1)
        disp('CHECKED 2: No entry in any of the two data sets is <1')
    else
        disp('FAILED 2: At least one entry in test set is <1')
    end
else
    disp('FAILED 2: At least one entry in training set is <1')
end

for i = 1:d+1
    if size(setdiff(B(:,i),A(:,i))) > 0 %this function is directional. shows the ones that are in B but not in A. not the other way around.
        disp('FAILED 3: Test set includes at least one attribute level that was not in the training set.')
    end
end
end
