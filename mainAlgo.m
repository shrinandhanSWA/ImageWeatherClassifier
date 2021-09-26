clear ; close all; clc

% Load in training and validation set
load processImages.mat

% Define layers of the neural network
layers = [
    % input layer
    imageInputLayer([minHeight minWidth 3])
    
    % A convolution layer, filter size is 3x3, applies 8 filters.
    convolution2dLayer(3,8,'Padding','same');
    
    % A normalization layer
    batchNormalizationLayer
    
    % An activation layer
    reluLayer
    
    % A pooling layer
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,16,'Padding','same');
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,32,'Padding','same');
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,64,'Padding','same');
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,128,'Padding','same');
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,256,'Padding','same');
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,512,'Padding','same');
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(4)
    softmaxLayer
    classificationLayer];   

% Add regularization for convolution layers
layers(2) = setL2Factor(layers(2),'Weights',5);
layers(6) = setL2Factor(layers(6),'Weights',5);
layers(10) = setL2Factor(layers(10),'Weights',5);
layers(14) = setL2Factor(layers(14),'Weights',10);
layers(18) = setL2Factor(layers(18),'Weights',10);
layers(22) = setL2Factor(layers(22),'Weights',10);
layers(26) = setL2Factor(layers(26),'Weights',10);

% Set training options
options = trainingOptions('sgdm', ...
'InitialLearnRate', 0.01, ...
'MaxEpochs', 30, ...
'MiniBatchSize', 300, ...
'ValidationData', imdsCV, ...
'ValidationFrequency', 5, ...
'Plots', 'training-progress');

% Train the network
net = trainNetwork(imdsTrain, layers, options);

% Save trained network
save mainAlgo.mat net
    

