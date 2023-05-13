function [Dictionary, Bit_depth_Dict] = constellation_func(Constellation)
    switch Constellation
        case "BPSK"
            Dictionary = [-1+0*1i, 1+0*1i];
            Bit_depth_Dict = 1;
        case "QPSK"
            Dictionary = [-1-1i, -1+1i, 1-1i, 1+1i];
            Bit_depth_Dict = 2;
        case "8PSK"
            %Dictionary = [+1 000, +(1/sqrt(2))*(1+1i)001, +1i 010, +(1/sqrt(2))*(-1+1i) 011, ...
            %             +-1 100, +(1/sqrt(2))*(-1-1i) 101, +-1i 110, +(1/sqrt(2))*(1-1i) 111];

            Dictionary = [(1/sqrt(2))*(-1-1i), -1, 1i, (1/sqrt(2))*(-1+1i), ...
                         -1i, (1/sqrt(2))*(1-1i), (1/sqrt(2))*(1+1i), 1];

            Bit_depth_Dict = 3;
        case "16-QAM"
            Dictionary = [-3+3i, -3+1i, -3-3i, -3-1i, ...
                          -1+3i, -1+1i, -1-3i, -1-1i, ...
                           3+3i,  3+1i,  3-3i,  3-1i, ...
                           1+3i,  1+1i,  1-3i,  1-1i];
            Bit_depth_Dict = 4;
    end
    
    % Normalise the constellation.
    % Mean power of every constellation must be equel 1.
    % Make the function to calculate the norm, 
    % which can be applied for every constellation

    norm = sqrt(sum(Dictionary.*conj(Dictionary))/2^(Bit_depth_Dict));

    Dictionary = Dictionary./norm;

end

