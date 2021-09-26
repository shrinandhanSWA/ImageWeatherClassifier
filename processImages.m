
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

% Resize all pics into the same size. 
imds = identicalPicSizing(imds);

% Size of smallest category.
tbl = countEachLabel(imds);
minSize = min(tbl{:, 2});

% Define size of the cross validation set
cvSize = floor(minSize / 5);

% Split data into training and cross validation set
[imdsCV, imdsTrain] = splitEachLabel(imds, cvSize, 'randomize');

% Save training and validation set
save processImages.mat imdsTrain imdsCV minWidth minHeight