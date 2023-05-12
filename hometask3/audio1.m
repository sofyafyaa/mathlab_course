%% Task 1
clear; clc; close all;

[signal, F_d] = audioread('file8.wav');
signal = signal .';
k = 1:F_d;

signal_spec = fft(signal, F_d);

% find max C_n

[max_ampl, max_idx] = maxk(signal_spec(1:F_d/2), 3);

signal_spec_renew = zeros(1, F_d, "double");
signal_spec_renew(max_idx(1)) = signal_spec(max_idx(1));
signal_spec_renew(max_idx(2)) = signal_spec(max_idx(2));
signal_spec_renew(max_idx(3)) = signal_spec(max_idx(3));
signal_spec_renew(F_d - max_idx(1)) = signal_spec(max_idx(1));
signal_spec_renew(F_d - max_idx(2)) = signal_spec(max_idx(2));
signal_spec_renew(F_d - max_idx(3)) = signal_spec(max_idx(3));

signal_renew = ifft(signal_spec_renew);

signal_filtered = bandpass(signal ,[150, 852], F_d);
signal_filtered_spec = fft(signal_filtered);

figure;
plot(k, abs(signal))
xlabel('n'); ylabel('X(n)'); title('Signal');

figure;
plot(k, abs(signal_spec))
xlabel('n'); ylabel('X(n)'); title('Signal Spectr');

figure;
plot(k, abs(signal_renew))
xlabel('n'); ylabel('X(n)'); title('Signal filtered');

figure;
plot(k, abs(signal_spec_renew))
xlabel('k'); ylabel('X(k)'); title('Signal filtered spectr');

% figure;
% plot(k, real(signal), k, real(signal_filtered), k, real(signal_renew));
% xlabel('n'); ylabel('x(n)'); title('Signal Filtered');
% 
% figure;
% plot(k, real(signal_filtered_spec));
% xlabel('n'); ylabel('x(n)'); title('Signal Filtered Spec');

%sound(signal, F_d)
%sound(real(signal_renew), F_d);
%sound(real(signal_filtered), F_d);



%% Task 2
clear; clc; close all;

Amp = 3;
freqHz = 1000;
fsHz = 2500;
dt = 1/fsHz;
t = 0:dt:3-dt;
signal = Amp * sin(2*pi*freqHz*t);

N = fsHz*3;
signal_spec = fft(signal,N)/N;

audiowrite('sinusoida1.wav', signal, fsHz);

singal_clipped = signal .* (signal <=2 & signal >= -2) + 2 .* (signal >2) + (-2) * (signal < -2);
singal_clipped_spec = fft(singal_clipped, N)/N;

faxis = linspace(-fsHz/2,fsHz/2,N);

figure;
plot(t, signal, t, singal_clipped);
xlabel('t'); ylabel('A'); title('signal & clipped signal');

figure;
plot(faxis/1000, fftshift(abs(signal_spec)), faxis/1000, fftshift(abs(singal_clipped_spec)));
xlabel('f'); ylabel('A'); title('signal spectr');

figure;
plot(faxis/1000, fftshift(abs(singal_clipped_spec)));
xlabel('f'); ylabel('A'); title('clipped signal spectr');


%sound(singal_clipped, fd);

%% Task 3
clear; clc; close all;

[signal, fd] = audioread('task3.wav');
% N -- number of audio samples, 2 -- number of audio channels????

N = length(signal);
n = 1:N;
signal_spec = fft(signal, N);

figure;
plot(n, abs(signal(:, 1)));
xlabel('n'); ylabel('A'); title('signal');

figure;
plot(n(1:N/2), abs(signal_spec(1:N/2, 1)));
xlabel('n'); ylabel('A'); title('|signal spectr|');

%sound(signal, fd);

N1 = round(N/2);
signal1 = zeros(N1, 2);
for itter = 1 : N1-1
    signal1(itter, :) = signal(itter * 2, :);
end

signal1_spec = fft(signal1, N1);

n1 = 1:N1;
figure;
plot(n1, signal1(:, 1));
xlabel('n'); ylabel('A'); title('signal after downsampling');

figure;
plot(n1(1:N1/2), abs(signal1_spec(1:N1/2, 1)));
xlabel('n'); ylabel('A'); title('|signal spectr| after downsampling');

%sound(signal1, fd/2);

N2 = N * 2 - 1;
signal2 = zeros(N2, 2);

itter1 = 1;
for itter2 = 1 : N2
    if (mod(itter2, 2) == 1)
        signal2(itter2, :) = signal(itter1, :);
        itter1 = itter1 + 1;
    elseif(mod(itter2, 2) == 0 && itter2 ~= signal1(end))
        signal2(itter2, :) = (signal(itter1, :) + signal(itter1 - 1, :)) / 2;
    end
end

signal2_spec = fft(signal2, N2);

n2 = 1:N2;

figure;
plot(n2, signal2(:, 1));
xlabel('n'); ylabel('A'); title('signal after increase in sampling');

figure;
plot(n2(1:(N2+1)/2), abs(signal2_spec(1:(N2+1)/2, 1)));
xlabel('n'); ylabel('A'); title('|signal spectr| increase in sampling');

%Нормировка спектров по мощности

signal_spec = signal_spec/PowerSignal(signal_spec);
signal1_spec = signal1_spec/PowerSignal(signal1_spec);
signal2_spec = signal2_spec/PowerSignal(signal2_spec);

figure;
p = plot(n(1:N/2), abs(signal_spec(1:N/2, 1)), ...
     n1(1:N1/2), abs(signal1_spec(1:N1/2, 1)), ...
     n2(1:(N2+1)/2), abs(signal2_spec(1:(N2+1)/2, 1)));

p(1).LineWidth = 4;
p(2).LineWidth = 3;
p(3).LineWidth = 1;

xlabel('k'); ylabel('A'); title('Сравнение спектров');
legend('original spectr', 'spectr after downsampling', 'spectr after increasing samples');

%sound(signal2, fd*2)

