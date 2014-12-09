% George Wu
% Demo 1
% Demonstrates seamless cloning

sourceIm = imread('../data/water/water_front.png');
destIm = imread('../data/water/water_back.jpeg');
imMask = zeros(size(sourceIm,1),size(sourceIm,2));
y1 = 21;
y2 = 80;
x1 = 44;
x2 = 153;
imMask(y1:y2,x1:x2) = 1;
offsetY = 0;
offsetX = 0;

pastedIm = destIm;
pastedIm(y1:y2,x1:x2,:) = sourceIm(y1:y2,x1:x2,:);

clonedIm = SeamlessClone(destIm,sourceIm,imMask,offsetY,offsetX);

imshow(pastedIm);
title('Direct pasting');

print -djpeg '../data/water/direct_pasting';

imshow(clonedIm);
title('Poisson Seamless Cloning');

print -djpeg '../data/water/cloned';
