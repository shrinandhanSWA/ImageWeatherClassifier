function [minWidth, minHeight] = computeMinSize(imds) 

% Initialize them to large values.
minWidth = 50000;
minHeight = 50000;

% Go through each picture and check the dimensions.
% Update minWidth and minHeight is necessary.
while hasdata(imds)
    [B, ~] = read(imds);
    [height, width, ~] = size(B);
    if height < minHeight
        minHeight = height;
    end
    if width < minWidth
        minWidth = width;
    end
end

end