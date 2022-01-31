clc
clear
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% TASK 3_1 : One dimensional Turkish Stock Exchange w/o intercept %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% J_MSE is the loss function for found estimation
% pre-allocation is made
J_MSE = zeros(11,2);

% the linear regression with 5% of data is run 10 times
% and the loss function is calculated for each run
% second column is the result found for estimation of
% remaining 95% data, and as seen it is higher than
% training loss
for i = 1:10
    [J_MSE(i,1), J_MSE(i,2)] = Task3_1 (0.05);
end

% the last row is used for summation of losses to make
% a conclusion about the results
J_MSE(11,:) = sum(J_MSE(1:10,:))