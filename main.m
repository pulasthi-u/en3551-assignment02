clc;
clear;
close all;

block_size = 8;

% Monarch.A, Parrots.C, cameraman.B

img = load("Parrots.mat").C;

figure;

subplot(1, 2, 1);
imshow(img, []);

compressed = compress_img(img, block_size, 10);

decompressed = decompress_img(compressed, block_size, 10);

subplot(1, 2, 2);
imshow(decompressed, []);