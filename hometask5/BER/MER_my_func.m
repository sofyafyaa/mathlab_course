function [MER] = MER_my_func(IQ_RX, Constellation)

[Dictionary, Bit_depth_Dict] = constellation_func(Constellation);

IQ = zeros(1, length(IQ_RX));

Num_Constellation = 2^Bit_depth_Dict; 

for itter1 = 1 : length(IQ_RX)
    %err_all = zeros(1, Num_Constellation);

    err_all = IQ_RX(itter1) - Dictionary;

    [~, IQerror_idx] = min(abs(err_all));

    IQerror = err_all(IQerror_idx);

    IQ(itter1) = IQ_RX(itter1) - IQerror;
end

MER = 10.*log10(sum(abs(IQ))./sum(abs(IQerror)));

%% Для PSK у нас мощность (числитель) постоянная, тогда???

%deltaIQ = IQ_RX - IQ_TX;

%MER = 10.*log10(sum(abs(IQ_TX))./sum(abs(deltaIQ)));

end

