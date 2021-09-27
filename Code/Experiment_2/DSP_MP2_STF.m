
%__________________________________________________________________________
%
% Description:
%
% Digital Signal Processing - Mini Project 2 STFT analysis.
%
% Instructions - some code missing. Search for "XXX" and edit code.
%
% Inputs: Reads the file "MP2_STFT_Data.mat" which must be in the same
% directory as this code.
%
% Outputs: Graphs, outputs to screen.
%
% Change History:
%
% 29 September 2020 - Original
%
% Authors:
% John Ball
%__________________________________________________________________________
%
clc
clear varaibles
close all
%
% Load data.
% x - vector of signal data.
% t - vector of times in seconds for sampling points of data.
%
fname = 'MP2_STFT_Data.mat';
load(fname);
%
% Determine the sampling rate fs in Hz and sampling interval Ts in seconds
%
Ts = 0.0040;
fs = 1/Ts;
fprintf('The sampling rate is %.2f Hz and sampling interval is %.2f milliseconds.\n', ...
fs, Ts * 1000);
%
% FFT size for STFT
%
N = 256;
%
% Sigma values - spoecifies the STFT
%
sigma = 0.5
%
% Gaussian windows
%
tprime = t - mean(t);
g = exp(-0.5*(tprime .^ 2)/(sigma ^2));
%
% Determine extent of signal
%
indx1 = find(g > 1e-3);
g1 = g(indx1);
%
% Plot window in time.
%
figure
plot(tprime, g);
xlabel('t (sec)');
ylabel('G{_\sigma}(t)');
title('Gaussian time domain window.');
drawnow;
fprintf('\nGaussian window sigma = %.4f.\n', sigma);
fprintf('Gaussian window length = %d samples.\n', length(g1));
%
% Plot data
%
figure
plot(t,x);
xlabel('t (sec)');
ylabel('x(t)');
title('Data signal (time domain)');
%
% Calculate STFT and plot it
%
[s1,t,f] = DSP_stft(x, g1, fs, N);
plot_STFT(t, f/1e3, 20*log10(abs(s1)),'t (sec)', 'f (kHz)', ...
sprintf('STFT Magnitude (dB) sigma = %.2f', sigma), 1);
epsilon = 1*10^-3 ;
Twin = 2* sigma*sqrt(-2*log(epsilon))
Nwin = ceil(Twin/ Ts)
