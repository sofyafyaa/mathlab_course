function [MER] = MER_my_func(IQ_RX, Constellation)

[Dictionary, Bit_depth_Dict] = constellation_func(Constellation);

Num_Constellation = 2^Bit_depth_Dict; 

for itter1 = 1 : length(IQ_RX)
    err_all = zeros(1, Num_Constellation);

    for itter2 = 1 : Num_Constellation
        err_all(1, itter2) = IQ_RX(itter1) - Dictionary(itter2);
    end

    [~, IQerror_idx] = min(abs(err_all));
    IQerror = err_all(IQerror_idx);
    IQ = IQ_RX(itter1) - IQerror;
end

MER = 10.*log10(sum(abs(IQ))./sum(abs(IQerror)));

end

