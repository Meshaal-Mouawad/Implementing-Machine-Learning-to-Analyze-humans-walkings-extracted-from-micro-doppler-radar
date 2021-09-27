
clear all;
close all;
fname = 'MP2_STFT_Data.mat';
load(fname);
N = 512;
B = 50.0;
tau = 1.5;
sigma = 0.05
%
% Determine the sampling rate fs in Hz and sampling interval Ts in seconds
%
Ts = 0.0040;
fs = 1/Ts;
%
% Gaussian windows
%
tprime = t - 1.0;
g = exp(-0.5*(tprime .^ 2)/(sigma ^2));
%
% Determine extent of signal
%
indx1 = find(g > 1e-3);
g1 = g(indx1);
pulse = (tprime >= (-tau/2)) .* (tprime <= (tau/2));
x = exp(-1i*2*pi*(B/tau)*(tprime.^2)) .* pulse;
noise_variance = 0.01;
noise = randn(size(x))*sqrt(noise_variance/2) + 1i*randn(size(x))*sqrt(noise_variance/2);
x = x + noise;
% Plot data
figure
plot(t,abs(x));
xlabel('t (sec)');
ylabel('x(t)');
title('LFM pulse (time domain)');
[s1,t,f] = DSP_stft(x, g1, fs, N);
plot_STFT(t, f/1e3, 20*log10(abs(s1)),'t (sec)', 'f (kHz)', ...
sprintf('STFT Magnitude (dB) sigma = %.2f', sigma), 1);