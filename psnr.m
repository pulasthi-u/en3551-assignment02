function [result] = psnr(original_img, reconstructed_img)
% Convert both images to type double
original_img = double(original_img);
reconstructed_img = double(reconstructed_img);

% Maximum intensity level in the original image
psi_max = max(original_img(:));

% Obtain the error matrix
error = original_img - reconstructed_img;

% Obtain the root mean squared error
mean_squared_error = mean(mean(error .^ 2));
root_mean_squared_error = sqrt(mean_squared_error);

result = 20 * log10(psi_max / root_mean_squared_error);
end