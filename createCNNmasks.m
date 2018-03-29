ALL_IDB2_rgb = datastore(fullfile(ALL_IDB, 'ALL_IDB2', 'img'),'FileExtensions', '.tif','Type', 'image');
ALL_IDB2_wbc = datastore(fullfile(ALL_IDB, 'ALL_IDB2', 'gt', '*WBC.tif'),'FileExtensions', '.tif','Type', 'image');

for i=1:size(ALL_IDB2_rgb.Files,1)
    
    RGB = imread(ALL_IDB2_rgb.Files{i});
    GT = imbinarize( imread(ALL_IDB2_wbc.Files{i}) );
        
    R = RGB(:,:,1);
    G = RGB(:,:,2);
    B = RGB(:,:,3);
    R(GT == 0) = 0;
    G(GT == 0) = 0;
    B(GT == 0) = 0;
    
    RGB(:,:,1) = R;
    RGB(:,:,2) = G;
    RGB(:,:,3) = B;
    
    imwrite(RGB, fullfile(ALL_IDB, 'ALL_IDB2', 'cnn', strcat('Im', num2str(i),'_cnn', '.tif')));
        
end
