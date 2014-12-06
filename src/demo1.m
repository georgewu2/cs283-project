% George Wu
% Demo 1
% Demonstrates seamless cloning

sourceIm = imread('../data/water_front.png');
destIm = imread('../data/water_back.jpeg');
imMask = zeros(size(sourceIm,1),size(sourceIm,2));
y1 = 21;
y2 = 80;
x1 = 44;
x2 = 153
imMask(y1:y2,x1:x2) = 1;
offsetY = 0;
offsetX = 0;

pastedIm = destIm;
pastedIm(y1:y2,x1:x2,:) = sourceIm(y1:y2,x1:x2,:);

clonedIm = SeamlessClone(destIm,sourceIm,imMask,offsetY,offsetX);

figure;
subplot(2,2,1);
imshow(destIm)
title('Destination Image');
subplot(2,2,2);
imshow(sourceIm);
title('Source Image');
subplot(2,2,3);
imshow(pastedIm);
title('Direct pasting');
subplot(2,2,4);
imshow(clonedIm);
title('Poisson seamless cloning');
