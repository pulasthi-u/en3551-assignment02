function [Q] = get_quantization_matrix(quality_level)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

% Provided quantization matrix for quality level 50
Q_50 = [
    16 11 10 16 24  40  51  61;
    12 12 14 19 26  58  60  55;
    14 13 16 24 40  57  69  56;
    14 17 22 29 51  87  80  62;
    18 22 37 56 68  109 103 77;
    24 35 55 64 81  104 113 92;
    49 64 78 87 103 121 120 101;
    72 92 95 98 112 100 103 99
];

% Scaling factor for a specified quality level
if quality_level < 50
    tau = 50 / quality_level;
else
    tau = (100 - quality_level) / 50;
end

Q = tau * Q_50;
Q = round(Q);

Q = min(max(Q, 0), 255);

end