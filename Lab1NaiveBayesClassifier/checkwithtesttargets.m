function percentage = checkwithtesttargets(freqfortest,test)
% checkwithtesttargets(freqfortest,test) function checks two
% column vectors, and gives the percentage of same values

% C is a logical matrix.
C = freqfortest == test(:,1);
[s, ~] = size(C);
% nnz: Number of non-zero matrix elements.
percentage = 100 * nnz(C) / s;
end