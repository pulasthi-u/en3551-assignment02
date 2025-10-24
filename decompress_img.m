function [decompressed_img] = decompress_img(img, block_size, quality_level)

% Start by converting the image type to double
img = double(img);

% Obtain the image dimensions
[img_h, img_w] = size(img);

% Construct an empty matrix to store the decompressed image
decompressed_img = zeros(size(img));

% Obtain the quantization matrix used corresponding to the specified
% quality level
Q = get_quantization_matrix(block_size, quality_level);

% Loop over block_size x block_size blocks of the image
for row = 1:block_size:img_h
    for col = 1:block_size:img_w
        % Extract the relevant block from the image
        S = img(row:row+(block_size - 1), col:col+(block_size - 1));

        % Estimate the matrix that was quantized to obtain the block above
        R = Q .* S;

        % Obtain the inverse DCT
        E = idct2(R);

        % Replace the corresponding block in the target image with the IDCT
        % and add 128 to undo the leveling off
        decompressed_img(row:row+(block_size - 1), col:col+(block_size - 1)) = E + 128.0;
    end
end

end