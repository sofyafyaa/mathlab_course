clear; clc; close all;

[signal, fd] = audioread('voice.wav');

signal(signal==0) = [];
signal = log10(abs(signal));

signal_spec = fft(signal);

signal_filtered = bandpass(signal, [50, 10000], fd);

signal_filtered_spec = fft(signal_filtered);

k = 1 : length(signal);

% figure;
% plot(k, signal, k, signal_filtered)
% xlabel('n'); ylabel('Re(X(n))'); title('Signal');
% 
% figure;
% plot(k, real(signal_spec), k, real(signal_filtered_spec))
% xlabel('n'); ylabel('Re(X(n))'); title('Signal Spec');

[val_ft, idx_ft] = max(signal_filtered_spec);

ft = fd * idx_ft / length(k);

% Тон голоса --  ft, где-то 222 Гц, что согласовываетя 
% с теорией.

