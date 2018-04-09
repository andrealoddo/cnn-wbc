net = alexnet;

inputSize = net.Layers(1).InputSize;

layersTransfer = net.Layers(1:end-3);
numClasses = 2;     % Background, WBCs

pixelRange = [-30 30];
imageSize = [227 227 3];


layers = [
    layersTransfer
    fullyConnectedLayer(numClasses,'WeightLearnRateFactor',60,'BiasLearnRateFactor',60)
    softmaxLayer
    classificationLayer];


miniBatchSize = 256;
numIterationsPerEpoch = floor(260/miniBatchSize);
options = trainingOptions('sgdm',...
    'MiniBatchSize',miniBatchSize,...
    'MaxEpochs',20,...
    'InitialLearnRate',7e-9,...
    'Verbose',true,...
    'Plots','training-progress',...
    'ValidationFrequency',numIterationsPerEpoch);


frcnn = trainFastRCNNObjectDetector(ROItable2, fastRCNNLayers , options);
[bbox, score, label] = detect(frcnn, img);
detectedImg = insertShape(img, 'Rectangle', bbox);
imshow(detectedImg)