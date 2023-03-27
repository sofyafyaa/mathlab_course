%% Task 1
clear; clc; close all;

[signal, F_d] = audioread('file8.wav');
signal = signal .';
k = 1:F_d;

signal_spec = fft(signal, F_d);

% find max C_n
signal_spec_renew = zeros(1, F_d, "double");
signal_spec_renew(151) = signal_spec(151);
signal_spec_renew(501) = signal_spec(501);
signal_spec_renew(851) = signal_spec(851);

signal_spec_renew(F_d - 151) = signal_spec(151);
signal_spec_renew(F_d - 501) = signal_spec(501);
signal_spec_renew(F_d - 851) = signal_spec(851);

signal_renew = ifft(signal_spec_renew);

signal_filtered = bandpass(signal ,[150, 852], F_d);
signal_filtered_spec = fft(signal_filtered);

figure;
plot(k, real(signal_filtered))
xlabel('n'); ylabel('Re(X(n))'); title('Signal filtered');

figure;
plot(k, real(signal_filtered_spec))
xlabel('k'); ylabel('Re(X(k))'); title('Signal filtered spectr');

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

A = 3; f0 = 1000; tau = 3; fd = 2500;
N = tau * fd;
t = (0 : N-1)/fd;
signal = A*sin(f0*t);
signal_spec = fft(signal, N);

audiowrite('sinusoida.wav', signal, fd, 'BitsPerSample', 64);

singal_clipped = signal .* (signal <=2 & signal >= -2) + 2 .* (signal >2) + (-2) * (signal < -2);
singal_clipped_spec = fft(singal_clipped, N);

figure;
plot(t, signal, t, singal_clipped);
xlabel('t'); ylabel('A'); title('signal & clipped signal');

figure;
plot(t, real(signal_spec), t, real(singal_clipped_spec));
xlabel('f'); ylabel('A'); title('signal spectr & clipped signal spectr');

sound(singal_clipped, fd);

%% Task 3
clear; clc; close all;

[signal, fd] = audioread('task3.wav');
% N -- number of audio samples, 2 -- number of audio channels????

N = length(signal);

n = 1:N;
signal_spec = fft(signal, N);
figure;
plot(n, signal);
xlabel('n'); ylabel('A'); title('signal');

figure;
plot(n, signal_spec);
xlabel('n'); ylabel('A'); title('signal spectr');

%sound(signal, fd);

N1 = round(N/2);
signal1 = zeros(N1, 2);
for itter = 1 : N1-1
    signal1(itter, :) = signal(itter * 2, :);
end

n1 = 1:N1;
figure;
plot(n1, signal1);
xlabel('n'); ylabel('A'); title('signal1');

figure;
plot(n1, fft(signal1));
xlabel('n'); ylabel('A'); title('signal1 spectr');

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

n2 = 1:N2;

figure;
plot(n2, signal2);
xlabel('n'); ylabel('A'); title('signal2');

figure;
plot(n2, fft(signal2));
xlabel('n'); ylabel('A'); title('signal2 spectr');

%sound(signal2, fd*2)

