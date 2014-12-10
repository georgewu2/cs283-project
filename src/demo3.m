% George Wu
% Demo 3
% Demonstrates texture flattening

destIm = imread('../data/TextureFlattening/child/child.jpg');
load '../data/TextureFlattening/child/mask.mat';

flattenedIm = TextureFlatten(destIm,imMask,0.01);

imshow(flattenedIm);
title('Texture Flattening');

print -djpeg '../data/TextureFlattening/child/texture_flatten';
