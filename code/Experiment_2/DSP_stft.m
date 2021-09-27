function [S,t,f] = DSP_stft(x,w,fs,N)
%__________________________________________________________________________
%
% Description: 
%
%   STFT with stride = 1
%
% Inputs:
%
%   x   -   Input signal vector.
%   w   -   Spectrogram window (odd length).
%   fs  -   Sampling rate in Hz.
%   N   -   Number of points in FFT.
%
% Outputs: 
%
%   S   -   Spectrogram (magnitude of STFT)
%   t   -   Time axis labels in seconds.
%   f   -   Frequency axis labels.
%
% References:
%
% Change History:
%
% 09 Oct 2016 - Original
%
% Authors:
% John Ball
%__________________________________________________________________________
%

%
% Calculate Ts from fs
%
Ts = 1.0 / fs;

%
% Zero pad the signal on both sides
%
L = length(w);
Lmid = floor((L+1)/2);
tmid = (Lmid-1)*Ts;

xpad = [zeros(1,Lmid) x zeros(1,Lmid)];

%
% Set time indices in seconds
%
tpad = -tmid + Ts * [0 : (length(xpad)-1)];

%
% Set frequency indices in Hz
%
f = fs * (((N-1)/2) : -1: (-N/2)) / N;

%
% Perform FFTs
%
indx = 1:length(w);
NN = 1 : (length(xpad)-length(w)+1);
S = zeros(N, length(NN));
for n = NN
   
   %fprintf('\nn = %d of %d', n, length(NN));
   
   %
   % Signal portion to analyze
   %
   xa = xpad(indx);
   indx = indx + 1;
   
   %
   % Calculate STFT
   %
   S(:,n) = flipud(abs(fftshift(fft(xa .* w, N)))');
   pause(0.0000001);
   
end

%
% Time indices
%
t = tpad;
