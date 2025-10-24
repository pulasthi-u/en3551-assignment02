clc;
clear;
close all;

% We will use DCT to compress 8 x 8 blocks of the images
block_size = 8;

% Array to store names of images being used
img_names = ["Monarch.mat", "Parrots.mat", "cameraman.mat"];
num_imgs = size(img_names, 2);

% Array with quality levels to be used for each of the images
quality_levels = [80, 30, 15];
num_quality_levels = size(quality_levels, 2);

% Load each image and perform the relevant tasks
for i = 1:num_imgs
    img = load(img_names(i));
    fn = fieldnames(img);
    img = img.(fn{1});

    disp("Image: " + img_names(i));

    figure;

    % Add a subplot for the original image
    subplot(1, num_quality_levels+1, 1);
    imshow(img, []);
    title("Original Image");

    for quality_level_idx = 2:num_quality_levels+1
        % Extract the corresponding quality level
        quality_level = quality_levels(quality_level_idx - 1);

        % Compress and decompress
        [compressed, num_zeros] = compress_img(img, block_size, quality_level);
        % Typically there would be a coding and decoding step here, but we
        % skip this step
        decompressed = decompress_img(compressed, block_size, quality_level);

        % Add a subplot and display the reconstructed image
        subplot(1, num_quality_levels+1, quality_level_idx);
        imshow(decompressed, []);
        title(quality_level + "% Compression");
        
        % Compute the PSNR
        psnr_ = psnr(img, decompressed);
        disp("PSNR for " + quality_level + "% Compression = " + psnr_);
    end
end