% George Wu
% Demo 5
% Demonstrates seamless cloning

sourceIm = imread('../data/SeamlessCloning/f16/F16Source.jpg');
destIm = imread('../data/SeamlessCloning/f16/F16Target.jpg');
imMask = rgb2gray(imread('../data/SeamlessCloning/f16/F16Mask.jpg'));
imMask = (im2double(imMask) == 1);
offsetY = 70;
offsetX = 70;

clonedIm = SeamlessClone(destIm,sourceIm,imMask,offsetY,offsetX);

imshow(clonedIm);
title('Poisson Seamless Cloning');

print -djpeg '../data/SeamlessCloning/f16/cloned';

