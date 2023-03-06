clear; clc; close all;

%% Task 1

SignalSpec = zeros(1, 128);

N = 1:128;

SignalSpec(5) = 1;
SignalSpec(15) = 3;
SignalSpec(25) = 2;

Signal = ifft(SignalSpec, 128);

RSignal = real(Signal);
ISignal = imag(Signal);

RSignal_spec = fft(RSignal);
ISignal_spec = fft(ISignal);
 
% figure;
% plot(N, RSignal_spec, N, imag(ISignal_spec))
% xlabel('n'); ylabel('x(t)'); title('Signal');

%% Task 2

SNR = 23;
[NoisedSignal, Noise] = NoiseGenerator(Signal, SNR);

% figure;
% plot(N, abs(Noise), N, abs(NoisedSignal), N, abs(Signal))
% xlabel('w'); ylabel('S(w)'); title('Spectr');

%% Task 3

P_Signal = PowerSignal(Signal);
P_Noise = PowerSignal(Noise);
P_NoisedSignal = PowerSignal(NoisedSignal);

SNR_analyt = 10*log10(P_Signal/P_Noise);

%% Task 4

% вывод

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
% plot(N, fft(FilteredNoisedSignal))
% xlabel('w'); ylabel('S(w)'); title('Spectr');

%% Task 6

P_FilteredNoisedSignal = PowerSignal(FilteredNoisedSignal);

SNR_noised = 10*log10(P_NoisedSignal / P_Noise);
SNR_filtered = 10*log10(P_FilteredNoisedSignal / PowerSignal(FilteredNoisedSignal - Signal));

% Среднее значение выигрыша +
% Зависимость SNR_filtered - SNR_noised от SNR +
% Noise +
% теорема персеваля +

%% Average SNR_filtered - SNR_noised

Sum = 0;
for itter = 1 : 50
    rng(itter)
    [NoisedSignal_i, Noise_i] = NoiseGenerator(Signal, SNR);
    FilteredNoisedSignal_i = FilterSignal(NoisedSignal_i, 32, 1);
    
    P_NoisedSignal_i = PowerSignal(NoisedSignal_i);
    P_FilteredNoisedSignal_i = PowerSignal(FilteredNoisedSignal_i);
    P_Noise_i = PowerSignal(Noise);

    SNR_noised_i = 10*log10(P_NoisedSignal_i / P_Noise_i);
    SNR_filtered_i = 10*log10(P_FilteredNoisedSignal_i / PowerSignal(FilteredNoisedSignal_i - Signal));

    Sum = Sum + SNR_filtered_i - SNR_noised_i;
end
Average_delta = Sum / itter;

%% Dependence delta ~ SNR

x_SNR = 1 : 500;
delta(1:500) = 0;
for itter = 1 : 500
    rng(SNR)
    [NoisedSignal_i, Noise_i] = NoiseGenerator(Signal, x_SNR(itter));
    FilteredNoisedSignal_i = FilterSignal(NoisedSignal_i, 32, 1);
    
    P_NoisedSignal_i = PowerSignal(NoisedSignal_i);
    P_FilteredNoisedSignal_i = PowerSignal(FilteredNoisedSignal_i);
    P_Noise_i = PowerSignal(Noise);

    SNR_noised_i = 10*log10(P_NoisedSignal_i / P_Noise_i);
    SNR_filtered_i = 10*log10(P_FilteredNoisedSignal_i / PowerSignal(FilteredNoisedSignal_i - Signal));

    delta(itter) = SNR_filtered_i - SNR_noised_i;
end

figure;
plot(x_SNR, delta);
xlabel('SNR'); ylabel('SNR_filtered_i - SNR_noised_i'); title('Dependence delta ~ SNR');
