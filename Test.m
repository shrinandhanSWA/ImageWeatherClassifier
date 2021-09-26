clear; close all; clc

load mainAlgo.mat

% Get root directory of images
outputFolder = fullfile('dataset2');
rootFolder = outputFolder;

% Define categories of images
categories = {'sunrise', 'shine', 'rain', 'cloudy'};

% Load images, category wise, into an imageDataStore imds.
imds = imageDatastore(fullfile(rootFolder, categories), 'LabelSource', 'foldernames');

% Copy of imds
sizeimds = imds;

% Compute minimum width and height of the images.
[minWidth, minHeight] = computeMinSize(sizeimds);

% Ensure images are all the same size. 
imds = identicalPicSizing(imds);

% Use network to get predictions
Ypred = classify(net, imds);

% Get actual labels from image data store
Ytest = imds.Labels;

% Calculate accuracy
accuracy = sum(Ypred == Ytest)/numel(Ytest);
disp(accuracy);
