function [NoisedSignal, Noise] = NoiseGenerator(Signal, SNR)

Noise_mat = normrnd(0, 1, 2, length(Signal));
Noise(1:length(Signal)) = Noise_mat(1, 1:length(Signal)) + 1i .* Noise_mat(2, 1:length(Signal));

E_signal = sum(abs(Signal) .^ 2);
E_noise = sum(abs(Noise) .^ 2);

alpha = sqrt(E_signal / (db2mag(SNR) * E_noise) );

Noise(1:length(Signal)) = alpha * Noise(1:length(Signal));

NoisedSignal(1:length(Signal)) = Signal(1:length(Signal)) + Noise(1:length(Signal));
end

