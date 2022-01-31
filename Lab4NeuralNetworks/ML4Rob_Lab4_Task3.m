clc
clear
close all
% Lab4

% Get the training observations and training classes.
[trainObs,trainClass] = loadMNIST(0);

% OPTIONAL: FRAMING DATA INTERVAL
% Uncomment to take TRAINING data from an interval,
% specifying nLow and nUp values.
nLow = 1;
nUp = 1000;
nTrain = nUp - nLow + 1;

trainObsChosen   = trainObs(nLow:nUp, :);
trainClassChosen = trainClass(nLow:nUp, 1);

% Indices are taken to make classes.
indices1 = find(trainClassChosen==1);
indices7 = find(trainClassChosen==7);
indices0 = find(trainClassChosen==10);
indices8 = find(trainClassChosen==8);

% Classes are defined.
x1 = trainObsChosen(indices1,:);
x7 = trainObsChosen(indices7,:);
x0 = trainObsChosen(indices0,:);
x8 = trainObsChosen(indices8,:);

% Labels are defined.
t1 = trainClassChosen(indices1,:);
t7 = trainClassChosen(indices7,:);
t0 = trainClassChosen(indices0,:);
t8 = trainClassChosen(indices8,:);

% New reduced training set is created.
myData = [x1',x8'];
myLabel = [t1',t8'];

% nh = size (number of units) in the hidden layer.
nh = 2;

% Encoder is trained.
myAutoencoder = trainAutoencoder(myData,nh);
myEncodedData = encode(myAutoencoder,myData);

%output = decode(myAutoencoder,myEncodedData);

% Encoding class 0 and 7 only, and plotting.
myData07 =  [x0', x7'];
myEncodedData07 = encode(myAutoencoder,myData07);

% t0 = repmat(["Class 0"],size(x0,1),1);
% t7 = repmat(["Class 7"],size(x0,1),1);
myLabel07 =  [t0; t7];
plotcl(myEncodedData07',myLabel07)

% Encoding randomly ordered data set of class 0, 1, 7, and 8. 
myNewData = [myData, x0', x7'];
randperm(size(myNewData,2))';
myNewDataRand = myNewData(:,randperm(size(myNewData,2))');

myEncodedData_all = encode(myAutoencoder,myNewDataRand);
output_all = decode(myAutoencoder,myEncodedData_all);

% Chosing 20 random pictures and showing their encoding.
nFigure = 20;   r = randi(size(myNewDataRand,2),nFigure,1);
figure(1)
for i = 1:nFigure
    subplot(4,5,i)
    imshow(reshape(transpose(myNewDataRand(:,r(i))),28,28))
end

figure(2)
for i = 1:nFigure
    subplot(4,5,i)
    imshow(reshape(transpose(output_all(:,r(i))),28,28))
end