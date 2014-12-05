function outputIm = SeamlessClone(destIm,sourceIm,imMask)
%SEAMLESSCLONE Blends SOURCEIM into DESTIM using IMMASK
%
%   Parameters
%   DESTIM: m by n pixel image
%   SOURCEIM: m by n pixel image aligned to fit onto DESTIM
%   IMMASK: m by n matrix of logicals to determine which pixels of SOURCEIM
%       to use

% destIm = double(destIm);
% sourceIm = double(sourceIm);

% get dimensions of picture
[height, width, ~] = size(destIm);

% number of valid neighbors
N = imfilter(ones(height,width),[0 1 0; 1 0 1; 0 1 0]);

% get number of pixels to determine and create index matrix
num_pixels = length(find(imMask));
[Y,X] = find(imMask);
indices = zeros(height,width);
count = 1;
for i = 1:num_pixels
   y = Y(i);
   x = X(i);
   indices(y,x) = count;
   count = count + 1;
end

laplacian = [0 -1 0; -1 4 -1; 0 -1 0];
l1 = conv2(double(sourceIm(:,:,1)), laplacian, 'same');
l2 = conv2(double(sourceIm(:,:,2)), laplacian, 'same');
l3 = conv2(double(sourceIm(:,:,3)), laplacian, 'same');

% In each row of the matrix, we will have 5 elements of fewer, so we use a
% sparse matrix to save space
A = spalloc(num_pixels,num_pixels,5*num_pixels);

% 3 because we need one for each channel
b = zeros(num_pixels,3);

% keep track of amount of pixels added so far
count = 0;
for x = 1:width
    for y = 1:height
        if imMask(y,x) == 1
            count = count + 1;
            A(count,count) = N(y,x);
            
            % take care of neighbors
            if y ~= 1
                if imMask(y-1,x) == 1
                    index = indices(y-1,x);
                    A(count,index) = -1;
                else
                    b(count,1) = b(count,1) + destIm(y-1,x,1);
                    b(count,2) = b(count,2) + destIm(y-1,x,2);
                    b(count,3) = b(count,3) + destIm(y-1,x,3);
                end
            end
            
            if x ~= 1
                if imMask(y,x-1) == 1
                    index = indices(y,x-1);
                    A(count,index) = -1;
                else
                    b(count,1) = b(count,1) + destIm(y,x-1,1);
                    b(count,2) = b(count,2) + destIm(y,x-1,2);
                    b(count,3) = b(count,3) + destIm(y,x-1,3);
                end
            end
            
            if y ~= height
                if imMask(y+1,x) == 1
                    index = indices(y+1,x);
                    A(count,index) = -1;
                else
                    b(count,1) = b(count,1) + destIm(y+1,x,1);
                    b(count,2) = b(count,2) + destIm(y+1,x,2);
                    b(count,3) = b(count,3) + destIm(y+1,x,3);
                end
            end
            
            if x ~= 1
                if imMask(y,x+1) == 1
                    index = indices(y,x+1);
                    A(count,index) = -1;
                else
                    b(count,1) = b(count,1) + destIm(y,x+1,1);
                    b(count,2) = b(count,2) + destIm(y,x+1,2);
                    b(count,3) = b(count,3) + destIm(y,x+1,3);
                end
            end
            
            b(count,1) = b(count,1) + l1(y,x);
            b(count,2) = b(count,2) + l2(y,x);
            b(count,3) = b(count,3) + l3(y,x);
        end
    end
end
outputIm = destIm;
for channel = 1:3
    points = A\b(:,channel);
    for k = 1:num_pixels
        outputIm(Y(k),X(k),channel) = points(k);
    end
end

end

