function plot_STFT(t, f, s, fig_xlabel, fig_ylabel, fig_title, do_colorbar)
%__________________________________________________________________________
%
% Description: 
%
%   Plots spectrogram and labels figure.
%
% Inputs:
%
%   t           -   Time axis labels in seconds.
%   f           -   Frequency axis labels.
%   s           -   Spectrogram (magnitude of STFT). 2D matrix.
%   fig_xlabel  - String with label for x axis.
%   fig_ylabel  - String with label for y axis.
%   fig_title   - String with plot title.
%   do_colorbar - Set to 1 to plot colorbar.
%
% Outputs: 
%
%   plot.
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
figure
imagesc(t,f,s);
h = gca;
yy = get(h, 'YTickLabel');
LL = size(yy,1);
if (do_colorbar)
   colorbar('vert');
end
for k = 1 : LL
   YTickLabelNew(k,:) = yy(LL - k + 1,:);
end
set(gca, 'YTickLabel', YTickLabelNew);
xlabel(fig_xlabel);
ylabel(fig_ylabel);
title(fig_title);
drawnow;
