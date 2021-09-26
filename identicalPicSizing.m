function imds = identicalPicSizing(imds) 

% Variable used to track progress(remove ; for that)
i = 0;

% Resize all images.
while hasdata(imds)
    [B, info] = read(imds);
    newImg = imresize(B, [minHeight minWidth]);
    imwrite(newImg, info.Filename);
    i = i+1;
end

end