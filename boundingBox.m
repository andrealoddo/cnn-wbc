for i=1:size(ALL_IDB2_wbc.Files,1)
labeledImage = bwlabel(imread(ALL_IDB2_wbc.Files{i}));
measurements = regionprops(labeledImage, 'BoundingBox', 'Area');
BB(i) = {measurements.BoundingBox};
end
BB=BB';
Files=ALL_IDB2_singole.Files;
cells=[Files';BB];
ROI=cells';