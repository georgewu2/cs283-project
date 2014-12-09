% George Wu
% Demo 2
% Demonstrates mixed seamless cloning

sourceIm = imread('../data/mixed2/cat.jpg');
destIm = imread('../data/mixed2/hawaii.jpg');
imMask = zeros(size(sourceIm,1),size(sourceIm,2));
y1 = 285;
y2 = 500;
x1 = 150;
x2 = 550;
imMask(y1:y2,x1:x2) = 1;
offsetY = 370;
offsetX = 0;

pastedIm = destIm;
pastedIm(y1:y2,x1:x2,:) = sourceIm(y1:y2,x1:x2,:);

clonedIm = SeamlessClone(destIm,sourceIm,imMask,offsetY,offsetX);
mixedClonedIm = MixedSeamlessClone(destIm,sourceIm,imMask,offsetY,offsetX);

imshow(clonedIm);
title('Poisson Seamless Cloning');

print -djpeg '../data/mixed2/cloned';

imshow(mixedClonedIm);
title('Mixed Poisson Seamless Cloning');

print -djpeg '../data/mixed2/mixed_cloned';

