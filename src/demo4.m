% George Wu
% Demo 4
% Demonstrates seamless cloning with faces

sourceIm = imread('../data/SeamlessCloning/siblings/siblings_fore.jpg');
destIm = imread('../data/SeamlessCloning/siblings/siblings.jpg');
imMask = rgb2gray(imread('../data/SeamlessCloning/siblings/siblings_mask.jpg'));
imMask = (im2double(imMask) == 1);

offsetY = 0;
offsetX = 0;

clonedIm = SeamlessClone(destIm,sourceIm,imMask,offsetY,offsetX);
mixedClonedIm = MixedSeamlessClone(destIm,sourceIm,imMask,offsetY,offsetX);

imshow(clonedIm);
title('Poisson Seamless Cloning');

print -djpeg '../data/SeamlessCloning/siblings/cloned';

imshow(mixedClonedIm);
title('Mixed Poisson Seamless Cloning');

print -djpeg '../data/SeamlessCloning/siblings/mixed_cloned';

