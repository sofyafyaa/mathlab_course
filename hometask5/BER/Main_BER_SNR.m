close all; clear; clc;


%% Init parametrs of model
Length_Bit_vector = 1e6 * 3;
Constellation = "8PSK"; % QPSK, 8PSK, 16-QAM
SNR = 30; % dB

%% Bit generator
Bit_Tx = randi([0,1], 1, Length_Bit_vector);

%% Mapping
IQ_TX = mapping(Bit_Tx, Constellation);
plot(IQ_TX, 'o');

%% Channel
% Write your own function Eb_N0_convert(), which convert SNR to Eb/N0
Eb_N0 = Eb_N0_convert(SNR, Constellation);

% Use your own function of generating of AWGN from previous tasks
IQ_RX = NoiseGenerator(IQ_TX, SNR);
plot(IQ_RX, 'o');

%% Demapping
Bit_Rx = demapping(IQ_RX, Constellation);

%% Error check
% Write your own function Error_check() for calculation of BER
BER = Error_check(Bit_Tx, Bit_Rx);

%% Additional task. Modulation error ration

MER_estimation = MER_my_func(IQ_RX, Constellation);

% Compare the SNR and MER_estimation from -50dB to +50dB for BPSK, QPSK,
% 8PSK and 16QAM constellation.
% Plot the function of error between SNR and MER for each constellation 
% Discribe the results. Make an conclusion about MER.
% You can use the cycle for collecting of data
% Save figure

%%

close all; clear; clc;

SNR_x = -50 : 50;
Length_Bit_vector = 1e5 * 3;
Constellations = ["BPSK", "QPSK", "8PSK", "16-QAM"];

MER_y = zeros(4, 1);
Bit_Tx_i = randi([0,1], 1, Length_Bit_vector);
for itter_c = 1 : 4
    Constellation_i = Constellations(itter_c);
    IQ_TX_i = mapping(Bit_Tx_i, Constellation_i);
    for itter = 1 : 101
        IQ_RX_i = NoiseGenerator(IQ_TX_i, SNR_x(itter));
        Bit_Rx_i = demapping(IQ_RX_i, Constellation_i);
        MER_y(itter_c, itter) = MER_my_func(IQ_RX_i, Constellation_i);
    end
end

%%

h(1) = figure;
plot(SNR_x, MER_y, '-');
legend('BPSK', 'QPSK', '8PSK', '16-QAM')
xlabel('SNR, dB');
ylabel('MER(SNR)');

savefig(h(1), 'MER.fig');


%% Experimental BER(SNR) and BER(Eb/N0)
% Collect enough data to plot BER(SNR) and BER(Eb/N0) for each
% constellation.
% Compare the constalation. Describe the results
% You can use the cycle for collecting of data
% Save figure

Eb_N0_i = zeros(1, 101);
BER_y = zeros(4, 101);

Bit_Tx_i = randi([0,1], 1, Length_Bit_vector);

for itter_c = 1 : 4
    Constellation_i = Constellations(itter_c);
    Eb_N0_i = Eb_N0_convert(SNR_x, Constellation_i);
    IQ_TX_i = mapping(Bit_Tx_i, Constellation_i);

    for itter = 1 : 101        
        IQ_RX_i = NoiseGenerator(IQ_TX_i, SNR_x(itter));
        Bit_Rx_i = demapping(IQ_RX_i, Constellation_i);
        BER_y(itter_c, itter) = Error_check(Bit_Tx_i, Bit_Rx_i);
    end
end

%%

h(2) = figure;
plot(SNR_x, BER_y, 'o-');
legend('BPSK', 'QPSK', '8PSK', '16-QAM')
xlabel('SNR, dB');
ylabel('BER(SNR)');

savefig(h(2), 'BER_SNR.fig');


h(3) = figure;
plot(Eb_N0_i, BER_y, 'o-');
legend('BPSK', 'QPSK', '8PSK', '16-QAM')
xlabel('Eb/N0, dB');
ylabel('BER');

savefig(h(3), 'BER_EBN0.fig');

%% Theoretical lines of BER(Eb/N0)
% Read about function erfc(x) or similar
% Configure the function and get the theoretical lines of BER(Eb/N0)
% Compare the experimental BER(Eb/N0) and theoretical for BPSK, QPSK, 
% 8PSK and 16QAM constellation
% Save figure

EbN0_dB = -50:0.1:50;
EbN0 = 10.^(EbN0_dB/10);

BER_th = zeros(3, length(EbN0));
BER_th(1, :) = 1/2.*erfc(sqrt(EbN0));
BER_th(2, :) = 2/3.*erfc(sqrt(6*EbN0)*sin(pi/8));
BER_th(3, :) = erfc(sqrt(12*EbN0/15));

h(4) = figure;
semilogy(EbN0_dB, BER_th)
ylabel('BER')
xlabel('E_b/N_0 (dB)')

savefig(h(4), 'BER_theory.fig');
