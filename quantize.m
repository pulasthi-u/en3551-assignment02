function [S, num_zeros] = quantize(C, quality_level)
%QUANTIZE Summary of this function goes here
%   Detailed explanation goes here

Q = get_quantization_matrix(quality_level);

S = round(C ./ Q);
num_zeros = sum(S == 0);

end