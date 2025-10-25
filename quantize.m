function [S, num_zeros] = quantize(C, Q)

S = round(C ./ Q);
num_zeros = sum(sum(S == 0));

end