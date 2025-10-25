function [compressed_img, num_zeros, num_zeros_percent] = compress_img(img, block_size, quality_level)

% Start by converting the image to type double
img = double(img);

% Extract dimensions of the image
[img_h, img_w] = size(img);

% Construct an empty matrix of the same size as the original image to store
% the compressed image
compressed_img = zeros(size(img));

% Variable to store the number of zeros in the compressed image
num_zeros = 0;

% Obtain the quantization matrix to be used in the compression
Q = get_quantization_matrix(block_size, quality_level);

% Loop over block_size x block_size blocks of the image
for row = 1:block_size:img_h
    for col = 1:block_size:img_w
        % Extract the block_size x block_size block from the image
        B = img(row:row+(block_size - 1), col:col+(block_size - 1));

        % Level-off by subtracting 128
        B = B - 128.0;

        % Apply the 2D DCT
        C = dct2(B);

        % Quantize the DCT coefficients
        [S, block_num_zeros] = quantize(C, Q);
        
        % Replace the relevant block in the target image with the quantized
        % DCT coefficients
        compressed_img(row:row+(block_size - 1), col:col+(block_size - 1)) = S;
        
        % Keep a running count of the number of zeros
        num_zeros = num_zeros + block_num_zeros;
    end
end

% Find the number of zeros as a percentage
num_zeros_percent = (num_zeros / (img_h * img_w)) * 100;

end