% George Wu
% Demo 3
% Demonstrates texture flattening

destIm = imread('../data/texture/child.jpg');
load '../data/texture/mask.mat';

flattenedIm = TextureFlatten(destIm,imMask,0.01);

imshow(flattenedIm);
title('Texture Flattening');

print -djpeg '../data/texture/texture_flatten';
