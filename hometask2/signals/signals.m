clear; clc; close all;

%% Task 1

SignalSpec = zeros(1, 128);

N = 1:128;

SignalSpec(5) = 1;
SignalSpec(15) = 3;
SignalSpec(25) = 2;

Signal = ifft(SignalSpec, 128);
 
% figure;
% plot(N, abs(Signal))
% xlabel('n'); ylabel('x(t)'); title('Signal');

%% Task 2

[NoisedSignal, Noise] = NoiseGenerator(Signal, 23); %23

% figure;
% plot(N, abs(Noise), N, abs(NoisedSignal), N, abs(Signal))
% xlabel('w'); ylabel('S(w)'); title('Spectr');

%% Task 3

P_Signal = PowerSignal(Signal);
P_Noise = PowerSignal(Noise);
P_NoisedSignal = PowerSignal(NoisedSignal);

%% Task 4

NoiseSpec = fft(Noise);
NoisedSignalSpec = fft(NoisedSignal);

% figure;
% plot(N, abs(NoisedSignalSpec))
% xlabel('w'); ylabel('S(w)'); title('Spectr');

P_SignalSpec = PowerSignal(SignalSpec) / 128;
P_NoiseSpec = PowerSignal(NoiseSpec) / 128;
P_NoisedSignalSpec = PowerSignal(NoisedSignalSpec) / 128;

if ((P_SignalSpec - P_Signal)/P_Signal < 1e-5) && ((P_Noise - P_NoiseSpec)/P_Noise < 1e-5) && ((P_NoisedSignal - P_NoisedSignalSpec)/P_NoisedSignal < 1e-5)
    fprintf('TRUE\n')
else
    fprintf('FALSE\n')
end

%% Task 5

FilteredNoisedSignal = FilterSignal(NoisedSignal, 32, 1);

% figure;
% plot(N, abs(NoisedSignal), N, abs(FilteredNoisedSignal), N, abs(Signal))
% xlabel('w'); ylabel('S(w)'); title('Spectr');

%% Task 6

P_FilteredNoisedSignal = PowerSignal(FilteredNoisedSignal);

SNR_noised = 10*log(P_NoisedSignal / P_Noise);
SNR_filtered = 10*log(P_FilteredNoisedSignal / PowerSignal(FilteredNoisedSignal - Signal));

% SNR у фильтрованного сигнала больше => шум меньше влияет на
% характеристику системы. Значит, этим сигналом лучше пользоваться, потому
% что он лучше описывает исходный сигнал