function [Eb_N0] = Eb_N0_convert(SNR, Constellation)
    switch Constellation
        case "BPSK"
            Eb_N0 = SNR + 10*log10(1/1);
        case "QPSK"
            Eb_N0 = SNR + 10*log10(1/2);
        case "8PSK"
            Eb_N0 = SNR + 10*log10(1/3);
        case "16-QAM"
            Eb_N0 = SNR + 10*log10(1/4);
    end
end