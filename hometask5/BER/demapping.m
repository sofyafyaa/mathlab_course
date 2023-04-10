function [Bit] = demapping(IQ_RX, Constellation)
% Make the different dictionary for BPSK, QPSK, 8PSK, 16QAM constellations
% calculate the Bit_depth for each contellation

[Dictionary, Bit_depth_Dict] = constellation_func(Constellation);

% write  the function of mapping from IQ vector to bit vector

Num_Constellation = 2^Bit_depth_Dict; 

eps = 1e-10;

Bit = zeros(1, length(IQ_RX));
for itter1 = 1 : length(IQ_RX)
    t = zeros(1, Num_Constellation);

    for itter2 = 1 : Num_Constellation
        t(1, itter2) = IQ_RX(itter1) - Dictionary(itter2);
    end 

    [~, idx_min] = min(abs(t));
    error_min = t(idx_min);
    c = IQ_RX(itter1) - error_min;

    Bit(itter1) = idx_min-1;
end
    Bit = int2bit(Bit, Bit_depth_Dict);
    Bit = reshape(Bit, [], 1);
    Bit = Bit';
end

