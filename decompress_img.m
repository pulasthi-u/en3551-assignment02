function [decompressed_img] = decompress_img(img, quality_level)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

[img_h, img_w] = size(img);
decompressed_img = zeros(size(img));

Q = get_quantization_matrix(quality_level);

for row = 1:8:img_h
    for col = 1:8:img_w
        S = img(row:row+7, col:col+7);
        R = Q .* S;
        E = idct2(R);
        decompressed_img(row:row+7, col:col+7) = E + 128;
    end
end

end