%__________________________________________________________________________
%
% Description: 
%
%   Function plots SVM discriminant (two-class problem).
%
% Inputs:  x     -  Input vector.
%          c     -  Class labels (-1 and 1).
%          model -  Liblinear model.
%          pstr  -  String for plot title.
%
% Outputs: Plot.
%
% References: None
%
% Change History:
%
% 22 July 2020 - Original
%
% Authors:
% John Ball
%__________________________________________________________________________
%
function plot_svm_discriminant(x, c, model, pstr)

%
% Force c to column vector
%
c = c(:);

%
% Calcualte discriminant function
%
b = model.bias;
w = model.w;
w = w(1:model.nr_class);
d = x * (w') + b;

%
% Number of bins for the estimation
%
nbins = 31;
dmax = max(d);
dmin = min(d);
bins = linspace(dmin, dmax, nbins);

%
% Plot each one
%
figure;
legendstr = {};
plot_indx = 1;
for k = unique(c)'
   
   %
   % Find instance of this class
   %
   indx = find(c == k);
   
   if ~isempty(indx)
      dk = d(indx);
      hk = hist(dk, bins);
   end
   
   if k == -1
      pcolor = 'g';
   else
      pcolor = 'r';
   end
   
   plot(bins, hk, pcolor);
   hold on;
   
   legendstr{plot_indx} = sprintf("Class %d", k);
   plot_indx = plot_indx + 1;
   
end

legend(legendstr);
xlabel('x');
ylabel('d(x)');
title(pstr);
drawnow;

