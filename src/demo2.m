% George Wu
% Demo 1
% Demonstrates seamless cloning

sourceIm = imread('../data/cat.jpg');
destIm = imread('../data/hawaii.jpg');
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

figure;
subplot(2,2,1);
imshow(destIm)
title('Destination Image');
subplot(2,2,2);
imshow(sourceIm);
title('Source Image');
subplot(2,2,3);
imshow(clonedIm);
title('Poisson seamless cloning');
subplot(2,2,4);
imshow(mixedClonedIm);
title('Mixed Poisson Seamless Cloning');

print -djpeg '../data/results/demo2';

