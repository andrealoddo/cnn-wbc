ALL_IDB2_val = datastore(fullfile('C:\Users\simoc\Desktop\cnn-wbc\ALL_IDB\ALL_IDB1\img'),'FileExtensions', '.jpg','Type', 'image');

ALL_IDB2_cnn = datastore(fullfile('C:\Users\simoc\Desktop\cnn-wbc\ALL_IDB', 'ALL_IDB2', 'cnn'),'FileExtensions', '.tif','Type', 'image');

augmenter = imageDataAugmenter( ...
    'RandXReflection',true, ...
    'RandXScale',[1 2], ...
    'RandYReflection',true, ...
    'RandYScale',[1 2]);

net = alexnet;

inputSize = net.Layers(1).InputSize;

layersTransfer = net.Layers(1:end-3);
numClasses = 2;     % Background, WBCs

layers = [
    layersTransfer
    fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
    softmaxLayer
    classificationLayer];

pixelRange = [-30 30];
imageSize = [227 227 3];

imageAugmenter = imageDataAugmenter( ...
    'RandXReflection',true, ...
    'RandXTranslation',pixelRange, ...
    'RandYTranslation',pixelRange);

augimdsTrain = augmentedImageDatastore(imageSize, inputSize(1:2),ALL_IDB2_cnn, ...
    'DataAugmentation',imageAugmenter);

augimdsValidation = augmentedImageDatastore(imageSize, inputSize(1:2),ALL_IDB2_val, ...
    'DataAugmentation',imageAugmenter);



% netTransfer = trainNetwork(augimdsTrain,layers,options);

