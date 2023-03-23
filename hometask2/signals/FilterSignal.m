function FilteredNoisedSignal = FilterSignal(NoisedSignal, wpass, coef)
%FILTERSIGNAL realization of Low-pass filtration
%   filters the input NoisedSignal using a lowpass filter with 
%   passband frequency wpass with coefficient coef

NoisedSignalSpec = fft(NoisedSignal);

filtered = ones(1, wpass);
passed = ones(1, length(NoisedSignalSpec) - wpass) * (1 - coef);
FilterSpec = cat(2, filtered, passed);

FilteredNoisedSignalSpec = NoisedSignalSpec .* FilterSpec;

FilteredNoisedSignal = ifft(FilteredNoisedSignalSpec);

end

